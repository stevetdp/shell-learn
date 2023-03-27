## 1. 安装package control
手动安装Package Control， 参考：https://packagecontrol.io/installation

## 2. 给package control设置代理
执行下列快捷键：
```sh
Ctrl+Shitf+P
```
打开弹出窗口，输入"Perferences: Package Control Settings", 将会打开Package Control.sublime-settings

然后在里面输出代理配置
```
{
     "http_proxy": "host:port",
     "proxy_username": "xxx",
     "proxy_password": "xxxx"
}
```

或者

Click the Preferences > Browse Packages… menu
Enter the User directory

Open Package Control.sublime-settings

Add the following JSON entries to the file:

http_proxy - your proxy address/port (x.x.x.x:port)
proxy_username - the user name for authentication
proxy_password - the password

## 3. 安装包
执行下列快捷键：
```sh
Ctrl+Shitf+P
```
打开弹出窗口，输入"Package Control: Install Package", 然后再输入包名即可安装。 
