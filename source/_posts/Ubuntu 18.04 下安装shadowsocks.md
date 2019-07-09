---
title: " Ubuntu 18.04 下安装shadowsocks"
tags:
  - Linux
  - Shaodowsocks
  - sslocal
  - ubuntu
url: 12.html
id: 12
categories:
  - Linux
date: 2019-01-17 13:27:03
---

方法
--

### 1\. 下载所需工具

pip 和 shadowsocks

    sudo apt-get install python-pip
    sudo pip install shadowsocks

缺什么下什么就对了

### 2\. 配置

    sudo emacs /etc/shadowsocks.json
    
    {
        "server":"my_server_ip",
        "server_port":8388,
        "local_address": "127.0.0.1",
        "local_port":1080,
        "password":"mypassword",
        "timeout":520,
        "method":"aes-256-cfb",
    }

缺emacs就装emacs

![![在这里插入图片描述](https://img-blog.csdnimg.cn/20190117205626730.png](https://img-blog.csdnimg.cn/2019011720585319.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

编辑文件如下图所示：  
  
（此处截图使用的是Flameshot）

### 3\. 启动

    sslocal -c /etc/shadowsocks.json

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190117210031659.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

4\. 系统配置
--------

![在这里插入图片描述](https://img-blog.csdnimg.cn/2019011721015952.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

如图所示：  

挖坑：自动网络代理如何设置（像windows一样的自动切换全局和局部）