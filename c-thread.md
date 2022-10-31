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
