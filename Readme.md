* * * * 
# Contents
* [Inference Engine Sample Demo](#inference-engine-demo)
  * [1. security_barrier_camera_demo](#1-security_barrier_camera_demo)
  * [2. interactive_face_detection_demo](#2-interactive_face_detection_demo)
  * [3. classification_demo](#3-classification_demo)
  * [4. Human Pose Estimation Demo](#4-human-pose-estimation-demo)
  * [5. Object Detection SSD Demo](#5-object-detection-ssd-demo)
  * [6. Crossroad Camera Demo](#6-crossroad-camera-demo)
  * [7. super_resolution_demo](#7-super_resolution_demo)
  * [8. pedestrian tracker demo](#8-pedestrian-tracker-demo)
  * [9. smart_classroom_demo](#9-smart_classroom_demo)
* [Sample Build](#Sample-Build)
* [Model Downloader](#Model-Downloader)
* * * * 
# Inference Engine Sample Demo
## 1. security_barrier_camera_demo
  This demo showcases Vehicle and License Plate Detection network followed by the Vehicle Attributes and License Plate Recognition applied on top of Vehicle Detection results.
  
  For more information, please visit [Security Barrier Camera Demo]( https://docs.openvinotoolkit.org/latest/_inference_engine_samples_security_barrier_camera_demo_README.html) on Intel's Website
### How to run the demo
#### Select a vehicle and license detection model
* After type in the number of security_barrier_camera_demo and pressed the enter key, the terminal would ask you to select a vehicle and license detection model, and give you a list that is available to choose:

      [Select a vehicle and license detection model.]
      >> 1. vehicle-license-plate-detection-barrier-0106 
      >> 2. vehicle-license-plate-detection-barrier-0106-fp16 
      >> Or input a path to your model 

  At this moment, you can type in the represent number to choose which dldt model you want to inference to detect vehicle and license plate,
  You can also type in the direct PATH to the model you want to use.

     *There's a trick that type-in "0" then press enter, it will choose the default model of vehicle and license detection model,Vehicle  Attributes recognition model and License Plate Recognition model, set all running on CPU and load default image in openvino toolkits. This trick can quickly run this demo.*

* After you choose the vehicle and license detection model, it will ask you what device you want to inference 

      >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device.
   Just type in "CPU","GPU","MYRIAD","HDDL"... to assign your inference device.

**Whatever you choose the default dldt model or the model your own, if you want to inference on CPU it can only support FP32 and INT8 format IR file(.xml), GPU support FP32 and FP16(Recommanded), MYRIAD support FP16**
#### Select a Vehicle Attributes recognition model
* After you choosing the vehicle and license detection model and assign to hardware inference device, It will ask you to choose Vehicle Attributes recognition model:

      [Select a Vehicle Attributes recognition model.]
      >> 1. vehicle-attributes-recognition-barrier-0039 
      >> 2. vehicle-attributes-recognition-barrier-0039-fp16 
      >> 3. input a path to your model 
      >> Or press ENTER to ignore it. 
  Just like choosing vehicle and license detection model, input the represent number of the dldt model or type in the PATH by yourself to load your model. 
  
  You can also just press "Enter" without keyin any words to ignore this step. 
  If you ignore this step, the demo application won't do Vehicle Attributes recognition.
* After you choose the Vehicle Attributes recognition model, it will also ask you which device you want to inference 
#### Select a License Plate Recognition model
* After you choosing the Vehicle Attributes recognition model and assign to hardware inference device, It will ask you to choose License Plate Recognition model:

      [Select a License Plate Recognition model.]"
      >> 1. license-plate-recognition-barrier-0001 "
      >> 2. license-plate-recognition-barrier-0001-fp16 "
      >> 3. input a path to your model "
      >> Or press ENTER to ignore it. "
  Just follow the same way before.
#### Setup the input data
* After you choose the License Plate Recognition model and assign to hardware inference device, you should setup an input data for model and application to inference:
      >> input "cam" for using camera as inference source,"0" for default Source, or typein the path to the source you want.
      


1. Input "cam" : Set the defalut camera that install on your system as an input video stream. 
  
2. Input "0" : Set the default chinese car image in openVINO toolkits as an input image.
  
3. Input an image, video or camera file location as an input image/video. Multiple source is available, for example, if you have multiple camera, type-in "/dev/video0 /dev/video1 /dev/video2"

## 2. interactive_face_detection_demo
This demo showcases Object Detection task applied for face recognition using sequence of neural networks. Async API can improve overall frame-rate of the application, because rather than wait for inference to complete, the application can continue operating on the host while accelerator is busy. This demo executes four parallel infer requests for the Age/Gender Recognition, Head Pose Estimation, Emotions Recognition, and Facial Landmarks Detection networks that run simultaneously.

  For more information, please visit [Interactive Face Detection Demo]( https://docs.openvinotoolkit.org/latest/_inference_engine_samples_interactive_face_detection_demo_README.html) on Intel's Website

### How to run the demo
#### Select a Face Detection model
* After type in the number of interactive_face_detection_demo, pressed the enter key, the terminal would ask you to select a Face Detection model, and give you a list that is available to choose:

      [Select a Face Detection model.]
      >> 1. face-detection-adas-0001 
      >> 2. face-detection-adas-0001-fp16 
      >> 3. face-detection-retail-0004
      >> 4. face-detection-retail-0004-fp16
      >> Or input a path to your model 

  At this moment, you can type in the represent number to choose which dldt model you want to inference to detect Human face,
  You can also type in the direct PATH to the model you want to use.

     *There's a trick that type-in "0" then press enter, it will choose the default model of Face Detection model, Age gender recognition model, Headpose Estimation model, Emotions recognition model  and Facial Landmarks model, set all running on CPU and load camera as input source(Make sure you have camera connect to your device.). This trick can quickly run this demo.* 
     __In this demo case,  running totally 5 models on the same device may cause lower performance__
     
* After you choose the Face Detection model, it will ask you which device you want to inference 

      >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device.
   Just type in "CPU","GPU","MYRIAD","HDDL"... to assign your inference device.

**Whatever you choose the default dldt model or the model your own, if you want to inference on CPU it can only support FP32 and INT8 format IR file(.xml), GPU support FP32 and FP16(Recommanded), MYRIAD/HDDL support FP16**
#### Select a Age gender recognition model
* After you choose the Face Detection model and assign to hardware inference device, It will ask you to choose Age gender recognition model:

      [Select a Age gender recognition model.]
      >> 1. age-gender-recognition-retail-0013 
      >> 2. age-gender-recognition-retail-0013-fp16 
      >> 3. input a path to your model 
      >> Or press ENTER to ignore it. 
  Just like choosing vehicle and license detection model, input the represent number of the dldt model or type in the PATH by yourself to load your model. 
  
  You can also just press "Enter" without keyin any words to ignore this step. 
  If you ignore this step, the demo application won't do Age gender recognition.
* After you choose the Age gender recognition model, it will also ask you which device you want to inference 
#### Select a Headpose Estimation model
* After you choose the Age gender recognition model and assign to hardware inference device, It will ask you to choose Headpose Estimation model:

      [Select a Headpose Estimation model.]
      >> 1. head-pose-estimation-adas-0001 
      >> 2. head-pose-estimation-adas-0001-fp16 
      >> 3. input a path to your model 
      >> Or press ENTER to ignore it. 
  Just like choosing Age gender recognition model, input the represent number of the dldt model or type in the PATH by yourself to load your model. 
  
  You can also just press "Enter" without keyin any words to ignore this step. 
  If you ignore this step, the demo application won't do Headpose Estimation.
* After you choose the Headpose Estimation model, it will also ask you which device you want to inference 
#### Select a Emotions recognition model
* After you choose the Headpose Estimation model and assign to hardware inference device, It will ask you to choose Emotions recognition model:

      [Select a Emotions recognition model.]
      >> 1. emotions-recognition-retail-0003 
      >> 2. emotions-recognition-retail-0003-fp16 
      >> 3. input a path to your model 
      >> Or press ENTER to ignore it. 
  Just like choosing Headpose Estimation model, input the represent number of the dldt model or type in the PATH by yourself to load your model. 
  
  You can also just press "Enter" without keyin any words to ignore this step. 
  If you ignore this step, the demo application won't do Emotions recognition.
* After you choose the Emotions recognition model, it will also ask you which device you want to inference 
#### Select a Facial Landmarks model
* After you choose the Emotions recognition model and assign to hardware inference device, It will ask you to choose Facial Landmarks model:

      [Select a Facial Landmarks model.]
      >> 1. facial-landmarks-35-adas-0002 
      >> 2. facial-landmarks-35-adas-0002-fp16 
      >> 3. input a path to your model 
      >> Or press ENTER to ignore it. 
  Just like choosing Emotions recognition model, input the represent number of the dldt model or type in the PATH by yourself to load your model. 
  
  You can also just press "Enter" without keyin any words to ignore this step. 
  If you ignore this step, the demo application won't do Facial Landmarks.
* After you choose the Emotions recognition model, it will also ask you which device you want to inference 
#### Setup the input data
* After you choose the License Plate Recognition model and assign to hardware inference device, you should setup an input data for model and application to inference:
      >> input "cam" for using camera as inference source,"0" for default Source, or typein the path to the source you want.
      
1. Input "cam" or "0": Set the defalut camera that install on your system as an input video stream. 
  
2. Input an image, video or camera file location as an input image/video. Multiple source is __NOT__ available for this demo case.
## 3. classification_demo
  This topic demonstrates how to run the Image Classification sample application, which does inference using image classification networks like AlexNet* and GoogLeNet*.
  
  For more information, please visit [Image Classification Sample async](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_classification_sample_async_README.html) and [Image Classification Sample](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_classification_sample_README.html) on Intel's Website
    
## 4. Human Pose Estimation Demo.
  This demo showcases the work of multi-person 2D pose estimation algorithm. The task is to predict a pose: body skeleton, which consists of keypoints and connections between them, for every person in an input video. The pose may contain up to 18 keypoints: ears, eyes, nose, neck, shoulders, elbows, wrists, hips, knees, and ankles. Some of potential use cases of the algorithm are action recognition and behavior understanding.
  
  For more information, please visit [Human Pose Estimation Demo](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_human_pose_estimation_demo_README.html) on Intel's Website
  
## 5. Object Detection SSD Demo
  This demonstration showcases Object Detection with SSD and new Async API. Async API usage can improve overall frame-rate of the application, because rather than wait for inference to complete, the app can continue doing things on the host, while accelerator is busy. Specifically, this demonstration keeps two parallel infer requests and while the current is processed, the input frame for the next is being captured. 
  
  For more information, please visit [Object Detection SSD Demo](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_object_detection_sample_ssd_README.html) and [Object Detection SSD Demo, Async API Performance Showcase](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_object_detection_demo_ssd_async_README.html) on Intel's Website
  
## 6. Crossroad Camera Demo
  This demo provides an inference pipeline for person detection, recognition and reidentification. The demo uses Person Detection network followed by the Person Attributes Recognition and Person Reidentification Retail networks applied on top of the detection results. 

  For more information, please visit [Crossroad Camera Demo](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_crossroad_camera_demo_README.html) on Intel's Website

## 7. super_resolution_demo
  This topic demonstrates how to run the Super Resolution demo application, which reconstructs the high resolution image from the original low resolution one.
  
  For more information, please visit [Super Resolution Demo](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_super_resolution_demo_README.html) on Intel's Website
  
## 8. pedestrian tracker demo
  This demo showcases Pedestrian Tracking scenario: it reads frames from an input video sequence, detects pedestrians in the frames, and builds trajectories of movement of the pedestrians in a frame-by-frame manner. 
  
  
  For more information, please visit [Pedestrian Tracker Demo](https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-19) on Intel's Website
## 9. smart_classroom_demo
  The demo demonstrates an example of joint usage of several neural networks to detect three basic actions (sitting, standing, raising hand) and recognize people by faces in the classroom environment. The demo uses Async API for action and face detection nets. It allows to parallelize execution of face recognition and detection: while face recognition is running on one accelerator, face and action detection can be performed on other. 
  
  For more information, please visit [Smart Classroom Demo](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_pedestrian_tracker_demo_README.html) on Intel's Website
* * * * 
# Sample Build
If you have successfully build the openVINO sample, the terminal will show as following

    3. Sample Build.(Done!)
    
If not yet, It will not show "Done!" and those sample code need to be build in order to run the samples.
type in "3" and press "Enter" key, Those sample code will be build automatically.

* * * * 
# Model Downloader
In openVINO sample application, DLDT models usually needed. If you have not downloaded those necessary models, you have to run the downloader.

In the Model Downloader Interface, there are 4 options

    |=========================================|
    |  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
    |                                         |
    |            Model Downloader             |
    |=========================================|
      Ver. 0.X.X | Support OpenVINO v2019.X.XXX
    1. Download all from DLDT.
    2. Typein specific DLDT model.
    3. Typein an URL of the model.
    4. EXIT the downloader.
### 1. Download all from DLDT.

 This option will download all the model list on model downloader's yml file, more than 9.6GB models and IR file will be download, please make sure there's enough free space for these files.

### 2. Typein specific DLDT model.

 This option will show you all the available models on the list, you can copy the name of the model and type in the model name to download specific model.

### 3. Typein an URL of the model.

 This option will download the file directly refer to the URL that type in.

### 4. EXIT the downloader.
* * * * 
