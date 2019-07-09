---
title: " IP被封 Cloudflare中转V2Ray拯救你的国外VPS-IP\t\t"
url: 106.html
id: 106
categories:
  - V2Ray
  - 远程服务器
date: 2019-06-08 12:48:14
tags:
---

*   检测IP在国内是否被墙:([www.ping.pe](http://www.ping.pe))

![](http://timj3ly.com/wp-content/uploads/2019/06/image.png)

ping.pe网站  

![](http://timj3ly.com/wp-content/uploads/2019/06/image-1.png)

IP测试结果图  

若国内服务器ping均不通的某地址（右侧显示均为红色矩形），可以断定此地址在国内被墙

*   准备工作：
*   域名一枚\\VPS一台

如果读者没有个人域名，可以在Godaddy\\阿里云\\其他渠道购买（有免费域名，请自行查找）。

笔者用的是Godaddy的域名和BandwagonVPS一台。

*   具体工作：
*   登入CloudFlare（[www.cloudflare.com](http://www.cloudflare.com)）

![](http://timj3ly.com/wp-content/uploads/2019/06/image-2.png)

cloudflare官网  

注册并登入

![](http://timj3ly.com/wp-content/uploads/2019/06/image-3.png)

  

在DNS中键入读者的域名与IP地址

![](https://eveaz.com/wp-content/uploads/2019060411.jpg)

修改DNS服务器

复制To选框下的内容至读者域名服务商的DNS域名服务器

![](http://timj3ly.com/wp-content/uploads/2019/06/image-4.png)

DNS管理界面  

*   在VPS上搭建V2Ray

ROOT权限SSH登录到VPS，运行脚本

bash <(curl -s -L https://git.io/v2ray.sh)

默认配置运行下去即可

成功界面如下：

![](http://timj3ly.com/wp-content/uploads/2019/06/image-5.png)