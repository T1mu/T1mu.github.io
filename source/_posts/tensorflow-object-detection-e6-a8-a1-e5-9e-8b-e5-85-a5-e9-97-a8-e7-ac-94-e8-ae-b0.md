---
title: " Tensorflow-Object Detection模型入门笔记\t\t"
tags:
  - object-detection
  - Quick Start
  - Tensorflow-Object Detection
url: 60.html
id: 60
categories:
  - Tensorflow
date: 2019-02-23 13:56:45
---

@[toc](Tensorflow的入门笔记)

Object Detection模型入门笔记
======================

    各大公司的招聘都明确要求：熟悉Tensorflow框架，遂捣鼓。

搭建环境
----

*   [linux的入门学习笔记](https://blog.csdn.net/neninee/article/details/87878221)
    *   anaconda的安装
    *   conda 命令学习笔记
    *   [Tensorflow 的安装](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md)

git clone Tensorflow模型
----------------------

*   [linux的入门学习笔记](https://blog.csdn.net/neninee/article/details/87878221)
    *   git命令的学习笔记

快速开始
----

### Quick Start: Jupyter notebook for off-the-shelf inference

    (base) timj3ly@Tim-J3ly:~$ source activate py36
    (py36) timj3ly@Tim-J3ly:~$ cd models/research/object_detection
    (py36) timj3ly@Tim-J3ly:~/models/research/object_detection$ jupyter notebook
    [I 14:11:36.542 NotebookApp] 启动notebooks 在本地路径: /home/timj3ly/models/research/object_detection
    [I 14:11:36.542 NotebookApp] 本程序运行在: http://localhost:8888/?token=fc5b40a930b6ed66d76b5ee70099dfafb2c09f7d0329afa0
    [I 14:11:36.542 NotebookApp] 使用control-c停止此服务器并关闭所有内核(两次跳过确认).
    [C 14:11:36.546 NotebookApp] 
    
        To access the notebook, open this file in a browser:
            file:///run/user/1000/jupyter/nbserver-5607-open.html
        Or copy and paste one of these URLs:
            http://localhost:8888/?token=fc5b40a930b6ed66d76b5ee70099dfafb2c09f7d0329afa0
    [5661:5661:0223/141136.828649:ERROR:sandbox_linux.cc(364)] InitializeSandbox() called with multiple threads in process gpu-process.
    [5620:5641:0223/141136.846376:ERROR:browser_process_sub_thread.cc(209)] Waited 3 ms for network service
    正在现有的浏览器会话中打开。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190223141314469.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190223141411625.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190223141433654.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190223141450764.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L25lbmluZWU=,size_16,color_FFFFFF,t_70)

  
  
结果：  
  

#### 代码分析

*   整体代码

    import numpy as np
    import os
    import six.moves.urllib as urllib
    import sys
    import tarfile
    import tensorflow as tf
    import zipfile
    
    from collections import defaultdict
    from io import StringIO
    from matplotlib import pyplot as plt
    from PIL import Image
    
    ## This is needed to display the images.
    #%matplotlib inline
    
    # This is needed since the notebook is stored in the object_detection folder.
    sys.path.append("..")
    
    from utils import label_map_util
    
    from utils import visualization_utils as vis_util
    
    # What model to download.
    MODEL_NAME = 'ssd_mobilenet_v1_coco_11_06_2017'
    MODEL_FILE = MODEL_NAME + '.tar.gz'
    DOWNLOAD_BASE = 'http://download.tensorflow.org/models/object_detection/'
    
    # Path to frozen detection graph. This is the actual model that is used for the object detection.
    PATH_TO_CKPT = MODEL_NAME + '/frozen_inference_graph.pb'
    
    # List of the strings that is used to add correct label for each box.
    PATH_TO_LABELS = os.path.join('data', 'mscoco_label_map.pbtxt')
    
    NUM_CLASSES = 90
    
    #download model
    #opener = urllib.request.URLopener()
    #下载模型，如果已经下载好了下面这句代码可以注释掉
    #opener.retrieve(DOWNLOAD_BASE + MODEL_FILE, MODEL_FILE)
    tar_file = tarfile.open(MODEL_FILE)
    for file in tar_file.getmembers():
      file_name = os.path.basename(file.name)
      if 'frozen_inference_graph.pb' in file_name:
        tar_file.extract(file, os.getcwd())
    
    #Load a (frozen) Tensorflow model into memory.    
    detection_graph = tf.Graph()
    with detection_graph.as_default():
      od_graph_def = tf.GraphDef()
      with tf.gfile.GFile(PATH_TO_CKPT, 'rb') as fid:
        serialized_graph = fid.read()
        od_graph_def.ParseFromString(serialized_graph)
        tf.import_graph_def(od_graph_def, name='')
    #Loading label map    
    label_map = label_map_util.load_labelmap(PATH_TO_LABELS)
    categories = label_map_util.convert_label_map_to_categories(label_map, max_num_classes=NUM_CLASSES, use_display_name=True)
    category_index = label_map_util.create_category_index(categories)
    #Helper code
    def load_image_into_numpy_array(image):
      (im_width, im_height) = image.size
      return np.array(image.getdata()).reshape(
          (im_height, im_width, 3)).astype(np.uint8)
    
    
    # For the sake of simplicity we will use only 2 images:
    # image1.jpg
    # image2.jpg
    # If you want to test the code with your images, just add path to the images to the TEST_IMAGE_PATHS.
    PATH_TO_TEST_IMAGES_DIR = 'test_images'
    TEST_IMAGE_PATHS = [ os.path.join(PATH_TO_TEST_IMAGES_DIR, 'image{}.jpg'.format(i)) for i in range(1, 5) ]
    
    # Size, in inches, of the output images.
    IMAGE_SIZE = (30, 20)
    
    def run_inference_for_single_image(image, graph):
      with graph.as_default():
        with tf.Session() as sess:
          # Get handles to input and output tensors
          ops = tf.get_default_graph().get_operations()
          all_tensor_names = {output.name for op in ops for output in op.outputs}
          tensor_dict = {}
          for key in [
              'num_detections', 'detection_boxes', 'detection_scores',
              'detection_classes', 'detection_masks'
          ]:
            tensor_name = key + ':0'
            if tensor_name in all_tensor_names:
              tensor_dict[key] = tf.get_default_graph().get_tensor_by_name(
                  tensor_name)
          if 'detection_masks' in tensor_dict:
            # The following processing is only for single image
            detection_boxes = tf.squeeze(tensor_dict['detection_boxes'], [0])
            detection_masks = tf.squeeze(tensor_dict['detection_masks'], [0])
            # Reframe is required to translate mask from box coordinates to image coordinates and fit the image size.
            real_num_detection = tf.cast(tensor_dict['num_detections'][0], tf.int32)
            detection_boxes = tf.slice(detection_boxes, [0, 0], [real_num_detection, -1])
            detection_masks = tf.slice(detection_masks, [0, 0, 0], [real_num_detection, -1, -1])
            detection_masks_reframed = utils_ops.reframe_box_masks_to_image_masks(
                detection_masks, detection_boxes, image.shape[0], image.shape[1])
            detection_masks_reframed = tf.cast(
                tf.greater(detection_masks_reframed, 0.5), tf.uint8)
            # Follow the convention by adding back the batch dimension
            tensor_dict['detection_masks'] = tf.expand_dims(
                detection_masks_reframed, 0)
          image_tensor = tf.get_default_graph().get_tensor_by_name('image_tensor:0')
    
          # Run inference
          output_dict = sess.run(tensor_dict,
                                 feed_dict={image_tensor: np.expand_dims(image, 0)})
    
          # all outputs are float32 numpy arrays, so convert types as appropriate
          output_dict['num_detections'] = int(output_dict['num_detections'][0])
          output_dict['detection_classes'] = output_dict[
              'detection_classes'][0].astype(np.uint8)
          output_dict['detection_boxes'] = output_dict['detection_boxes'][0]
          output_dict['detection_scores'] = output_dict['detection_scores'][0]
          if 'detection_masks' in output_dict:
            output_dict['detection_masks'] = output_dict['detection_masks'][0]
      return output_dict
    for image_path in TEST_IMAGE_PATHS:
      image = Image.open(image_path)
      # the array based representation of the image will be used later in order to prepare the
      # result image with boxes and labels on it.
      image_np = load_image_into_numpy_array(image)
      # Expand dimensions since the model expects images to have shape: [1, None, None, 3]
      image_np_expanded = np.expand_dims(image_np, axis=0)
      # Actual detection.
      output_dict = run_inference_for_single_image(image_np, detection_graph)
      # Visualization of the results of a detection.
      vis_util.visualize_boxes_and_labels_on_image_array(
          image_np,
          output_dict['detection_boxes'],
          output_dict['detection_classes'],
          output_dict['detection_scores'],
          category_index,
          instance_masks=output_dict.get('detection_masks'),
          use_normalized_coordinates=True,
          line_thickness=1)
      plt.figure(figsize=IMAGE_SIZE)
      plt.imshow(image_np)

tips:如果在Spyder中跑不出图片，需要再运行.py之前在terminal输入%matplotlib inline

\[1\]

    # Imports
    import numpy as np
    import os
    import six.moves.urllib as urllib
    import sys
    import tarfile
    import tensorflow as tf
    import zipfile
    
    from distutils.version import StrictVersion
    from collections import defaultdict
    from io import StringIO
    from matplotlib import pyplot as plt
    from PIL import Image
    
    # This is needed since the notebook is stored in the object_detection folder.
    sys.path.append("..")#当前路径是:models/research/object_detection,cd .. 后即返回上一级目录，目的是为了导入object_detection模块
    
    from object_detection.utils import ops as utils_ops
    
    if StrictVersion(tf.__version__) < StrictVersion('1.9.0'):#Tensorflow版本比较
      raise ImportError('Please upgrade your TensorFlow installation to v1.9.* or later!')

*   Modules：  
    numpy：NumPy is the fundamental package for scientific computing with Python.  
    os — **Miscellaneous** operating system interfaces  
    urllib — URL handling modules  
    sys — System-specific **parameters** and functions  
    tarfile — Read and write tar archive files  
    zipfile — Work with ZIP archives  
    StrictVersion — 比较版本  
    Collections — This module **implements** specialized container datatypes providing alternatives to Python's general purpose built-in containers, dict, list, set, and tuple.  
    io — The io module provides the Python interfaces to **stream** handling. The **builtin** open function is defined in this module.  
    **matplotlib** — This is an object-oriented **plotting** library.  
    **PIL** — Pillow (Fork of the Python Imaging Library)  
    utils：实用程序类

\[2\]

    #Env setup
    # This is needed to display the images.用来显示图片
    # %matplotlib inline 会出错 安装Jupyter插件
    #%%

\[3\]

    # Object detection imports
    # Here are the imports from the object detection module.
    
    from utils import label_map_util
    
    from utils import visualization_utils as vis_util

*   Modules:
    *   module utils.label\_map\_util:Label map **utility** functions.
    *   module utils.visualization_utils  
        A set of functions that are used for visualization.  
        These functions often receive an image, perform some visualization on the image. The functions do not return a value, instead they modify the image itself.（在原图上进行标记用的Modules）

\[4\]

    #[4]
    # Model preparation
    # Variables
    # Any model exported using the export_inference_graph.py tool can be loaded here simply by changing PATH_TO_FROZEN_GRAPH to point to a new .pb file.
    #所有用export_inference_graph.py这个工具导出的模型，都可以通过将PATH_TO_FROZEN_GRAPH转换成新的.pb文件来导入到工程文件中。
    
    # By default we use an "SSD with Mobilenet" model here. See the detection model zoo for a list of other models that can be run out-of-the-box with varying speeds and accuracies.
    #我们使用SSDwithMobilenet这个模型
    
    # What model to download.
    MODEL_NAME = 'ssd_mobilenet_v1_coco_2017_11_17'
    MODEL_FILE = MODEL_NAME + '.tar.gz'#模型名称
    DOWNLOAD_BASE = 'http://download.tensorflow.org/models/object_detection/'#模型父地址
    
    # Path to frozen detection graph. This is the actual model that is used for the object detection.
    PATH_TO_FROZEN_GRAPH = MODEL_NAME + '/frozen_inference_graph.pb'
    
    # List of the strings that is used to add correct label for each box.
    PATH_TO_LABELS = os.path.join('data', 'mscoco_label_map.pbtxt')

\[5\]

    #Download Model
    opener = urllib.request.URLopener()
    opener.retrieve(DOWNLOAD_BASE + MODEL_FILE, MODEL_FILE)
    tar_file = tarfile.open(MODEL_FILE)
    for file in tar_file.getmembers():
      file_name = os.path.basename(file.name)
      if 'frozen_inference_graph.pb' in file_name:
        tar_file.extract(file, os.getcwd())

*   urllib.request  
    The urllib.request module defines functions and classes which help in opening URLs (mostly HTTP) in a complex world — basic and digest **au_th_entication**, **redirections**, cookies and more.
*   urllib.request.urlopen(url, data=None, \[timeout, \]*, cafile=None, capath=None, cadefault=False, context=None )  
    Open the URL url, which can be either a string or a Request object. data must be an object specifying additional data to be sent to the server, or None if no such data is needed. See Request for details
*   def getmembers()  
    Return the members of the archive as a list of TarInfo objects. The list has the same order as the members in the archive.  
    -def basename(p)  
    Returns the final component of a pathname  
    -def extract(member, path="", set\_attrs=True, numeric\_owner=False)  
    Extract a member from the archive to the current working directory, using its full name. Its file information is extracted as accurately as possible. member' may be a filename or a TarInfo object. You can specify a different directory usingpath'. File attributes (owner, mtime, mode) are set unless set\_attrs' is False. Ifnumeric\_owner` is True, only the numbers for user/group names are used and not the names.