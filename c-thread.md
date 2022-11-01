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
