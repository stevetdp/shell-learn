1. [Programming with POSIX Threads. Addison-Wesley](https://ptgmedia.pearsoncmg.com/images/9780201633924/samplepages/0201633922.pdf)
2. [POSIX Threads Programming](https://www.cin.ufpe.br/~rngs/Arquivos/pthreads/pthreads.pdf)
3. http://www.cs.unibo.it/~ghini/didattica/sistop/pthreads_tutorial/POSIX_Threads_Programming.htm
4. [C Storage-class specifiers](https://en.cppreference.com/w/c/language/storage_duration)
   - _Thread_local - thread storage duration (since C11)
6. [C++ https://en.cppreference.com/w/c/language/storage_duration](https://en.cppreference.com/w/cpp/language/storage_duration)
   - thread_local - thread storage duration. (since C++11)
7. C SEM(信号量)
   - sem_getvalue(sem_t *sem, int *sval)
   - sem_post(sem_t *sem)
   - sem_wait(sem_t *sem)
   - sem_trywait(sem_t *sem)
   - sem_timedwait(sem_t *sem, const struct timespec *abs_timeout)
   - sem_overview
8. pthread condition variable
   - pthread_cond_wait()： 当条件不成立时，条件变量可以阻塞当前线程，所有被阻塞的线程会构成一个等待队列，当前线程sleep，并释放锁；唤醒：重新获取锁。
   - pthread_cond_signal(): 条件OK，唤醒条件变量上阻塞队列中的sleep线程。pthread_cond_signal() 函数至少解除一个线程的“被阻塞”状态，如果等待队列中包含多个线程，优先解除哪个线程将由操作系统的线程调度程序决定；
   参考： http://c.biancheng.net/view/8633.html
   
9. 进程与线程栈
   - 进程栈大小时执行时确定的，与编译链接无关
   - 进程栈大小是随机确认的，至少比线程栈要大，但不会超过2倍
   - 线程栈是固定大小的，可以使用ulimit -a 查看，使用ulimit -s 修改
      - pthread_attr_t可以指定线程栈大小
   - 一般默认情况下，线程栈是在进程的堆中分配栈空间(通过mmap()分配)，每个线程拥有独立的栈空间，为了避免线程之间的栈空间踩踏，线程栈之间还会有以小块guardsize用来隔离保护各自的栈空间，一旦另一个线程踏入到这个隔离区，就会引发段错误。
   - 每一个线程都是使用clone()系统调用从main线程克隆出来的, 因此会共享进程地址空间和资源。与fork()系统调用不同，资源(比如句柄)不会克隆出两份出来.
