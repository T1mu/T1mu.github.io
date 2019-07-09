---
title: " 搭建Shadowsocks(R)服务器-掌控自己的小梯子\t\t"
tags:
  - Bandwagon
  - ShadowsocksR
  - 服务器
  - 翻墙
url: 65.html
id: 65
categories:
  - Shadowsocks
date: 2019-04-29 14:36:51
---

缘由：
---

搬瓦工（Bandwagon）的服务器给出的一键搭建SS只能在**Centos 6** 系统上运行，因为我将服务器换成了Ubuntu 16.04，所以不能一键搭建了，遂捣鼓

![](http://timj3ly.com/wp-content/uploads/2019/04/image.png)

搬瓦工提供的一键搭建服务  

准备工作：
-----

1.  有一台自己的**境外服务器**（我用的bandwagon）；
2.  **Xshell**或其他可以ssh你的服务器的软件；

Quick Start-快速开始：
-----------------

这里用到的是github上**doubi**大佬的一键脚本

因为其他原因，此人的搭建脚本已经不更新了，github也已不是本人维护了，他的github地址： [https://github.com/ToyoDAdoubi/](https://github.com/ToyoDAdoubi/)

*   打开Xshell或其他可以ssh服务器的软件：

![](http://timj3ly.com/wp-content/uploads/2019/04/image-1.png)

Xshell登录界面  

*   输入服务器root密码后即可进入shell命令行：

![](http://timj3ly.com/wp-content/uploads/2019/04/image-2.png)

*   在命令行输入：

    wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssr.sh && chmod +x ssr.sh && bash ssr.sh

![](http://timj3ly.com/wp-content/uploads/2019/04/image-3.png)

*   输入1，**端口号/密码** 自行选择，其他配置安装我的配置来即可完成ss的服务器搭建（降低ip被墙的概率）

![](http://timj3ly.com/wp-content/uploads/2019/04/image-4.png)

Shadowsocks配置详情

*   最后在Shadowsocks或ShadowsocksR上配置服务器即可翻墙

![](http://timj3ly.com/wp-content/uploads/2019/04/image-5.png)

shadowsocks配置图