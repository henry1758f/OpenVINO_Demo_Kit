# OpenVINO Demo Kit
This is a tool that can make you run intel openVINO Demos and samples easily. It helps you to install openVINO, build demos, download/convert models,run DLWorkbench automatically. No need to run those demos/samples or operations manully with long arguments and path. Also, this Demo Kits support to run benchmark app with multiple models dump the throughputs, Latency,etc. in one .csv file. It might help you to suvery your device's AI performance on different kinds of model.
* * *
# Contant
* [Getting Start](#getting_start)
* [Install OpenVINO](#install_openvino)
* [Build Samples and Demos](#build_samples_and_demos)
* [Query Devices](#query_devices)
* [Run Deep Learning Workbench](#run_deep_learning_workbench)
* [Model Downloader](#model_downloader)
* [Run Benchmark App](#run_benchmark_app)
* [Run OpenVINO Demos](#run_openvino_demos)
    * [Demo List](#demo_list)
        * []

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
In this situation, please refer to [Install OpenVINO section](#Install_OpenVINO_using_Demo_Kit).

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
## Demo List
 1. Security Barrier Camera Demo
 2. Interactive Face Detection Demo
 3. Classification Demo
 4. Object Detection Demo
 5. Human Pose Estimation Demo. (2D)
 6. Human Pose Estimation Demo. (3D)
 7. Crossroad Camera Demo
 8. Image Processing Demo
 9. Pedestrian tracker demo
10. Smart Classroom Demo
11. Image Segmentation Demo
12. Instance Segmentation Demo
13. Gaze Estimation Demo
14. Text Detection Demo
15. Text Spotting Demo
16. Action Recognition Demo
17. Multi Camera Multi Target Demo
18. Colorization Demo
19. Gesture Recognition Demo
20. Face Recognition Demo
21. Social Distance Demo
22. Whiteboard Inpainting Demo
23. MonoDepth Demo
24. Text-to-speech Demo
25. Real Time Speech Recognition Demo
26. BERT Named Entity Recognition Demo
