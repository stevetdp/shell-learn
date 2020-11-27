###  WAL(Write-Ahead Log)

1. [breaking-the-wiredtiger-logjam-the-write-ahead-log](https://engineering.mongodb.com/post/breaking-the-wiredtiger-logjam-the-write-ahead-log-1-2)

   1. 引入slot，多线程将数据写入到buffer中，最后再full-sync到操作系统文件上
   2. 使用位视图和位偏移实现多个计数器的在两同一个变量中实现原子操作。减少了多线程场景下因为CPU繁忙导致CAS原子操作时的busy。
   3. 使用50ms超时来解决空闲时full-sync问题

2. [wiredtiger 存储引擎原理](https://yq.aliyun.com/articles/255163)

### LSM Tree

1. [LSM Tree 论文](https://www.cs.umb.edu/~poneil/lsmtree.pdf)
2. [LSM Tree的理解](http://www.importnew.com/28083.html)

### Mongodb 索引

1. [MongoDB索引原理](https://yq.aliyun.com/articles/643756?spm=a2c4e.11153959.0.0.55fd8cb6FTX9YY)

### Sharded cluster

1. [MongoDB Sharded cluster架构原理](https://yq.aliyun.com/articles/32434?spm=a2c4e.11153940.blogcont60096.5.4fb078ddnEXTiD)

    1. mongos, config server, shard（replica set)
    2. 按shardkey进行数据分区partition。shardkey可以经过hash function转换为int型，内部按range进行范围分片。
    3. 按range分片，每一个chunk对应一个范围。 
    4. 如果chunk容量过满，则chunk在自身范围内进行分裂，再细划出N个小范围chunk。让存储容量空间扩大N倍。
    5. 当各个shard上chunk数量不均衡时，会触发chunk在shard间的迁移
    6. database开启分片， collection开启数据分片
    
2.  一些约束
    1.  shardkey有512字节的长度限制
    2.  shardkey必须是索引
    3.  必须根据操作来合理建立shardkey和索引，否则会引起慢操作
    3.  开源的driver:  mongo driver/mgo driver
    
3.  mgo driver注意事项：
    1. mongoServer.AcquireSocket中会通过PoolLimit对最大连接数做限制，但在大并发下其mongoServer.Connect()会不受PoolLimit控制
    2. mongos采用的是同步线程模型，但可以配置mongos的最大连接数，避免连接数冲高
    3. mongos出现慢操作后，driver会出现超时。这时会删除掉该socket，并通知cluster释放server。容易触发问题1
    4. driver提交到mongos的任务，如果提前结束， mongos的线程依然不会立即释放，会等写完shard后才能释放

4. [MongoDB Multi-Data Center Deployments](http://s3.amazonaws.com/info-mongodb-com/MongoDB_Multi_Data_Center.pdf)

    1. 将shard副本集分散到不同的数据中心
    
### 分布式存储

1. 提供数据块的EC
2. 上层业务管理数据块的申请、引用、GC(数据块的合并、删除)
   
