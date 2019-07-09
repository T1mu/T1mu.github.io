---
title: " 解决问题：UserWarning: Matplotlib is currently using agg, which is a non-GUI backend.\t\t"
tags:
  - non-GUI
  - Object_Detection
url: 10.html
id: 10
categories:
  - Tensorflow
date: 2019-02-23 14:25:19
---

问题描述
----

在运行TensorFlow.Object_Detection时遇到问题：UserWarning: Matplotlib is currently using agg, which is a non-GUI backend.  
**检测物体最终生成的图片无法在终端显示**

解决办法
----

编辑tensorflow所在目录下的 **models/research/object\_detection/uitls/visualization\_utils.py**  
**修改26行的Agg为Qt5Agg**

        import matplotlib; matplotlib.use('Qt5Agg') 

问题处理过程
------

*   一  
    Warning中显示UserWarning: Matplotlib is currently using **agg**, which is a **non-GUI backend**.（agg是一个**没有图形显示界面的终端**，查询资料常用的有图形界面显示的终端名称为 **Qt5Agg**。） 于是在代码首行添加： `import matplotlib matplotlib.use('agg')` 再次运行，仍显示相同的Warning，失败。
*   二  
    既然已经设置了终端使用Qt5Agg，错误显示终端仍然是Agg，**那一定是代码运行过程中终端被修改**
    *   ctrl+f 查询'Agg'字样代码  
        没有，卒 。既然代码中没有直接修改终端的类型，**那就一定是在引入库的过程终端类型中被修改。**
    *   使用方法 `print(matplotlib.get_backend())` （查看当前matplotlib使用的终端类型）将穿插在每一个库import之后，再次运行发现是在 `from utils import visualization_utils as vis_util` 后终端由Qt5Agg变成Agg
    *   遂打开 **visualization_utils.py**在26行发现了直接定义matplotlib终端类型，修改即可√