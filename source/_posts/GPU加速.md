---
title: GPU加速
date: 2019-06-27 12:26:10
tags:
- GPU
- 网络
- 1060
categories:
- 硬件
---
# GPU加速
为了跑网络的速度快一些，近日购入一块1060（6G）显卡，安装完成，苦于不知如何在软件层面设置，笔记之。

# 我的疑问
## 为什么用GPU而不用CPU，为什么GPU的计算速度快？
>CPU和GPU之所以大不相同，是由于其设计目标的不同，它们分别针对了两种不同的应用场景。**CPU需要很强的通用性来处理各种不同的数据类型**，同时又要**逻辑判断**又会引入大量的分支跳转和中断的处理。这些都使得CPU的内部结构异常复杂。而GPU面对的则是**类型高度统一的、相互无依赖的大规模数据和不需要被打断的纯净的计算环境**。

>GPU是基于大的吞吐量设计

>GPU采用了**数量众多的计算单元和超长的流水线**，但只有非常**简单的控制逻辑并省去了Cache**。而CPU不仅被Cache占据了大量空间，而且还有有复杂的控制逻辑和诸多优化电路，**相比之下计算能力只是CPU很小的一部分**。

>GPU的特点是有**很多的ALU和很少的cache**. 缓存的目的不是保存后面需要访问的数据的，这点和CPU不同，而是为thread提高服务的。如果有很多线程需要访问**同一个相同的数据**，缓存会**合并**这些访问，然后再去访问dram（因为需要访问的**数据保存在dram中**而不是cache里面），获取数据后cache会转发这个数据给对应的线程，这个时候是数据转发的角色。但是由于需要访问dram，自然会带来延时的问题。

**CPU 力气大啥P事都能干，还要协调。**

**GPU 上面那家伙的小弟，老大让他处理图形，这方面处理简单，但是量大，老大虽然能处理，可是老大只有那么几个兄弟，所以不如交给小弟处理了，小弟兄弟多，有数百至数千个，而且是专门只干这行和只能干这行。**



## 什么是CUDA？
安装TensorFlow-GPU时会打包安装CUDApackage，那么，什么是CUDA呢？

CUDA：**C**omputer **U**nified **D**evice **A**rchitecture 统一计算架构
>CUDA 就是通用计算，**游戏让 GPU 算的是一堆像素的颜色**，而 GPU **完全可以算其他任何运算**，比如大数据量矩阵乘法等。

>同样，程序准备好对应的数组，以及让 GPU 如何算这些数组的描述结构（比如让 GPU 内部开多少个线程来算，怎么算，之类），这些数据和描述，都要调用 CUDA 库提供的函数来传递给 CUDA，CUDA 再调用显卡用户态驱动对 CUDA 程序进行编译，后者再调用内核态驱动将命令以及编译好的程序数据传送给 GPU，算。

## 如何让将GPU跑神经网络？
### 安装tensoflow-gpu

> 对于python 3.5和3.6的童鞋们而言，安装tensorflow其实并不难，因为我们可以通过pip直接安装。
不过，第一要求你安装的python是64位的 -cnblog 子沐老司


    (base) C:\Users\Administrator>conda activate yolo1 //激活环境
    (yolo1) C:\Users\Administrator>conda install tensorflow-gpu

conda列出的packages中已经有了**CUDA/CUDNN**

    cudatoolkit-9.0            |                1       339.8 MB  https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
    cudnn-7.6.0                |        cuda9.0_0       183.7 MB  https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
### 测试是否安装成功
    #coding=utf-8
    import tensorflow as tf
    import numpy as np
    hello=tf.constant('Yes-timj3ly.com')
    sess=tf.Session()
    print (sess.run(hello))
若显示出 **Yes-timj3ly.com** 即成功