# 1.  NGINX对eventfd的事件驱动扩展接口定义
ngx_event.c 中定义了事件驱动扩展宏

```
typedef struct {
    ngx_int_t     (*add)(ngx_event_t *ev);
    ngx_int_t     (*del)(ngx_event_t *ev);
    ngx_int_t     (*notify)(ngx_event_t *ev);
    ngx_event_t  *(*init)(ngx_event_handler_pt handler, void *data, ngx_int_t startup);
    void          (*done)(ngx_event_t *ev);
    void          (*set)(ngx_event_t *ev, ngx_event_handler_pt handler);
} ngx_event_actions_extend_t;
.....
ngx_event_actions_extend_t ngx_event_actions_extend;
.....
#define ngx_event_init_extend ngx_event_actions_extend.init
#define ngx_notify_extend     ngx_event_actions_extend.notify
#define ngx_add_event_extend  ngx_event_actions_extend.add
#define ngx_del_event_extend  ngx_event_actions_extend.del
#define ngx_done_extend       ngx_event_actions_extend.done
#define ngx_set_extend        ngx_event_actions_extend.set
```


# 2.  NGINX对eventfd的epoll事件驱动扩展接口定义
ngx_epoll_module.c中定义了对eventfd的epoll事件驱动编程的扩展`ngx_event_actions_extend = ngx_epoll_actions_extend`

```
static ngx_event_actions_extend_t  ngx_epoll_actions_extend = {
    ngx_epoll_add_event_extend,
    ngx_epoll_del_event_extend,
    ngx_epoll_notify_extend,
    ngx_epoll_init_extend,
    ngx_epoll_done_extend,
    ngx_epoll_set_handler_extend
};

static ngx_int_t
ngx_epoll_module_init(ngx_cycle_t *cycle)
{
#if (NGX_HAVE_EVENTFD)
    notify_log = cycle->log;
    ngx_event_actions_extend = ngx_epoll_actions_extend;
#endif
    return NGX_OK;
}

ngx_module_t  ngx_epoll_module = {
    NGX_MODULE_V1,
    &ngx_epoll_module_ctx,               /* module context */
    ngx_epoll_commands,                  /* module directives */
    NGX_EVENT_MODULE,                    /* module type */
    NULL,                                /* init master */
    ngx_epoll_module_init,               /* init module */
    NULL,                                /* init process */
    NULL,                                /* init thread */
    NULL,                                /* exit thread */
    NULL,                                /* exit process */
    NULL,                                /* exit master */
    NGX_MODULE_V1_PADDING
};
```

# 3.  NGINX对eventfd的epoll事件驱动的定义的说明

## 3.1 初始化eventfd的epoll事件驱动

1. 定义fd, 定义ngx_event_t并设置ev->data和ev->handler
2. 调用ngx_epoll_add_event_extend, 该函数调用epoll_ctl将fd添加到epoll中；
3. eventfd一直可写，当写后触发epoll可读事件时，将回调入参中的handler，handler的入参为nginx_event_t，它的ev->data为入参data或者c，

```
static ngx_event_t *
ngx_epoll_init_extend(ngx_event_handler_pt handler, void *data, ngx_int_t startup)
{
    int                fd;
    ngx_event_t       *ev;
    ngx_connection_t  *c;
    u_char            *tmp;

#if (NGX_HAVE_SYS_EVENTFD_H)
    fd = eventfd(0, EFD_NONBLOCK);
#else
    fd = syscall(SYS_eventfd, EFD_NONBLOCK);
#endif

    if (fd == -1) {
        ngx_log_error(NGX_LOG_EMERG, notify_log, ngx_errno, "eventfd() failed");
        return NULL;
    }

    tmp = ngx_calloc(sizeof(ngx_event_t) + sizeof(ngx_connection_t), notify_log);
    if (tmp == NULL) {
        close(fd);
        return NULL;
    }

    ev = (ngx_event_t *)tmp;
    c  = (ngx_connection_t *)(tmp + sizeof(ngx_event_t));

    ev->handler = ngx_epoll_notify_handler_extend;
    ev->log     = notify_log;
    ev->active  = 1;
    ev->data    = data ? data : c;

    c->fd       = fd;
    c->read     = ev;   //eventfd因为是一直可写的，没有必要定义写事件，这里只定义读事件
    c->log      = ev->log;
    c->data     = handler;

    if (startup && ngx_epoll_add_event_extend(ev) != NGX_OK) {
        ngx_free(tmp);
        close(fd);
        return NULL;
    }

    return ev;
}
```

## 3.2 epoll通知eventfd事件可读

eventfd句柄一直可写，这里通过ngx_epoll_notify_extend向eventfd中写入值；等待epoll通知eventfd可读事件， 读事件的回调函数为ngx_epoll_init_extend传递进去的handler;。

```
static ngx_int_t
ngx_epoll_notify_extend(ngx_event_t *ev)
{
    static uint64_t       inc = 1;
    ngx_connection_t     *c;
    size_t                n;

    c = (ngx_connection_t *)((u_char *)ev + sizeof(ngx_event_t));

    n = write(c->fd, &inc, sizeof(uint64_t));
    if (n != sizeof(uint64_t)) {
        ngx_log_error(NGX_LOG_ALERT, ev->log, ngx_errno, "write() to eventfd %d failed", c->fd);
        return NGX_ERROR;
    }

    return NGX_OK;
}
```

## 3.3 关闭eventfd事件驱动

关闭连接，关闭eventfd，释放事件。

```
static void
ngx_epoll_done_extend(ngx_event_t *ev)
{
    ngx_connection_t     *c;

    if (ev == NULL) {
        return;
    }

    c = (ngx_connection_t *)((u_char *)ev + sizeof(ngx_event_t));

    c->write = c->read;

    if (ev->timer_set) {
        ngx_del_timer(ev);
    }

    ngx_epoll_del_connection(c, 0);
    close(c->fd);

    ngx_free(ev);
}
```




