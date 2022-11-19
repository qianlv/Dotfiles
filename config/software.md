### 命令行工具

1. cppman 查询C++库

2. icdiff diff 升级

3. tldr 查询命令的常见用法

4. axel 多线程断点下载工具

5. jq 格式化json文件显示, python -m json.tool

6. lrzsz 跳板机文件传输工具, rz, sz

7. fanyi 翻译: https://github.com/afc163/fanyi

8. ubuntu 挂载 smb, nfs
  
  1. install  cifs-utils, nfs-common
  
  2. ```
     在 /etc/fstab 中添加:
     //192.168.1.209/public /media/NAS cifs guest,uid=1000,gid=1000,iocharset=utf8 0 0
     这里uid和gid 可以通过id -u 或 id -g 获取
     //192.168.7.2/d /home/qianlv/Smbs/D cifs username=qianlv,password=123456,uid=1000,gid=1000,iocharset=utf8 0 0
     
     # https://linuxopsys.com/topics/linux-nfs-mount-entry-in-fstab-with-example
     nfs: 挂载格式
     192.168.7.154:/MyHome/OutSource /home/qianlv/OutSource nfs auto,nofail,noatime,nolock,_netdev  0 0
     192.168.7.154:/Qianlv /home/qianlv/MyHome nfs soft,intr,nosuid,timeo=3,retrans=3,tcp  0 0
     
     mac smbfs:
     	mount_smbfs -f 0644 -d 0755 '//[user:password]@192.168.7.154/Qianlv' /Users/qianlv/MyHome
     	password 有特殊字符时参考 https://stackoverflow.com/questions/27026168/escape-special-characters-in-mount-command
     	node -e 'console.log(encodeURIComponent(password))'
     	参考:  https://gist.github.com/natritmeyer/6621231
      
      
     参考 [Ubuntu Mount Wiki](https://wiki.ubuntu.com/MountWindowsSharesPermanently) , [Mount on Ubuntu](https://askubuntu.com/questions/1050460/how-to-mount-smb-share-on-ubuntu-18-04)
     ```



