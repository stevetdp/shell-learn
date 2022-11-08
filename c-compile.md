## 预处理
```shell
gcc -E -P xxx.c
## -E 告诉GCC在预处理后停止， -P 使GCC忽略调试信息，以便输出更清晰
```
## 编译
### 汇编
```shell
gcc -S -masm=intel xxx.c
## -S 告诉GCC进行汇编后停止，-masm-intel告诉GCC以intel的语法而不是默认的AT&T语法翻译汇编语言。
```


## 程序动态加载
- [ldfcn.h](https://pubs.opengroup.org/onlinepubs/7908799/xsh/dlfcn.h.html)
