---
title: " TensorFlow Object Detection 实现过程中的笔记\t\t"
tags:
  - TensorFlow
  - 笔记
url: 16.html
id: 16
categories:
  - Linux
  - Tensorflow
date: 2019-01-14 14:13:09
---

1\. 下载TensorFlow Object Detection
---------------------------------

### 1.1 linux中用命令下载GitHub项目：

![linux中用命令下载GitHub项目](https://img-blog.csdnimg.cn/20190113202111822.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

    git clone https://github.com/tensorflow/models
    其中https://github.com/tensorflow/models是TensorFlow Object Detection在GitHub上的项目地址

### 了解项目纲领：

> TensorFlow Models  
> This repository contains a number of different models implemented in TensorFlow:  
> The official models are a collection of example models that use TensorFlow's high-level APIs. They are intended to be well-maintained, tested, and kept up to date with the latest stable TensorFlow API. They should also be reasonably optimized for fast performance while still being easy to read. We especially recommend newer TensorFlow users to start here.  
> The research models are a large collection of models implemented in TensorFlow by researchers. They are not officially supported or available in release branches; it is up to the individual researchers to maintain the models and/or provide support on issues and pull requests.  
> The samples folder contains code snippets and smaller models that demonstrate features of TensorFlow, including code presented in various blog posts.  
> The tutorials folder is a collection of models described in the TensorFlow tutorials.  
> Contribution guidelines  
> If you want to contribute to models, be sure to review the contribution guidelines.  
> License  
> Apache License 2.0

tensorflow模型：

1.  包含大量模型（使用tensorflow实现的）
2.  模型分为四类：  
    2.1 第一类：官方模型 （official models）包含可用的、稳定的模型；  
    2.2 第二类：研究模型（research models）包含网民自行使用tensorflow开发的模型；  
    2.3 第三类：样品模型（samples models）包含小型的、展示tensorflow新特性的模型；  
    2.4 第四类：教程模型（tutorials folder）；

2\. 遇到问题：缺少**protobuf**
-----------------------

### 2.1 什么是 protobuf 呢？

解释来自：[谷歌开发者文档](https://developers.google.com/protocol-buffers/docs/overview)

What are protocol buffers?  
Protocol buffers are a flexible, efficient, automated mechanism for serializing structured data – think XML, but smaller, faster, and simpler. You define how you want your data to be structured once, then you can use special generated source code to easily write and read your structured data to and from a variety of data streams and using a variety of languages. You can even update your data structure without breaking deployed programs that are compiled against the "old" format.  
大致意思是 protocol buffers 是一个可以将数据序列化成不同格式的数据结构，以便用在各种平台上（改一份原始数据，然后用protocol buffers就可以生成可以在其他平台运行的代码）

### 2.2 安装过程

##### 2.2.1 下载-编译-运行

下载：

    $wget https://github.com/google/protobuf/archive/v3.6.1.zip
    $unzip protobuf-3.6.1.zip
    $cd protobuf-3.6.1

下载自github的代码需要首先执行 $ ./autogen.sh 生成configure文件

    $ ./configure
    $ make
    $ make check
    $ sudo make install

![安装完成](https://img-blog.csdnimg.cn/20190114144256546.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

protobuf安装完成：  

3\. 编译protos文件、运行Demo
---------------------

### 3.1 编译protos文件

进入到models文件夹，编译Object Detection API的代码：

    # From tensorflow/models/ 
    protoc object_detection/protos/*.proto –python_out=. 

![protos文件夹下 .proto对应.py](https://img-blog.csdnimg.cn/20190115162144777.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

目的是让_.proto文件转换成：_.py  
  
运行notebook demo在models文件夹下运行：jupyter-notebook

### 3.2 运行Demo文件

在models路径下运行

    jupyter-notebook

![在models路径下运行jupyter-notebook](https://img-blog.csdnimg.cn/20190115162753473.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190115163055376.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

  
访问文件夹object\_detection，运行object\_detection_tutorial.ipynb：  

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190115163941781.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

运行全部，得到  

4\. 不同环境下使用jupyter (来自：\[简书-赵小帅\])(https://www.jianshu.com/p/808ca4b3876e)
--------------------------------------------------------------------------

#### 原因：

因为python3.7不能使用TensorFlow，所以要切换到python3.6环境，*.ipynb文件貌似是jupyter独有的

综上所述，我们需要一个3.6的jupyter环境

* * *

#### 方法：

查看我的 python 环境

    $ conda info -e
    # conda environments:
    #
    base                  *  /anaconda3
    caffe2                   /anaconda3/envs/caffe2
    cv                       /anaconda3/envs/cv
    tf                       /anaconda3/envs/tf

比如，想使用 tf 作为 jupyter 启动时的 Python 环境

首先激活 tf 环境

$ source activate tf

在 tf 环境下安装 jupyter

    (tf) :~ $ conda install jupyter
    # 最左边 环境名 tf

启动 jupyter

    (tf) :~ $ jupyter notebook

完工！

感悟：jupyter 如果想使用不同的 Python 环境，就需要在这份 Python 环境下安装一份 jupyter，并且在启动前，先 activate 这个环境。