11. [Ubuntu 4k 屏幕缩放设置](https://github.com/alex-spataru/HiDPI-Fixer)

12. 解决zsh在git项目导致卡顿
   ```
        git config --add oh-my-zsh.hide-status 1
        git config --add oh-my-zsh.hide-dirty 1
   ```
[oh-my-zsh-slow-but-only-for-certain-git-repo](https://stackoverflow.com/questions/12765344/oh-my-zsh-slow-but-only-for-certain-git-repo)

13. [how2](https://github.com/santinic/how2)

    ```
    npm install -g how-2
    ```
14. [Bashhub](https://github.com/rcaloras/bashhub-client) - Bash history in the cloud. Indexed and searchable.

### 终端

1. zsh 

   ```
   安装
      	sudo apt install zsh git
      
   oh-my-zsh
   	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
   
   修改Shell
   	
   	chsh -s /bin/zsh
   	
   sudo apt install autojump
   j dir 跳转
   
   
    # User configuration
    source $HOME/.user_config.zsh 
   
   ```
   
2. alias

   ```
   代理
   alias my_proxy="export ALL_PROXY=socks5://192.168.2.106:1087"
   ```


### 软件

- [JustVita/Excellent-software: 收集那些优秀的软件（Windows & Mac & Android & Chrome Plugins） (github.com)](https://github.com/JustVita/Excellent-software)
- [Sumatra PDF](https://www.sumatrapdfreader.org/download-free-pdf-viewer.html) windows
- [Windows terminal](https://github.com/microsoft/terminal/releases) windows
- [Typora](https://typora.io/) windows, linux, mac(brew)
- [Logitech G HuB](https://www.logitechg.com.cn/zh-cn/innovation/g-hub.html) windows, mac
- [utools](https://u.tools/download.html) windows, linux, mac(brew)
- [Zeal](https://zealdocs.org/) windows, linux
- Dash mac(brew)
- [uPDF](https://www.52pojie.cn/thread-1082693-1-1.html) windows
- [ZYPlayer](http://zyplayer.fun/) windows, linux, mac
- IINA mac(brew)
- [Joplin](https://joplinapp.org/) windows, linux, mac(brew)
- [Notepad3](https://github.com/rizonesoft/Notepad3) windows
- [Workrave](https://workrave.org/download/) windows, linux
- [Stretchly](https://hovancik.net/stretchly/) Workrave Mac(brew) 下的替代品
- [Honeyview](https://cn.bandisoft.com/honeyview/) windows
- [PotPlayer](https://potplayer.daum.net/) windows
- [Uninstall-tool](https://crystalidea.com/uninstall-tool) windows
- [Geany](https://www.geany.org/download/releases/) windows, mac(brew)
- [Alacritty](https://github.com/alacritty/alacritty) windows, linux, mac(brew)
- [Terminus](https://github.com/Eugeny/terminus) windows, linux, mac(brew)
- [Mos](https://github.com/Caldis/Mos) mac(brew) 滚动平滑，完美啊
- Contexts mac(brew) 窗口切换和 windows 基本一样, brew cask install Contexts
- Moon mac
- Rectangle mac(brew) 类似 Windows 的窗口管理
- MonitorControl mac(brew)
- [Snipaste](https://zh.snipaste.com/) windows, linux, mac(brew)
- hiddenbar mac(brew)
- IDM windows
- Telegram windows(scoop), linux, mac(brew)
- [itsycal](https://www.mowglii.com/itsycal/) mac(brew)
- [Free Download Manager](https://www.freedownloadmanager.org/zh/) windows, linux, mac(brew)
- [超级右键](https://www.better365.cn/) mac
- Thunder windows, mac(brew)
- intellij-idea-ce windows, linux, mac(brew)
- [Pap.er](https://paper.meiyuan.in/) mac(brew)
- [Background-music](https://github.com/kyleneideck/BackgroundMusic) mac(brew)
- [GoldenDict](https://github.com/goldendict/goldendict) windows, linux, mac(brew)
- [Hackintool](https://github.com/headkaze/Hackintool) mac(brew)
- [TextMate](https://macromates.com/) mac(brew)
- [TimeMachineEditor](https://tclementdev.com/timemachineeditor/) 修改 TimeMachine 备份频率
- [PicGo](https://github.com/Molunerfinn/PicGo) 图床 windows, linux mac(brew)
- App Cleaner & Uninstaller mac
- [SwitchResX](https://www.madrau.com/) mac
- [Royal TSX](https://www.royalapps.com/ts/mac/download) windows, mac
- [neat download manager](https://www.neatdownloadmanager.com/index.php/en/) windows, mac
- [Dism++](https://link.zhihu.com/?target=https%3A//www.chuyu.me/zh-Hans/index.html)
- [Rufus](https://rufus.ie/zh_CN.html)：USB 系统启动/安装盘制作，开源、免费、纯净
- [dandanplay](http://www.dandanplay.com/) 本地视频在线弹幕播放器
- [火绒](https://www.huorong.cn/)
- [Revo Uninstaller]([Uninstall Software, Remove programs easily - Revo Uninstaller Pro](https://www.revouninstaller.com/))

### Mac

```
# 通过终端命令调整 Dock 栏的隐藏速度
defaults write com.apple.dock autohide-delay -int 0.5
killall Dock

# GNU 命令软件包
brew install coreutils
brew install gawk gnu-sed

# 禁止.DS_store生成
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
# 恢复.DS_store生成
defaults delete com.apple.desktopservices DSDontWriteNetworkStores

# mount nfts
# 找到硬盘路径
sudo diskutil list
sudo mount -t ntfs -o auto,rw,nobrowse /dev/disk## path

# brew 清除依赖
# https://superuser.com/questions/1509212/how-to-clean-unused-homebrew-dependencies
brew bundle dump
brew bundle --force cleanup 
# 另一个方法
# https://stackoverflow.com/questions/7323261/uninstall-remove-a-homebrew-package-including-all-its-dependencies

mac 下 gcc -fsanitize=address 检查内存泄漏, 参考:
https://clang.llvm.org/docs/AddressSanitizer.html#memory-leak-detection
ASAN_OPTIONS=detect_leaks=1 ./a.out

# 禁用splotlight服务（取消系统索引功能）
# 禁用
sudo mdutil -a -i off
# 启用
sudo mdutil -a -i on
```

## 字体

[Source Code Pro](https://github.com/adobe-fonts/source-code-pro)

[Cascadia Code](https://github.com/microsoft/cascadia-code)

[FiraCode](https://github.com/tonsky/FiraCode)

[字体库 nerd-fonts](https://github.com/ryanoasis/nerd-fonts), scoop

### Arch 安装

https://zhuanlan.zhihu.com/p/202914804 

### PowerShell

```

PowerShell 设置为Shell(Emacs)模式
Set-PSReadLineOption -EditMode Emacs
关闭警告声音
Set-PSReadlineOption -BellStyle Visual
powershell 配置文件位置: 在终端输入 $PROFILE 获取, 用exploer打开，加入上面配置即可
参考: https://github.com/PowerShell/PSReadLine
```

### Scoop

[官网](https://scoop.sh/)

```
# 安装
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex
# concfg
scoop install concfg
concfg import solarized-dark

# list all themes
concfg presets

# aria2 加速，默认开启
scoop install aria2
# 关闭 aria2
scoop config aria2-enabled false
# 参数
scoop config aria2-max-connection-per-server 16
scoop config aria2-split 16
scoop config aria2-min-split-size 1M
# 补全scoop 
scoop bucket add scoop-completion https://github.com/Moeologist/scoop-completion
scoop install scoop-completion
$PROFILE 添加
Import-Module C:\Users\qianlv\scoop\modules\scoop-completion
# 查看官方推荐仓库
scoop bucket known
# 添加仓库
scoop bucket add extras
scoop bucket rm extras
# 第三方仓库
scoop bucket add dorado https://github.com/chawyehsu/dorado
# 代理设置(htpp)
scoop config proxy 192.168.7.1:1081

# 安装的应用
  7zip 19.00 [main]
  adb 31.0.2 [main]
  aida64extreme 6.33.5700 [extras]
  alacritty 0.8.0 [extras]
  aria2 1.35.0-1 [main]
  cacert 2021-05-25 [main]
  clash-for-windows 0.15.9 [dorado]
  concfg 0.2021.05.09 [main]
  cpu-z 1.96.1 [extras]
  curl 7.77.0_2 [main]
  dandanplay 11.3.0 [dorado]
  dark 3.11.2 [main]
  deskpins 1.32 [extras]
  dismplusplus 10.1.1001.10 [extras]
  dos2unix 7.4.2 [main]
  draw.io 14.6.13 [extras]
  firacode 5.2 [nerd-fonts]
  git 2.31.1.windows.1 [main]
  grep 2.5.4 [main]
  hwmonitor 1.44 [extras]
  innounp 0.50 [main]
  intellij-idea-ce 2021.1.2 [dorado]
  joplin 1.8.5 [extras]
  lessmsi 1.8.1 [main]
  Licecap 1.28 [extras]
  listen1desktop 2.21.5 [extras]
  llvm 12.0.0 [main]
  make 4.3 [main]
  memreduct 3.3.5 [extras]
  neovim 0.4.4 [main]
  neteasemusic 2.8.0.198822 [dorado]
  nodejs 16.3.0 [main]
  notepad3 5.20.722.1 [extras]
  openjdk 16-36 [java]
  pandoc 2.14.0.1 [main]
  picgo 2.2.2 [dorado]
  postman 8.5.1 [extras]
  potplayer 210428 [extras]
  python 3.9.5 [main]
  qq 9.4.6.0 [dorado]
  renamer 7.3 [extras]
  rufus 3.14 [extras]
  scoop-completion 0.2.3 [scoop-completion]
  scrcpy 1.17 [main]
  snipaste-beta 2.5.6-Beta [dorado]
  sudo 0.2020.01.26 [main]
  sumatrapdf 3.2 [extras]
  TeamViewer 15.18.5 [extras]
  telegram 2.7.4 [extras]
  touch 0.2018.07.25 [main]
  TrafficMonitor 1.80.3 [dorado]
  typora 0.10.11 [extras]
  vcxsrv 1.20.9.0 [extras]
  vscode 1.56.2 [extras]
  wget 1.21.1-1 [main]
  workrave 1.10.45 [extras]
  zeal 0.6.1 [extras]
```

### Manjaro

1. [修改默认浏览器](https://www.rockyourcode.com/change-the-default-browser-in-i3-manjaro-linux/)
2. [一份别人的i3配置](https://zjuyk.gitlab.io/posts/i3wm-config/)

### Clash

```
# https://github.com/Fndroid/clash_for_windows_pkg/issues/1709
parsers: # array
  - url: ...
    yaml:
      prepend-rules:
        - DST-PORT,22,DIRECT
  - url: ...
    yaml:
      prepend-rules:
        - DST-PORT,22,DIRECT
```
