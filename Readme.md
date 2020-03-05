# OpenVINO_Demo_Kit
This is a tool that can make you run the [intel openVINO Demo and samples](https://docs.openvinotoolkit.org/latest/_docs_resources_introduction.html) easily. No need to change the directory to specific path and run those demo and sample apps with long parameters manully. Also, this Demo_Kits support to run benchmark app with multiple models and output the test result by a .csv file.

* * * * 
# Contents
* [Getting Started](#getting-started)
* [Inference Engine Sample Demo](#inference-engine-demo)
  * [0. Benchmark App](#0-benchmark-app)
  * [1. Security Barrier Camera Demo](#1-security-barrier-camera-demo). 
  * [2. Interactive Face Detection Demo](#2-interactive-face-detection-demo).
  * [3. Classification Demo](#3-classification-demo).
  * [4. Human Pose Estimation Demo. (2D)](#4-human-pose-estimation-demo-(2D))
  * [5. Object Detection and ASYNC API Demo](#5-object-detection-and-async-api-demo).
  * [6. Crossroad Camera Demo](#6-crossroad-camera-demo).
  * [7. Super Resolution Demo](#7-super-resolution-demo).
  * [8. Pedestrian Tracker Demo](#8-pedestrian-tracker-demo).
  * [9. Smart Classroom Demo](#9-smart-classroom-demo).
  * [10. Image Segmentation Demo](#10-image-segmentation-demo).
  * [11. Instance Segmentation Demo](#11-instance-segmentation-demo)
  * [12. Gaze Estimation Demo](#12-gaze-estimation-demo)
  * [13. Text Detection Demo](#13-text-detection-demo)
  * [14. Action Recognition Demo](#14-action-recognition-demo)
  * [15. Multi Camera Multi Person demo](#15-multi-camera-multi-person-demo)
  * [16. Face Recognition Demo](#16-face-recognition-demo)
  * [17. Speech Recognition Demo](#17-speech-recognition-demo)
  * [18. Real Time Speech Recognition Demo](#18-real-time-speech-recognition-demo)
* [Sample Build](#Sample-Build)
* [Model Downloader](#Model-Downloader)
* * * * 
# Getting Started
This project support for the Intel OpenVINO Toolkits installed on Ubuntu 18.04, for the begining, please install the Intel OpenVINO Toolkits (version 2020.1) in default directory, following the steps from the [install guide](https://docs.openvinotoolkit.org/2020.1/_docs_install_guides_installing_openvino_linux.html#install-openvino).
After the installation, clone this repository to your home directory by using terminal command.
             
    cd ~
    git clone https://github.com/henry1758f/OpenIVNO_Demo_Kit.git
Go to the folder and run this tool
    
    cd ~/OpenVINO_Demo_Kit
    ./Demo_Kits.sh
The Termainal will show the version of this Demo_Kits and the support version of the OpenVINO.
The Demo_Kits will show you 4 operations:
##### 1. [Inference Engine Sample Demo](#inference-engine-sample-demo)
##### 2. [Sample Build](#sample-build)
##### 3. [Model Downloader](#model-downloader)
##### 4. [Query Device](#query-device)

* * * * 
# Inference Engine Sample Demo
In this part, there are demos and samples that enable to run by just key-in some simple number and words, the Demo_Kits will assign available model, target devices and automaticlly run the built samples and demos with parameters. It is useful for a quick demo, no need to change the directory to specific path and type-in a long parameters with those demo and sample app. Also, this Demo_Kits support to run benchmark app with multiple models and output the test result by a .csv file.

### 0. Benchmark App
### 1. Security Barrier Camera Demo
### 2. Interactive Face Detection Demo
### 3. Classification Demo
### 4. Human Pose Estimation Demo. (2D)
### 5. Object Detection and ASYNC API Demo
### 6. Crossroad Camera Demo
### 7. Super Resolution Demo
### 8. Pedestrian Tracker Demo
### 9. Smart Classroom Demo
### 10. Image Segmentation Demo
### 11. Instance Segmentation Demo
### 12. Gaze Estimation Demo
### 13. Text Detection Demo
### 14. Action Recognition Demo
### 15. Multi Camera Multi Person demo
### 16. Face Recognition Demo
### 17. Speech Recognition Demo
### 18. Real Time Speech Recognition Demo

* * * * 
# Sample Build
If you have successfully build the openVINO sample, the terminal will show as following

    2. Sample Build.(Done!)

If not yet, It will not show "Done!" and those sample code need to be build in order to run the samples.
type in "2" and press "Enter" key, Those sample code will be build automatically.

* * * * 
# Model Downloader
In openVINO sample application, DLDT models usually needed. If you have not downloaded those necessary models, you have to run the downloader.

In the Model Downloader Interface, there are 4 options
##### 1. [Download all from DLDT](#1-download-all-from-dldt).
##### 2. [Typein specific DLDT model](#2-typein-specific-dldt-model).
##### 3. [Typein an URL of the model](#3-typein-an-url-of-the-model).
##### 4. [Convert all public model to IR](#4-convert-all-public-model-to-ir)
##### 5. [EXIT the downloader](#5-exit the downloader).
### 1. Download all from DLDT.

 This option will download all the model list on model downloader's yml file, more than 16GB models and IR file will be download, please make sure there's enough free space for these files and the network connection is fine.

### 2. Typein specific DLDT model.

 This option will show you all the pre-trained models and public models on the list, you can copy the name of the model and type in the model name to download specific model.

### 3. Typein an URL of the model.

 This option will download the file directly refer to the URL that type in. This operation using "curl", if not installed on your device, please install by
          
    sudo apt install curl

##### 4. Convert all public model to IR

This option will run Model Optimizer to all the public models downloaded by this kits. Convert and optimize to an IR format model.

### 5. EXIT the downloader.
* * * * 
# Query Device
