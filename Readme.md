# OpenVINO Demo Kit
[![Latest Release](https://badgen.net/github/release/henry1758f/OpenVINO_Demo_Kit)](https://github.com/henry1758f/OpenVINO_Demo_Kit/releases)  [![Apache License Version 2.0](https://badgen.net/github/license/henry1758f/OpenVINO_Demo_Kit)](LICENSE)    ![Check](https://badgen.net/github/checks/henry1758f/OpenVINO_Demo_Kit)

This is a tool that can make you run intel openVINO Demos and samples easily. It helps you to install openVINO, build demos, download/convert models,run DLWorkbench automatically. No need to run those demos/samples or operations manully with long arguments and path. Also, this Demo Kits support to run benchmark app with multiple models dump the throughputs, Latency,etc. in one .csv file. It might help you to suvery your device's AI performance on different kinds of model.
* * *
# Contant
* [Getting Start](#getting-start)
* [Install OpenVINO](#install-openvino)
* [Build Samples and Demos](#build-samples-and-demos)
* [Query Devices](#query-devices)
* [Run Deep Learning Workbench](#run-deep-learning-workbench)
* [Model Downloader](#model-downloader)
* [Run Benchmark App](#run-benchmark-app)
* [Run OpenVINO Demos](#run-openvino-demos)
    * [Demo List](#demo-list)
        * [Security Barrier Camera Demo](#security-barrier-camera-demo)
        * [Interactive Face Detection Demo](#interactive-face-detection-demo)
        * [Classification Demo](#classification-demo)
        * [Object Detection Demo](#object-detection-demo)
        * [Human Pose Estimation Demo. (2D)](#human-pose-estimation-demo-2d)
        * [Human Pose Estimation Demo. (3D)](#human-pose-estimation-demo-3d)
        * [Crossroad Camera Demo](#crossroad-camera-demo)
        * [Image Processing Demo](#image-processing-demo)
        * [Pedestrian tracker demo](#pedestrian-tracker-demo)
        * [Smart Classroom Demo](#smart-classroom-demo)
        * [Image Segmentation Demo](#image-segmentation-demo)
        * [Instance Segmentation Demo](#instance-segmentation-demo)
        * [Gaze Estimation Demo](#gaze-estimation-demo)
        * [Text Detection Demo](#text-detection-demo)
        * [Text Spotting Demo](#text-spotting-demo)
        * [Action Recognition Demo](#action-recognition-demo)
        * [Multi Camera Multi Target Demo](#multi-camera-multi-target-demo)
        * [Colorization Demo](#colorization-demo)
        * [Gesture Recognition Demo](#gesture-recognition-demo)
        * [Face Recognition Demo](#face-recognition-demo)
        * [Social Distance Demo](#social-distance-demo)
        * [Whiteboard Inpainting Demo](#whiteboard-inpainting-demo)
        * [MonoDepth Demo](#monodepth-demo)
        * [Text-to-speech Demo](#text-to-speech-demo)
        * [Real Time Speech Recognition Demo](#real-time-speech-recognition-demo)
        * [BERT Named Entity Recognition Demo](#bert-named-entity-recognition-demo)
* [Default Setting](#default-setting)

* * *
# Getting Start
Following Environments is require to this demo kit
* Platform with Intel Processor
* Ubuntu 18.04 LTS or 20.04 LTS
* Python 3.6 or Later Verison

We suggest to follow the [official guides](https://docs.openvinotoolkit.org/2021.4/openvino_docs_install_guides_installing_openvino_linux.html) to install [Intel® Distribution of OpenVINO™ toolkit](https://software.seek.intel.com/openvino-toolkit) in version 2021.4.
Or you can also use this demo kit to install from APT Repository.

It's very simple to run the Demo Kit. Just open the terminal in OpenVINO Demo Kit directory and run
```sh
./Demo_Kit.sh
```

If you have not install OpenVINO, the Demo kit will show as
```
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|        Intel OpenVINO Demostration      |
|=========================================|
| Ver. 7.0.0 | Support OpenVINO v2021.4.582
| You've installed  openvino_2021.4.582 on 20.04
|
 1. Inference Engine Sample Demo.
 2. Sample Build.
 3. Model Downloader.
 4. Query Device.
 5. Run Deep Learning Workbench.
 6. Install OpenVINO.
```
In this situation, please refer to [Install OpenVINO section](#Install-OpenVINO-using-Demo-Kit).

If you had install OpenVINO, the Demo kit will show as
```
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|        Intel OpenVINO Demostration      |
|=========================================|
| Ver. 7.0.0 | Support OpenVINO v2021.4.582
| You've installed  openvino_2021.4.582 on 20.04
|
 1. Inference Engine Sample Demo.
 2. Sample Build.(Done!)
 3. Model Downloader.
 4. Query Device.
 5. Run Deep Learning Workbench.
```
* * *
## Install OpenVINO
We suggest to follow the [official guides](https://docs.openvinotoolkit.org/2021.4/openvino_docs_install_guides_installing_openvino_linux.html) to install [Intel® Distribution of OpenVINO™ toolkit](https://software.seek.intel.com/openvino-toolkit) in version 2021.4.
Or you can also use this demo kit to install from APT Repository.
### Install OpenVINO using Demo Kit
It's very simple to run the Demo Kit. Just open the terminal in OpenVINO Demo Kit directory and run
```sh
./Demo_Kit.sh
```
If you have not install OpenVINO, the Demo kit will show as
```
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|        Intel OpenVINO Demostration      |
|=========================================|
| Ver. 7.0.0 | Support OpenVINO v2021.4.582
| You've installed  openvino_2021.4.582 on 20.04
|
 1. Inference Engine Sample Demo.
 2. Sample Build.
 3. Model Downloader.
 4. Query Device.
 5. Run Deep Learning Workbench.
 6. Install OpenVINO.
```
choose '6' to install OpenVINO from APT Repository. keyin "6" and press ENTER. (Need internet connection)
If the installation has done, It will go back to the list and the "Install OpenVINO." option will not show again.
* * *
## Build Samples and Demos
The [Open Model Zoo demo applications](https://docs.openvinotoolkit.org/2021.4/omz_demos.html) are console applications that provide robust application templates to help you implement specific deep learning scenarios. These demo codes are include in OpenVINO Package, The Demo Kit can help you build these demos and samples easily, just one key!
It's very simple to run the Demo Kit. Just open the terminal in OpenVINO Demo Kit directory and run
```sh
./Demo_Kit.sh
```
If you have install OpenVINO, and have not build the samples and demos, the Demo kit will show as
```
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|        Intel OpenVINO Demostration      |
|=========================================|
| Ver. 7.0.0 | Support OpenVINO v2021.4.582
| You've installed  openvino_2021.4.582 on 20.04
|
 1. Inference Engine Sample Demo.
 2. Sample Build.
 3. Model Downloader.
 4. Query Device.
 5. Run Deep Learning Workbench.
```
choose '2' to Build all the samples and demos. (Key-in "6" and press ENTER.)
After these samples and demos are built, the Demo Kit will show the Head list again, but Sample build options mark as "DONE"
```
2. Sample Build.(Done!)
```
* * *
## Query Devices
This feature run [Hello Query Device C++ Sample](https://docs.openvinotoolkit.org/latest/openvino_inference_engine_samples_hello_query_device_README.html) queries all available Inference Engine devices, prints their supported metrics and plugin configuration parameters. 
* * *
## Run Deep Learning Workbench
[Deep Learning Workbench (DL Workbench)](https://docs.openvinotoolkit.org/latest/openvino_docs_get_started_get_started_dl_workbench.html) is the OpenVINO™ toolkit UI designed to make the production of pretrained deep learning models significantly easier. And Our Demo kit help you to install and run DL Workbench quickly and easily!

It's very simple to run the Demo Kit. Just open the terminal in OpenVINO Demo Kit directory and run
```sh
./Demo_Kit.sh
```
If you have install OpenVINO, the Demo kit will show as
```
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|        Intel OpenVINO Demostration      |
|=========================================|
| Ver. 7.0.0 | Support OpenVINO v2021.4.582
| You've installed  openvino_2021.4.582 on 20.04
|
 1. Inference Engine Sample Demo.
 2. Sample Build.
 3. Model Downloader.
 4. Query Device.
 5. Run Deep Learning Workbench.
```
choose '5' to Run Deep Learning Workbench (Key-in "5" and press ENTER.)
The Demo Kit will guide you to https://openvinotoolkit.github.io/workbench_aux/ .
Select your Options and run Execute / Results from appears from the website.
* * *
## Model Downloader
Model Downloader in the Demo Kit enable you to download Open Model Zoo(OMZ) model easily, and help you to convert/quantize public model from OMZ public models.
It's very simple to run the Demo Kit. Just open the terminal in OpenVINO Demo Kit directory and run
```sh
./Demo_Kit.sh
```
If you have install OpenVINO, the Demo kit will show as
```
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|        Intel OpenVINO Demostration      |
|=========================================|
| Ver. 7.0.0 | Support OpenVINO v2021.4.582
| You've installed  openvino_2021.4.582 on 20.04
|
 1. Inference Engine Sample Demo.
 2. Sample Build.
 3. Model Downloader.
 4. Query Device.
 5. Run Deep Learning Workbench.
```
choose '3' to open the downloader page (Key-in "3" and press ENTER.)
```sh
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|            Model Downloader             |
|=========================================|
| Support OpenVINO 2021.4.582

 1. Download all from DLDT. (about 45.3 GB)
 2. Typein specific DLDT model.
 3. Typein an URL of the model.
 4. Convert all public model to IR (Need about 36.9G Bytes)
 5. EXIT the downloader.
 6. Quantize all public models. (Need about 4.1GB for COCO, VOC2012, VOC2007 dataset)
```
In Demo Kit's Model Downloader you can ...
* ### Download all models form Open Model Zoo
* ### Download Specific Open Model Zoo's model
* ### Download Model from a URL
* ### Convert all public model to IR
* ### Quantize all public models

* * *
## Run Benchmark App
> You can quick start with the Benchmark Tool inside the OpenVINO™ [Deep Learning Workbench (DL Workbench)](https://docs.openvinotoolkit.org/latest/openvino_docs_get_started_get_started_dl_workbench.html). DL Workbench is the OpenVINO™ toolkit UI you to import a model, analyze its performance and accuracy, visualize the outputs, optimize and prepare the model for deployment on various Intel® platforms. 

The Demo Kit use the [Benchmark C++ Tool](https://docs.openvinotoolkit.org/2021.4/openvino_inference_engine_samples_benchmark_app_README.html) to estimate deep learning inference performance on supported devices (default in asynchronous mode). It is convient especially if you want to estimate multiple models from Open Model Zoo on your devices. The Demo Kit will export a csv file including Throughput, Latency,duration and count message of all/Specific model's benchmarking results.
It's very simple to run the Demo Kit. Just open the terminal in OpenVINO Demo Kit directory and run
```sh
./Demo_Kit.sh
```
If you have install OpenVINO, and also have built samples, the Demo kit will show as
```
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|        Intel OpenVINO Demostration      |
|=========================================|
| Ver. 7.0.0 | Support OpenVINO v2021.4.582
| You've installed  openvino_2021.4.582 on 20.04
|
 0. Run Benchmark App
 1. Inference Engine Sample Demo.
 2. Sample Build.(Done!)
 3. Model Downloader.
 4. Query Device.
 5. Run Deep Learning Workbench.
```
choose '0' to Run Benchmark App (Key-in "0" and press ENTER.)
```
[Input your target device. (CPU,GPU,MYRIAD,HDDL,MULTI,HETERO,etc.)] >>>
```
input the device you want to test. (e.g. [CPU](https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_CPU.html) / [GPU](https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_GPU.html) / [MYRIAD](https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_MYRIAD.html) / [HDDL](https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_HDDL.html) / [MULTI](https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_MULTI.html):CPU,GPU .....)

```
======= Model List =======
1. [dldt] 	action-recognition-0001-decoder		[FP16][FP16-INT8][FP32]
2. [dldt] 	action-recognition-0001-encoder		[FP16][FP16-INT8][FP32]
3. [dldt] 	age-gender-recognition-retail-0013		[FP16][FP16-INT8][FP32]
 .
 .
 .
281. [tf] 	yolo-v3-tiny-tf		[FP16][FP32][FP16-INT8*]
282. [tf] 	yolo-v4-tf		[FP16][FP32][FP16-INT8*]
283. [tf] 	yolo-v4-tiny-tf		[FP16][FP32]
 Input the name or number of the Model for benchmarking, or Input "all" to test all models >>> 
 ```
 You can input "all" to test all models.
 To test specific model, you can input the name of the model, the number of the model or the path to a model.
 * ### All model Benchmarking
```
[Input if you need to run any specific arguments, or press ENTER to skip it.] >>>
```
You can input additional arguments for benchmark tool, or just press ENTER to skip it. For detail info about the benchmark tool's argument, please visit the [OpenVINO online documents](https://docs.openvinotoolkit.org/latest/openvino_inference_engine_samples_benchmark_app_README.html).
```
[Input the Index to skip some models during "ALL" test, or press ENTER to skip it.] >>>
```
In some conditions, you may wants to skip some of the models. You can input the index number of the model that you want to start testing. (e.g. input "281", the benchmark tool will only test model from index 281 to final model).

You can also skip some model by edit "model_test_ban_list" in the "OpenVINO_Demo_Kit/Source/benchmark.py", here's an example:
```python
model_test_ban_list = ['instance-segmentation-security-0091','person-detection-0106','text-spotting-0005-detector']
```
In this case, these three models,'instance-segmentation-security-0091','person-detection-0106','text-spotting-0005-detector' will not been benchmark.
 * ### Specific Model Benchmarking
```
[Input if you need to run any specific arguments, or press ENTER to skip it.] >>>
```
You can input additional arguments for benchmark tool, or just press ENTER to skip it. For detail info about the benchmark tool's argument, please visit the [OpenVINO online documents](https://docs.openvinotoolkit.org/latest/openvino_inference_engine_samples_benchmark_app_README.html).

* * *
# Run OpenVINO Demos
This Demo Kit helps you to quickly run OpenVINO Demos in a simple way, by just input some index numbers instead of a long arguments.
It's very simple to run the Demo Kit. Just open the terminal in OpenVINO Demo Kit directory and run
```sh
./Demo_Kit.sh
```
If you have install OpenVINO, and also have built samples, the Demo kit will show as
```
|=========================================|
|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |
|                                         |
|        Intel OpenVINO Demostration      |
|=========================================|
| Ver. 7.0.0 | Support OpenVINO v2021.4.582
| You've installed  openvino_2021.4.582 on 20.04
|
 0. Run Benchmark App
 1. Inference Engine Sample Demo.
 2. Sample Build.(Done!)
 3. Model Downloader.
 4. Query Device.
 5. Run Deep Learning Workbench.
```
choose '1' to Run Benchmark App (Key-in "1" and press ENTER.)
Then the demo kit will show up a list
* * *
## Demo List
 1. [Security Barrier Camera Demo](#security-barrier-camera-demo)
 2. [Interactive Face Detection Demo](#interactive-face-detection-demo)
 3. [Classification Demo](#classification-demo)
 4. [Object Detection Demo](#object-detection-demo)
 5. [Human Pose Estimation Demo. (2D)](#human-pose-estimation-demo-2d)
 6. [Human Pose Estimation Demo. (3D)](#human-pose-estimation-demo-3d)
 7. [Crossroad Camera Demo](#crossroad-camera-demo)
 8. [Image Processing Demo](#image-processing-demo)
 9. [Pedestrian tracker demo](#pedestrian-tracker-demo)
10. [Smart Classroom Demo](#smart-classroom-demo)
11. [Image Segmentation Demo](#image-segmentation-demo)
12. [Instance Segmentation Demo](#instance-segmentation-demo)
13. [Gaze Estimation Demo](#gaze-estimation-demo)
14. [Text Detection Demo](#text-detection-demo)
15. [Text Spotting Demo](#text-spotting-demo)
16. [Action Recognition Demo](#action-recognition-demo)
17. [Multi Camera Multi Target Demo](#multi-camera-multi-target-demo)
18. [Colorization Demo](#colorization-demo)
19. [Gesture Recognition Demo](#gesture-recognition-demo)
20. [Face Recognition Demo](#face-recognition-demo)
21. [Social Distance Demo](#social-distance-demo)
22. [Whiteboard Inpainting Demo](#whiteboard-inpainting-demo)
23. [MonoDepth Demo](#monodepth-demo)
24. [Text-to-speech Demo](#text-to-speech-demo)
25. [Real Time Speech Recognition Demo](#real-time-speech-recognition-demo)
26. [BERT Named Entity Recognition Demo](#bert-named-entity-recognition-demo)

### Security Barrier Camera Demo
* #### Intro
     This demo showcases Vehicle and License Plate Detection network followed by the Vehicle Attributes Recognition and License Plate Recognition networks applied on top of the detection results.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_security_barrier_camera_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Security Barrier Camera Demo**
    Just input "1" or the index that shown and press ENTER.
    
   **2. Select a Vehicle and License Plate Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. vehicle-license-plate-detection-barrier-0106		[FP16][FP16-INT8][FP32]
    		[dldt] Multiclass (vehicle -  license plates) detector based on MobileNetV2+SSD
    2. vehicle-license-plate-detection-barrier-0123		[FP16][FP32]
    		[tf] This is a MobileNetV2 + SSD-based vehicle and (Chinese) license plate detector for the "Barrier" use case.
    
     [ Select a Vehicle and License Plate Detection model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model "vehicle-license-plate-detection-barrier-0106"]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    
    **3. Select a Vehicle Attributes Recognition model**
    The Demo Kit will show available model list. Choose your model just like step 2.
    
    **4. Select a Vehicle and License Plate Detection model**
    The Demo Kit will show available model list. Choose your model just like step 2.
    
    **5. Input the Path to video or image files**
    As title, typein a Path to video or image files.
    
    **6. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
* #### [How to modify the Default Setting](#default-setting)
    
### Interactive Face Detection Demo
* #### Intro
     This demo showcases Object Detection task applied for face recognition using sequence of neural networks. Async API can improve overall frame-rate of the application, because rather than wait for inference to complete, the application can continue operating on the host while accelerator is busy. This demo executes five parallel infer requests for the Age/Gender Recognition, Head Pose Estimation, Emotions Recognition, Facial Landmarks Detection and Antispoofing Classifier networks that run simultaneously. 
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_interactive_face_detection_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Interactive Face Detection Demo**
    Just input "2" or the index that shown and press ENTER.
    
   **2. Select a Face Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. face-detection-adas-0001		[FP16][FP16-INT8][FP32]
    		[dldt] Face Detection (MobileNet with reduced channels + SSD with weights sharing)
    2. face-detection-0200		[FP16][FP16-INT8][FP32]
    		[dldt] Face Detection based on MobileNetV2 (SSD).
    3. face-detection-0202		[FP16][FP16-INT8][FP32]
    		[dldt] Face Detection based on MobileNetV2 (SSD).
    .
    .
    .
     [ Select a Face Detection model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    
    **3. Select a Age/Gender Recognition model**
    The Demo Kit will show available model list. Choose your model just like step 2.
    
    **4. Select a Head Pose Estimation model**
    The Demo Kit will show available model list. Choose your model just like step 2.
    
    **5. Select a Emotions Recognition model**
    The Demo Kit will show available model list. Choose your model just like step 2.
    
    **6. Select a Facial Landmarks Estimation model**
    The Demo Kit will show available model list. Choose your model just like step 2.
    
    **7. Select a Antispoofing Classification model**
    The Demo Kit will show available model list. Choose your model just like step 2.
    
    **8. Input the Path to video,camera ID or image files**
    As title, The input must be a single image, a folder of images, video file or camera id.
    
    **9. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
* #### [How to modify the Default Setting](#default-setting)
    
### Classification Demo
* #### Intro
     The demo visualize OpenVINO performance on inference of neural networks for image classification.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_classification_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Classification Demo**
    Just input "3" or the index that shown and press ENTER.
    
   **2. Select a Classification model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    1. resnet18-xnor-binary-onnx-0001		[FP16-INT1][FP32-INT1]
		[dldt] ResNet-18 Binary with XNOR weight binarization
    2. resnet50-binary-0001		[FP16-INT1][FP32-INT1]
    		[dldt] ResNet-50 Binary
    3. aclnet		[FP16][FP32]
    		[onnx] The "AclNet" model is designed to perform sound classification and is trained on internal dataset of environmental sounds for 53 different classes, listed in file "<omz_dir>/data/dataset_classes/aclnet.txt". For details about the model, see this paper <https://arxiv.org/abs/1811.06669>.
    The model input is a segment of PCM audio samples in "N, C, 1, L" format.
    The model output for "AclNet" is the sound classifier output for the 53 different environmental sound classes from the internal sound database.
    .
    .
    .
    [ Select a Classification model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein a Path to video or image files.
    
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
* #### [How to modify the Default Setting](#default-setting)

### Object Detection Demo
* #### Intro
     This demo showcases inference of Object Detection networks using Async API. Async API usage can improve overall frame-rate of the application, because rather than wait for inference to complete, the app can continue doing things on the host, while accelerator is busy. Specifically, this demo keeps the number of Infer Requests that you have set using nireq flag. While some of the Infer Requests are processed by Inference Engine, the other ones can be filled with new frame data and asynchronously started or the next output can be taken from the Infer Request and displayed.
    This technique can be generalized to any available parallel slack, for example, doing inference and simultaneously encoding the resulting (previous) frames or running further inference, like some emotion detection on top of the face detection results. There are important performance caveats though, for example the tasks that run in parallel should try to avoid oversubscribing the shared compute resources. 
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_object_detection_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Object Detection Demo**
    Just input "4" or the index that shown and press ENTER.
    
   **2. Select a Object Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. face-detection-0200		[FP16][FP16-INT8][FP32]
    		[dldt] Face Detection based on MobileNetV2 (SSD).
    2. face-detection-0202		[FP16][FP16-INT8][FP32]
    		[dldt] Face Detection based on MobileNetV2 (SSD).
    3. face-detection-0204		[FP16][FP16-INT8][FP32]
    		[dldt] Face Detection based on MobileNetV2 (SSD).
    .
    .
    .
    [ Select a Object Detection model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)

### Human Pose Estimation Demo. (2D)
* #### Intro
     This demo showcases the work of multi-person 2D pose estimation algorithm. The task is to predict a pose: body skeleton, which consists of keypoints and connections between them, for every person in an input video. The pose may contain up to 18 keypoints: ears, eyes, nose, neck, shoulders, elbows, wrists, hips, knees, and ankles. 
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_human_pose_estimation_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Human Pose Estimation Demo. (2D)**
    Just input "5" or the index that shown and press ENTER.
    
   **2. Select a Pose Estimation Model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ====== Model List =======
    1. human-pose-estimation-0001		[FP16][FP16-INT8][FP32]
    		[dldt] 2D human pose estimation with tuned mobilenet backbone (based on OpenPose).
    2. single-human-pose-estimation-0001		[FP16][FP32]
    		[pytorch] Single human pose estimation model based on paper <https://arxiv.org/abs/1906.04104>.
    3. human-pose-estimation-0005		[FP16][FP32]
    		[dldt] 2D human pose estimation based on EfficientHRNet.
    .
    .
    .
	[ Select a Pose Estimation Model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Human Pose Estimation Demo. (3D)
* #### Intro
     This demo demonstrates how to run 3D Human Pose Estimation models using OpenVINO™.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_human_pose_estimation_3d_demo_python.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Human Pose Estimation Demo. (3D)**
    Just input "6" or the index that shown and press ENTER.
    
   **2. Select a 3D Pose Estimation Model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. human-pose-estimation-3d-0001		[FP16][FP32]
    		[pytorch] Multi-person 3D human pose estimation model based on the Lightweight OpenPose <https://arxiv.org/abs/1811.12004> and Single-Shot Multi-Person 3D Pose Estimation From Monocular RGB <https://arxiv.org/abs/1712.03453> papers.
    
     [ Select a 3D Pose Estimation Model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Crossroad Camera Demo
* #### Intro
     This demo provides an inference pipeline for person detection, recognition and reidentification. The demo uses Person Detection network followed by the Person Attributes Recognition and Person Reidentification Retail networks applied on top of the detection results. 
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_crossroad_camera_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Crossroad Camera Demo**
    Just input "7" or the index that shown and press ENTER.
    
   **2. Select a Person/Vehicle/Bike Detection Crossroad model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. person-vehicle-bike-detection-crossroad-0078		[FP16][FP16-INT8][FP32]
    		[dldt] Multiclass (person -  vehicle -  non-vehicle) detector based on SSD detection architecture -  RMNet backbone and learnable image downscale block (person-vehicle-bike-detection-crossroad-0066 with extra pooling)
    2. person-vehicle-bike-detection-crossroad-1016		[FP16][FP16-INT8][FP32]
    		[dldt] Multiclass (person -  vehicle -  non-vehicle) detector based on SSD detection architecture -  MobileNetV2 backbone)
    3. person-vehicle-bike-detection-crossroad-yolov3-1020		[FP16][FP16-INT8][FP32]
    		[dldt] YOLO v3 finetuned for person-vehicle-bike detection task
    
     [ Select a Person/Vehicle/Bike Detection Crossroad model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Person Attributes Recognition Crossroad model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Select a Person Reidentification Retail model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **5. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **6. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Image Processing Demo
* #### Intro
    This demo processes the image according to the selected type of processing. The demo can work with the next types:
    * super_resolution
    * deblurring
    Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_image_processing_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Image Processing Demo**
    Just input "8" or the index that shown and press ENTER.
    
   **2. Select a Super Resolution Model or Deblur Model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. single-image-super-resolution-1032		[FP16][FP16-INT8][FP32]
    		[dldt] Super resolution model
    2. single-image-super-resolution-1033		[FP16][FP16-INT8][FP32]
    		[dldt] Super resolution model
    3. text-image-super-resolution-0001		[FP16][FP16-INT8][FP32]
    		[dldt] Super resolution model
    .
    .
    .
     [ Select a Super Resolution Model or Deblur Model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Pedestrian tracker demo
* #### Intro
     This demo showcases Pedestrian Tracking scenario: it reads frames from an input video sequence, detects pedestrians in the frames, and builds trajectories of movement of the pedestrians in a frame-by-frame manner.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_crossroad_camera_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Pedestrian tracker demo**
    Just input "9" or the index that shown and press ENTER.
    
   **2. Select a Pedestrian Detection Retail model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. person-detection-retail-0002		[FP16][FP16-INT8][FP32]
    		[dldt] Person detection (HyperNet+RFCN+DetectionOutput). Used in Audience Analytics.
    2. person-detection-retail-0013		[FP16][FP16-INT8][FP32]
    		[dldt] Pedestrian detection (RMNet with lrelu + SSD)
    3. pedestrian-detection-adas-0002		[FP16][FP16-INT8][FP32]
    		[dldt] Pedestrian detector based on ssd + mobilenet with reduced channels number.
    .
    .
    .
     [ Select a Pedestrian Detection Retail model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Pedestrian Reidentification Retail model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **5. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Smart Classroom Demo
* #### Intro
     The demo shows an example of joint usage of several neural networks to detect student actions (sitting, standing, raising hand for the person-detection-action-recognition-0005 model and sitting, writing, raising hand, standing, turned around, lie on the desk for the person-detection-action-recognition-0006 model) and recognize people by faces in the classroom environment. The demo uses Async API for action and face detection networks. It allows to parallelize execution of face recognition and detection: while face recognition is running on one accelerator, face and action detection could be performed on another.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_smart_classroom_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Smart Classroom Demo**
    Just input "10" or the index that shown and press ENTER.
    
   **2. Select a Face Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. face-detection-adas-0001		[FP16][FP16-INT8][FP32]
        [dldt] Face Detection (MobileNet with reduced channels + SSD with weights sharing)
    2. face-detection-retail-0004		[FP16][FP16-INT8][FP32]
        [dldt] Face Detection (SqNet1.0modif+single scale) without BatchNormalization trained with negatives.
    3. face-detection-retail-0005		[FP16][FP16-INT8][FP32]
        [dldt] Face Detection based on MobileNetV2.
    .
    .
    .
    [ Select a Face Detection model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Person/Action Detection Retail model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Select a Facial Landmarks Regression Retail model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **5. Select a Face Reidentification Retail model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **6. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **7. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Image Segmentation Demo
* #### Intro
    This topic demonstrates how to run the Image Segmentation demo application, which does inference using semantic segmentation networks.
    Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_segmentation_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
    **1. Input the index number of Image Segmentation Demo**
    Just input "11" or the index that shown and press ENTER.
    
   **2. Select a Image segmentation model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. deeplabv3		[FP16][FP32]
        [tf] DeepLab is a state-of-art deep learning model for semantic image segmentation. For details see paper <https://arxiv.org/abs/1706.05587>.
    2. fastseg-large		[FP16][FP32]
        [pytorch] fastseg-large is an accurate real-time semantic segmentation model, pre-trained on Cityscapes <https://www.cityscapes-dataset.com> dataset for 19 object classes, listed in "<omz_dir>/data/dataset_classes/cityscapes_19cl.txt" file. See Cityscapes classes definition <https://www.cityscapes-dataset.com/dataset-overview> for more details. The model was built on MobileNetV3 large backbone and modified segmentation head based on LR-ASPP. This model can be used for efficient segmentation on a variety of real-world street images. For model implementation details see original repository <https://github.com/ekzhang/fastseg>.
    3. fastseg-small		[FP16][FP32]
        [pytorch] fastseg-small is an accurate real-time semantic segmentation model, pre-trained on Cityscapes <https://www.cityscapes-dataset.com> dataset for 19 object classes, listed in "<omz_dir>/data/dataset_classes/cityscapes_19cl.txt" file. See Cityscapes classes definition <https://www.cityscapes-dataset.com/dataset-overview> for more details. The model was built on MobileNetV3 small backbone and modified segmentation head based on LR-ASPP. This model can be used for efficient segmentation on a variety of real-world street images. For model implementation details see original repository <https://github.com/ekzhang/fastseg>.
    .
    .
    .
    [ Select a Image segmentation model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Instance Segmentation Demo
* #### Intro
    This demo shows how to perform instance segmentation using OpenVINO.
    Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_instance_segmentation_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Image Segmentation Demo**
    Just input "12" or the index that shown and press ENTER.
    
   **2. Select a instance segmentation model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. instance-segmentation-security-0002		[FP16][FP16-INT8][FP32]
        [dldt] General purpose instance segmentation model. Mask R-CNN with ResNet50 backbone -  FPN -  RPN -  detection and segmentation heads.
    2. instance-segmentation-security-0091		[FP16][FP16-INT8][FP32]
        [dldt] General purpose instance segmentation model. Cascade Mask R-CNN with ResNet101 backbone and deformable convolution V2.
    3. instance-segmentation-security-0228		[FP16][FP16-INT8][FP32]
        [dldt] General purpose instance segmentation model. Mask R-CNN with ResNet101 backbone and light FPN -  RPN -  detection and segmentation heads.
        [ Select a instance segmentation model, or press ENTER to run default setting] >>>
    .
    .
    .
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Gaze Estimation Demo
* #### Intro
     This demo showcases the work of gaze estimation model.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_gaze_estimation_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Gaze Estimation Demo**
    Just input "13" or the index that shown and press ENTER.
    
   **2. Select a Gaze Estimation model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. gaze-estimation-adas-0002		[FP16][FP16-INT8][FP32]
        [dldt] Gaze estimation for ADAS

    [ Select a Gaze Estimation model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Face Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Select a Head Pose Estimation model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **5. Select a Facial Landmarks Estimation model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **6. Select a Open/Closed Eye Estimation model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **7. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **8. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Text Detection Demo
* #### Intro
     The demo shows an example of using neural networks to detect and recognize printed text rotated at any angle in various environment.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_text_detection_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Text Detection Demo**
    Just input "14" or the index that shown and press ENTER.
    
   **2. Select a Text Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. horizontal-text-detection-0001		[FP16][FP16-INT8][FP32]
        [dldt] Horizontal text detector based on FCOS with light MobileNetV2 backbone
    2. text-detection-0003		[FP16][FP16-INT8][FP32]
        [dldt] Detects oriented text.
    3. text-detection-0004		[FP16][FP16-INT8][FP32]
        [dldt] Detects oriented text.

    [ Select a Text Detection model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Text Recognition model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **5. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Text Spotting Demo
* #### Intro
     This demo shows how to run Text Spotting models. Text Spotting models allow us to simultaneously detect and recognize text.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_text_spotting_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Text Spotting Demo**
    Just input "15" or the index that shown and press ENTER.
    
   **2. Select a trained Mask-RCNN model with additional text features output, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. text-spotting-0005-detector		[FP16][FP16-INT8][FP32]
        [dldt] Mask R-CNN-based text detector.

    [ Select a trained Mask-RCNN model with additional text features output, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Trained text recognition model (encoder part), or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Select a Trained text recognition model (decoder part), or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **5. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **6. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Action Recognition Demo
* #### Intro
     This is the demo application for Action Recognition algorithm, which classifies actions that are being performed on input video. 
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_action_recognition_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Action Recognition Demo**
    Just input "16" or the index that shown and press ENTER.
    
   **2. Select a Encoder model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. driver-action-recognition-adas-0002-encoder		[FP16][FP16-INT8][FP32]
        [dldt] Video Transformer Network for driver action recognition. Encoder part
    2. action-recognition-0001-encoder		[FP16][FP16-INT8][FP32]
        [dldt] General-purpose action recognition model for Kinetics-400 dataset based on Video Transformer Network approach. Encoder part
    3. weld-porosity-detection-0001		[FP16][FP16-INT8][FP32]
        [dldt] ResNet18 based network for porosity weld recognition.
    .
    .
    .
    [ Select a Encoder model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a decoder model, or press ENTER to run default setting**
    **This is Only for en-de model, if not, please skip it.**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **5. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Multi Camera Multi Target Demo
* #### Intro
      This demo demonstrates how to run Multi Camera Multi Target (e.g. person or vehicle) demo using OpenVINO™.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_multi_camera_multi_target_tracking_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Multi Camera Multi Target Demo**
    Just input "17" or the index that shown and press ENTER.
  
  **2. Select a type of object tracking**
  The Demo Kit will show available type list
  ```
  1. Object Detection
  2. Object Instance Segmentation
  >>> 
  ```
  Input the index of the tracking type.
   **3. Select a Object Detection/Object Instance Segmentation model, or press ENTER to run default setting**
    The Demo Kit will show available model list
 
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **3-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **3-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **4. Select a object re-identification model, or press ENTER to run default setting**
    **This is Only for en-de model, if not, please skip it.**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **5. Input the Path to video or image files**
    Specify 2 inputs to process. The inputs must be indexes of cameras or paths to vide files. sperate them by space.
    **6. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Colorization Demo
* #### Intro
    This demo demonstrates an example of using neural networks to colorize a grayscale image or video.
    Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_colorization_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Colorization Demo**
    Just input "18" or the index that shown and press ENTER.
    
   **2. Select a Colorization Model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. colorization-siggraph		[FP16][FP32]
        [pytorch] The "colorization-siggraph" model is one of the colorization <https://arxiv.org/abs/1705.02999> group of models designed to real-time user-guided image colorization. Model was trained on ImageNet dataset with synthetically generated user interaction. For details about this family of models, check out the repository <https://github.com/richzhang/colorization>.
    Model consumes as input L-channel of LAB-image (also user points and binary mask as optional inputs). Model give as output predict A- and B-channels of LAB-image.
    2. colorization-v2		[FP16][FP32]
        [pytorch] The "colorization-v2" model is one of the colorization <https://arxiv.org/abs/1603.08511> group of models designed to perform image colorization. Model was trained on ImageNet dataset. For details about this family of models, check out the repository <https://github.com/richzhang/colorization>.
    Model consumes as input L-channel of LAB-image. Model give as output predict A- and B-channels of LAB-image.
    .
    .
    .
    [ Select a Colorization Model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Gesture Recognition Demo
* #### Intro
     This demo demonstrates how to run Gesture (e.g. [American Sign Language (ASL) gestures](https://www.handspeak.com/)) Recognition models using OpenVINO™ toolkit.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_gesture_recognition_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Gesture Recognition Demo**
    Just input "19" or the index that shown and press ENTER.
    
   **2. Select a Trained Gesture Recognition Model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. asl-recognition-0004		[FP16][FP16-INT8][FP32]
        [dldt] S3D MobileNet V3 based ASL recogniton network.

    [ Select a Trained Gesture Recognition Model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Trained Person Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **5. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Face Recognition Demo
* #### Intro
     This example demonstrates an approach to create interactive applications for video processing. It shows the basic architecture for building model pipelines supporting model placement on different devices and simultaneous parallel or sequential execution using OpenVINO library in Python. In particular, this demo uses 3 models to build a pipeline able to detect faces on videos, their keypoints (aka "landmarks"), and recognize persons using the provided faces database (the gallery). 
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_face_recognition_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Face Recognition Demo**
    Just input "20" or the index that shown and press ENTER.
    
   **2. Select a Face Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. face-detection-adas-0001		[FP16][FP16-INT8][FP32]
        [dldt] Face Detection (MobileNet with reduced channels + SSD with weights sharing)
    2. face-detection-retail-0004		[FP16][FP16-INT8][FP32]
        [dldt] Face Detection (SqNet1.0modif+single scale) without BatchNormalization trained with negatives.
    3. face-detection-retail-0005		[FP16][FP16-INT8][FP32]
        [dldt] Face Detection based on MobileNetV2.
    .
    .
    .
    [ Select a Face Detection model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Facial Landmarks Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Select a Face Reidentification model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **5. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **6. Input a path for the face gallery data**
    Input a path for the face gallery data. Default is $HOME/Pictures/face_gallery
    **7. Allow growing the face database?**
    Please input "Y" or "n" to enable the Allow growing flag of this demo
    **7. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Social Distance Demo
* #### Intro
     This demo showcases a retail social distance application that detects people and measures the distance between them. If this distance is less than a value previously provided by the user, then an alert is triggered.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_social_distance_demo_cpp.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Social Distance Demo**
    Just input "21" or the index that shown and press ENTER.
    
   **2. Select a Person Detection model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. person-detection-0106		[FP16][FP16-INT8][FP32]
        [dldt] Person detector based on Cascade R-CNN with ResNet50 backbone
    2. person-detection-0200		[FP16][FP16-INT8][FP32]
        [dldt] MobileNetV2-SSD with two heads and clustered priors for 256x256 resolution.
    3. person-detection-0201		[FP16][FP16-INT8][FP32]
        [dldt] MobileNetV2-SSD with two heads and clustered priors for 384x384 resolution.
    .
    .
    .
    [ Select a Person Detection model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Select a Person Re-Identification model, or press ENTER to run default setting**
    The Demo Kit will show available model list. Choose your model just like step 2.
    **4. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **5. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Whiteboard Inpainting Demo
* #### Intro
     This demo focuses on a whiteboard text overlapped by a person. The demo shows how to use the OpenVINO™ toolkit to detect and hide a person on a video so that all text on a whiteboard is visible.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_whiteboard_inpainting_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Whiteboard Inpainting Demo**
    Just input "22" or the index that shown and press ENTER.
    
   **2. Select a Instance/Semantic Segmentation model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. instance-segmentation-security-0002		[FP16][FP16-INT8][FP32]
        [dldt] General purpose instance segmentation model. Mask R-CNN with ResNet50 backbone -  FPN -  RPN -  detection and segmentation heads.
    2. instance-segmentation-security-0091		[FP16][FP16-INT8][FP32]
        [dldt] General purpose instance segmentation model. Cascade Mask R-CNN with ResNet101 backbone and deformable convolution V2.
    3. instance-segmentation-security-0228		[FP16][FP16-INT8][FP32]
        [dldt] General purpose instance segmentation model. Mask R-CNN with ResNet101 backbone and light FPN -  RPN -  detection and segmentation heads.
    .
    .
    .
    [ Select a Instance/Semantic Segmentation model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to video or image files**
    As title, typein path to single image, a folder of images, video file or camera id.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### MonoDepth Demo
* #### Intro
     This topic demonstrates how to run the MonoDepth demo application, which produces a disparity map for a given input image. To this end, the code uses the network described in [Towards Robust Monocular Depth Estimation: Mixing Datasets for Zero-shot Cross-dataset Transfer](https://arxiv.org/abs/1907.01341).
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_monodepth_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of MonoDepth Demo**
    Just input "23" or the index that shown and press ENTER.
    
   **2. Select a trained model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. fcrn-dp-nyu-depth-v2-tf		[FP16][FP32]
        [tf] This is a model for monocular depth estimation trained on the NYU Depth V2 dataset, as described in the paper Deeper Depth Prediction with Fully Convolutional Residual Networks <https://arxiv.org/abs/1606.00373>, where it is referred to as ResNet-UpProj. The model input is a single color image. The model output is an inverse depth map that is defined up to an unknown scale factor. More details can be found in the following repository <https://github.com/iro-cp/FCRN-DepthPrediction>.
    2. midasnet		[FP16][FP32]
        [pytorch] MidasNet is a model for monocular depth estimation trained by mixing several datasets; as described in the following paper: Towards Robust Monocular Depth Estimation: Mixing Datasets for Zero-Shot Cross-Dataset Transfer <https://arxiv.org/abs/1907.01341>
    The model input is a blob that consists of a single image of "1, 3, 384, 384" in "RGB" order.
    The model output is an inverse depth map that is defined up to an unknown scale factor.

    [ Select a trained model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query-devices) .
    **3. Input the Path to image file**
    As title, typein path to single image.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
### Text-to-speech Demo
* #### Intro
     The text to speech demo show how to run the ForwardTacotron and WaveRNN models or modified ForwardTacotron and MelGAN models to produce an audio file for a given input text file. The demo is based on https://github.com/seungwonpark/melgan, https://github.com/as-ideas/ForwardTacotron and https://github.com/fatchord/WaveRNN repositories.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_text_to_speech_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Text-to-speech Demo**
    Just input "24" or the index that shown and press ENTER.
    
   **2. Select Which kind of speech synthesis you want to run**
    The Demo Kit will show available speech synthesis list
    ```
    [ Select Which kind of speech synthesis you want to run. ]
    1. Speech synthesis with ForwardTacotron and WaveRNN models
    2. Speech synthesis with text-to-speech-en-0001 models
    3. Speech synthesis with multi-speaker text-to-speech-en-multi-0001 models
    ```
    **3. Input the Path for a text file, or Use OpenVINO_Demo_Kit/testing_source/speech_text.txt as default.**
    As title, typein the Path for a text file.Or skip it to Use OpenVINO_Demo_Kit/testing_source/speech_text.txt as default.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)

### Real Time Speech Recognition Demo
* #### Intro
     This demo provides a GUI interface for automatic speech recognition using selected OpenVINO™ Inference Engine plugin, OpenVINO™ Feature Extraction Library, and OpenVINO™ Decoder Library.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/openvino_inference_engine_samples_speech_libs_and_demos_Live_speech_recognition_demo.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of Real Time Speech Recognition Demo**
    Just input "25" or the index that shown and press ENTER.
    **2. Start Running**
    Then the Demo Kit will help you to run the demo. Please Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/openvino_inference_engine_samples_speech_libs_and_demos_Live_speech_recognition_demo.html) for detail information.

    
    
### BERT Named Entity Recognition Demo
* #### Intro
     Named Entity Recognition (NER) demo application that uses a CONLL2003-tuned BERT model for inference.
     Visit [OpenVINO Online Docs](https://docs.openvinotoolkit.org/2021.4/omz_demos_bert_named_entity_recognition_demo_python.html) for detail information.
* #### How to run with Demo Kit
   **1. Input the index number of BERT Named Entity Recognition Demo**
    Just input "26" or the index that shown and press ENTER.
    
   **2. Select a trained model, or press ENTER to run default setting**
    The Demo Kit will show available model list
    ```
    ======= Model List =======
    1. bert-base-ner		[FP16][FP32]
        [pytorch] "bert-base-ner" is a fine-tuned BERT model that is ready to use for Named Entity Recognition and achieves state-of-the-art performance for the NER task. It has been trained to recognize four types of entities: location (LOC), organizations (ORG), person (PER) and Miscellaneous (MISC).
    Specifically, this model is a bert-base-cased model that was fine-tuned on the English version of the standard CoNLL-2003 Named Entity Recognition <https://www.aclweb.org/anthology/W03-0419.pdf> dataset. For details about the original model, check out BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding <https://arxiv.org/abs/1810.04805>, HuggingFace's Transformers: State-of-the-art Natural Language Processing <https://arxiv.org/abs/1910.03771> papers and repository <https://github.com/huggingface/transformers>
    Tokenization occurs using the BERT tokenizer (see the demo code for implementation details) and the enclosed "vocab.txt" dictionary file.

    [ Select a Named Entity Recognition (NER) model, or press ENTER to run default setting] >>>
    ```
    You can select an model from open Model Zoo(OMZ) by input the index of the model list and press ENTER.
    Or you can have a quick run by press ENTER directly, the Demo Kit will run with default setting.
    You can also input the model path to the model you want.
   **2-1. Select precisions of the model**
    The Demo Kit will show available precisions of this model if you choose an OMZ model.
    ```
    [ Available Precisions ]
    1. [FP16]
    2. [FP16-INT8]
    3. [FP32]
    
     [Select precisions of the model " < model name > "]  >>
    ```
    Just input the index of the precision shown on list.
    **2-2. Typein the target device for inference this model**
    As title, typein the target device such as CPU / GPU / MYRIAD / MULTI:CPU,GPU / HDDL / HETERO:FPGA,CPU .... 
    the available target device can list by using [Query Devices](#query_devices) .
    **3. Input the link to a website**
    As title, typein link to a website as a input source.
    **4. Start Running**
    Then the Demo Kit will help you to run the demo with models and input that you choose.
    
    * #### [How to modify the Default Setting](#default-setting)
## Default Setting
  The default setting of this demo is set in the **demo_info.json** file, saving as JSON format. You can change the setting by editing the **demo_info.json**.
If you have to change the default setting and not sure how to use, please raise an issue.