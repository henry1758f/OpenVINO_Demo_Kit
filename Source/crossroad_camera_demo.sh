#!/bin/bash
# File: crossroad_camera_demo.sh
# 2019/05/03	henry1758f 0.0.1	First Create
# 2019/07/18	henry1758f 1.0.0	Add some model options for Person Reidentification model and quick demo trick.\
# 2019/07/26	henry1758f 2.0.0	Fit openVINO v2019.2.242

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo

function banner_show()
{
	echo "|=========================================|"
	echo "|           crossroad_camera_demo         |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a Person,Vehicle and Bike detection model.]"
	echo " >> 1. person-vehicle-bike-detection-crossroad-0078.xml 	[FP32] "
	echo " >> 2. person-vehicle-bike-detection-crossroad-0078.xml 	[FP32] "
	echo " >> 3. person-vehicle-bike-detection-crossroad-0078.xml 	[INT8] "
	echo " >> 4. person-vehicle-bike-detection-crossroad-1016.xml 	[FP32] "
	echo " >> 5. person-vehicle-bike-detection-crossroad-1016.xml 	[FP16] "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " person-vehicle-bike-detection-crossroad-0078.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/FP32/person-vehicle-bike-detection-crossroad-0078.xml
			inference_D_choose
		;;
		"2")
			echo " person-vehicle-bike-detection-crossroad-0078.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/FP16/person-vehicle-bike-detection-crossroad-0078.xml
			inference_D_choose
		;;
		"3")
			echo " person-vehicle-bike-detection-crossroad-0078.xml 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/INT8/person-vehicle-bike-detection-crossroad-0078.xml
			inference_D_choose
		;;
		"4")
			echo " person-vehicle-bike-detection-crossroad-1016.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/ecurity/object_detection/crossroad/1016/dldt/FP32/person-vehicle-bike-detection-crossroad-1016.xml
			inference_D_choose
		;;
		"5")
			echo " person-vehicle-bike-detection-crossroad-1016.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/ecurity/object_detection/crossroad/1016/dldt/FP32/person-vehicle-bike-detection-crossroad-1016.xml
			inference_D_choose
		;;
		"0")
			return 1
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_0=${choose}
			inference_D_choose
			;;
	esac
}

function source_choose()
{
	echo " >> input \"cam\" for using camera as inference source,\"0\" for default Source, or typein the path to the source you want."
	read I_SOURCE
	case $I_SOURCE in
		"0")
			echo "Model PATH [Default]= /opt/intel/openvino/deployment_tools/demo/car_1.bmp"
			I_SOURCE=/opt/intel/openvino/deployment_tools/demo/car_1.bmp
		;;
		*)
			echo " Model PATH=${I_SOURCE}"
			;;
	esac
}

function inference_D1_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_1
	MODEL_LOC_1="${MODEL_LOC_1} -d_pa ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Person Attributes recognition model.]"
	echo " >> 1. person-attributes-recognition-crossroad-0230 "
	echo " >> 2. person-attributes-recognition-crossroad-0230-fp16 "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "
	local choose
	read choose
	case $choose in
		"1")
			echo " person-attributes-recognition-crossroad-0230.xml 	[FP32] ->"
			MODEL_LOC_1="-m_pa ${MODEL_LOC}/Security/object_attributes/pedestrian/person-attributes-recognition-crossroad-0230/dldt/FP32/person-attributes-recognition-crossroad-0230.xml"
			inference_D1_choose
		;;
		"2")
			echo " person-attributes-recognition-crossroad-0230.xml 	[FP16] ->"
			MODEL_LOC_1="-m_pa ${MODEL_LOC}/Security/object_attributes/pedestrian/person-attributes-recognition-crossroad-0230/dldt/FP16/person-attributes-recognition-crossroad-0230.xml"
			inference_D1_choose
		;;
		"3")
			echo " PATH to your model ->"
			MODEL_LOC_2="-m_pa ${choose}"
			inference_D1_choose
		;;
		*)
			echo " [Ignore.]"
		;;
	esac
}

function inference_D2_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_2
	MODEL_LOC_2="${MODEL_LOC_2} -d_reid ${TARGET_2}"
}
function model_2_choose()
{
	echo " [Select a Person Reidentification model.]"
	echo " >> 1. person-reidentification-retail-0031.xml 	[FP32] "
	echo " >> 2. person-reidentification-retail-0031.xml 	[FP16] "
	echo " >> 3. person-reidentification-retail-0031.xml 	[INT8] "
	echo " >> 4. person-reidentification-retail-0076.xml 	[FP32] "
	echo " >> 5. person-reidentification-retail-0076.xml 	[FP16] "
	echo " >> 6. person-reidentification-retail-0076.xml 	[INT8] "
	echo " >> 7. person-reidentification-retail-0079.xml 	[FP32] "
	echo " >> 8. person-reidentification-retail-0079.xml 	[FP16] "
	echo " >> 9. person-reidentification-retail-0079.xml 	[INT8] "
	echo " >>10. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " person-reidentification-retail-0031.xml 	[FP32] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0031/dldt/FP32/person-reidentification-retail-0031.xml"
			inference_D2_choose
		;;
		"2")
			echo " person-reidentification-retail-0031.xml 	[FP16] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0031/dldt/FP16/person-reidentification-retail-0031.xml"
			inference_D2_choose
		;;
		"3")
			echo " person-reidentification-retail-0031.xml 	[INT8] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0031/dldt/INT8/person-reidentification-retail-0031.xml"
			inference_D2_choose
		;;
		"4")
			echo " person-reidentification-retail-0076.xml 	[FP32] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0076/dldt/FP32/person-reidentification-retail-0076.xml"
			inference_D2_choose
		;;
		"5")
			echo " person-reidentification-retail-0076.xml 	[FP16] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0076/dldt/FP16/person-reidentification-retail-0076.xml"
			inference_D2_choose
		;;
		"6")
			echo " person-reidentification-retail-0076.xml 	[INT8] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0076/dldt/INT8/person-reidentification-retail-0076.xml"
			inference_D2_choose
		;;
		"7")
			echo " person-reidentification-retail-0079.xml 	[FP32] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/FP32/person-reidentification-retail-0079.xml"
			inference_D2_choose
		;;
		"8")
			echo " person-reidentification-retail-0079.xml 	[FP16] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/FP16/person-reidentification-retail-0079.xml"
			inference_D2_choose
		;;
		"9")
			echo " person-reidentification-retail-0079.xml 	[INT8] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/INT8/person-reidentification-retail-0079.xml"
			inference_D2_choose
		;;
		"10")
			echo " PATH to your model ->"
			MODEL_LOC_2="-m_reid ${choose}"
			inference_D2_choose
		;;
		*)
			echo " [Ignore.]"
		;;
	esac
}
function set_default()
{
	echo " All model will run on CPU... "
	MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/FP16/person-vehicle-bike-detection-crossroad-0078.xml
	MODEL_LOC_1="-m_pa ${MODEL_LOC}/Security/object_attributes/pedestrian/person-attributes-recognition-crossroad-0230/dldt/FP16/person-attributes-recognition-crossroad-0230.xml"
	MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/FP16/person-reidentification-retail-0079.xml"
	I_SOURCE="cam"
	TARGET_0="CPU"
	TARGET_1="CPU"
	TARGET_2="CPU"
}
function set_others()
{
	inference_D_choose
	model_1_choose
	model_2_choose
	source_choose
}
clear
banner_show
model_0_choose && set_others || set_default

cd $DEMO_LOC
ARGS=" -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2}"
echo "./crossroad_camera_demo $ARGS"
./crossroad_camera_demo $ARGS
