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
