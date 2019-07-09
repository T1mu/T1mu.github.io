---
title: " 小狼毫自定义短语-Rime-双拼\t\t"
tags:
  - Rime
  - 小狼毫
  - 自定义短语
url: 19.html
id: 19
categories:
  - Software
date: 2018-11-03 14:18:06
---

![作者原教程](https://img-blog.csdnimg.cn/20181103225958578.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

作者写过相关教程，但只适用于\[朙月拼音・簡化字\]，遂写此教程送给需要的人  
  
步骤：

1.  在文件资源管理器中打开“%AppData%\\Rime”-进入\[用户文件夹\]
2.  在目录中新建“Custom_phrase.txt”
3.  复制以下代码

    # Rime table
    # coding: utf-8
    #@/db_name custom_phrase.txt
    #@/db_type tabledb
    #
    # 用於【朙月拼音】系列輸入方案
    # 【小狼毫】0.9.21 以上
    #
    # 請將該文件以UTF-8編碼保存爲
    # Rime用戶文件夾/custom_phrase.txt
    #
    # 碼表各字段以製表符（Tab）分隔
    # 順序爲：文字、編碼、權重（決定重碼的次序、可選）
    #
    # 雖然文本碼表編輯較爲方便，但不適合導入大量條目
    #
    # no comment
    tinggofly@gmail.com    email   1
    136770748@qq.com    email   2

![在这里插入图片描述](https://img-blog.csdnimg.cn/20181103230800872.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

1.  在build文件夹下打开“double\_pinyin\_flypy.schema.yaml”
2.  在translators里添加修改如下代码（多增少补）：

    translators:
        - punct_translator
        - reverse_lookup_translator
        - script_translator
        - table_translator@custom_phrase #表示调用custom_phrase段编码
        - table_translator
    custom_phrase: 
      dictionary: ""
      user_dict: custom_phrase
      db_class: stabledb
      enable_completion: false
      enable_sentence: false
      initial_quality: 1

1.  开始菜单-小狼毫输入法-重新部署 完成效果：  
    

![](https://img-blog.csdnimg.cn/20181104125844152.png)