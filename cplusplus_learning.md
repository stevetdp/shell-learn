## 常量表达式
可以通过编译时确定值。 由于有初始化数据段存在，在编译时可以推导出它的常量表达式值。

```shell
一个进程的地址空间由4个主要部分构成：程序指令、初始化数据、未初始化数据和栈。
在UNIX的行话中，指令（instruction）也叫做“正文”段，而初始化数据和栈可以分别简称为“数据”段和“栈”段。
未初始化数据则叫做“bss”，它的名字来源于一种叫做“Block Started by Symbol”的古老的汇编程序助记符，这个助记符用于分配未初始化的数据空间。
初始化数据和未初始化数据之间的区别在于，初始化数据是在程序编译时已经声明有一个初始值的全局和静态程序变量。
未初始化数据是没有明确初始值的全局和静态程序变量。
对于这些数据，UNIX系统仅仅依照C程序设计语言（UNIX系统几乎都是用这种语言编写的）的语义在地址空间中分配初始包含 0 的内存。
这种方法的优点是未初始化数据不需要在程序文件中占用空间。
```

## C语言变长数组
在ｃ++的标准中确实规定了：定义数组时，元素个数必须是常量表达式，在编译时求值。但c++11对c99的编译器扩展:
- c99中引入了变长数组的概念，在ｃ99的技术手册中说明了数组的长度可以为变量的，称为变长数组（VLA，variable length array）。（注：这里的变长指的是数组的长度是在运行时才能决定，但一旦决定在数组的生命周期内就不会再变。）
- 在 GCC 标准规范的 6.19 Arrays of Variable Length 中指出，作为编译器扩展，GCC 在 C90 模式和 C++ 编译器下遵守 ISO C99 关于变长数组的规范。

变长数组肯定是有好处的，它可以实现与alloca一样的效果，在栈上进行动态的空间分配，并且在函数返回时自动释放内存，无需手动释放。但是记住，这个是c99的标准，不是c++的，也就是说有的ｃ++编译器上并不支持。而且[谷歌的c++编程规范](https://zh-google-styleguide.readthedocs.io/en/latest/google-cpp-styleguide/others/#alloca)也不推荐。

## C语言中的零长数组
零长数组在ISO C与C++的规格说明书中是不允许的，gcc 为了预先支持C99的这种玩法，所以，让“零长度数组”这种玩法合法了。关于GCC对于这个事的文档在这里：“Arrays of Length Zero”。
```c++
#include <stdlib.h>
#include <string.h>
 
struct line {
   int length;
   char contents[0]; // C99的玩法是：char contents[]; 没有指定数组长度
};
 
int main(){
    int this_length=10;
    struct line *thisline = (struct line *)malloc (sizeof (struct line) + this_length);
    thisline->length = this_length;
    memset(thisline->contents, 'a', this_length);
    return 0;
}
```
sizeof(struct line)的结果为sizeof(int)，因为另一个元素零长数组不占空间，数组名data是一个地址常量，标识着成员变量length后面的那个地址，但其本身并不占空间。
上面这段代码的意思是：我想分配一个不定长的数组，于是我有一个结构体，其中有两个成员，一个是length，代表数组的长度，一个是contents，代表数组的内容。后面代码里的this_length（长度是10）代表是我想分配的数据的长度。（这看上去是不是像一个C++的类？）这种玩法英文叫：Flexible Array，中文翻译叫：柔性数组。
参考：https://xhy3054.github.io/c-ArrayOfVariableLength/


