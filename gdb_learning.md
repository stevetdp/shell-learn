## 1.  Debug bazel cc_test

前提：  设置编译参数 -g

1.  bazel test xxx 
2.  gdb  <bazel-bin/xxx/生成测试二进制>
3.  打断点： b xx
4.  运行: run
5.  单步调试： n
6.  打印变量值： p xxx
7.  观察变量值： watch xxx
8.  单步进入函数: s
9.  反汇编： disassemble
10. 查看寄存器： info registers
11. 打印结构体布局： ptype /o  xxx

## 2. 内容比较：
使用sumlime, 选中两个文件， diff files...


## 3. x命令的使用：

Examine memory, 使用格式为：x/FMT ADDRESS, 其中FMT中三部分组成：[count][format][size].(format与size的参数位置可以互换）

例如： `x/10xw &a`, 查看从&a开始的连续10 * 4 个字节的内存，以十六进制显示出来。

count: 表示重复查看的数目，也就是一次性要看多少单位的内存。

format 表示要显示的格式， 如以下几种：

|format|	含义|
|------|------|
|o	|octal, 即八进制|
|x	|hex, 十六进制|
|d	|decimal, 十进制|
|u	|unsigned decimal|
|t	|binary, 二进制|
|f	|float, 符号数|
|a	|address, 地址的形式|
|c	|char类型|
|s	|string|
|z	|hes, zero padded on the left|

Size: 表示每一次显示的单位大小。有以下几种：

|Size	|含义|
|------|----|
|b	|byte, 一个字节大小|
|h	|half word, 半个字大小，2个字节|
|w	|word, 一个字大小，4个字节|
|g	|giant, 8个字节|
