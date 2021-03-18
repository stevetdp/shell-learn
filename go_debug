1. delve工具不能attach

```sh
[root@localhost ~]# ./dlv attach xxx
could not attach to pid xxx: could not open debug info
```

原因：https://github.com/go-delve/delve/issues/1698

I rebuilt using (-gcflags "-N -l") and am able to attach.
you should really be using -gcflags='all=-N -l'

查看DWARF
[root@localhost ~]# file EXE 
EXE: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, stripped
