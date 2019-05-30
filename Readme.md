* * * * 
# Inference Engine Demo
## 1. security_barrier_camera_demo
  This demo showcases Vehicle and License Plate Detection network followed by the Vehicle Attributes and License Plate Recognition applied on top of Vehicle Detection results.
  
  For more information, please visit [Security Barrier Camera Demo]( https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-3) on Intel's Website


## 2. interactive_face_detection_demo
This demo showcases Object Detection task applied for face recognition using sequence of neural networks. Async API can improve overall frame-rate of the application, because rather than wait for inference to complete, the application can continue operating on the host while accelerator is busy. This demo executes four parallel infer requests for the Age/Gender Recognition, Head Pose Estimation, Emotions Recognition, and Facial Landmarks Detection networks that run simultaneously.

  For more information, please visit [Interactive Face Detection Demo]( https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-11) on Intel's Website

## 3. classification_demo
  This topic demonstrates how to run the Image Classification sample application, which does inference using image classification networks like AlexNet* and GoogLeNet*.
  
  For more information, please visit [Image Classification Sample]( https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-1) on Intel's Website
    
## 4. Human Pose Estimation Demo.
  This demo showcases the work of multi-person 2D pose estimation algorithm. The task is to predict a pose: body skeleton, which consists of keypoints and connections between them, for every person in an input video. The pose may contain up to 18 keypoints: ears, eyes, nose, neck, shoulders, elbows, wrists, hips, knees, and ankles. Some of potential use cases of the algorithm are action recognition and behavior understanding.
  
  For more information, please visit [Human Pose Estimation Demo](https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-17) on Intel's Website
  
## 5. Object Detection SSD Demo - Async API.
  This demonstration showcases Object Detection with SSD and new Async API. Async API usage can improve overall frame-rate of the application, because rather than wait for inference to complete, the app can continue doing things on the host, while accelerator is busy. Specifically, this demonstration keeps two parallel infer requests and while the current is processed, the input frame for the next is being captured. 
  
  For more information, please visit [Object Detection SSD Demo, Async API Performance Showcase](https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-11) on Intel's Website
  
## 6. Crossroad Camera Demo
  This demo provides an inference pipeline for person detection, recognition and reidentification. The demo uses Person Detection network followed by the Person Attributes Recognition and Person Reidentification Retail networks applied on top of the detection results. 

  For more information, please visit [Crossroad Camera Demo](https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-13 ) on Intel's Website

## 7. super_resolution_demo
  This topic demonstrates how to run the Super Resolution demo application, which reconstructs the high resolution image from the original low resolution one.
  
  For more information, please visit [Super Resolution Demo](https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-21) on Intel's Website
  
## 8. pedestrian tracker demo
  This demo showcases Pedestrian Tracking scenario: it reads frames from an input video sequence, detects pedestrians in the frames, and builds trajectories of movement of the pedestrians in a frame-by-frame manner. 
  
  
  For more information, please visit [Pedestrian Tracker Demo](https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-19) on Intel's Website
## 9. smart_classroom_demo
  The demo demonstrates an example of joint usage of several neural networks to detect three basic actions (sitting, standing, raising hand) and recognize people by faces in the classroom environment. The demo uses Async API for action and face detection nets. It allows to parallelize execution of face recognition and detection: while face recognition is running on one accelerator, face and action detection can be performed on other. 
  
  For more information, please visit [Smart Classroom Demo](https://software.intel.com/en-us/articles/OpenVINO-IE-Samples#inpage-nav-20) on Intel's Website
* * * * 
