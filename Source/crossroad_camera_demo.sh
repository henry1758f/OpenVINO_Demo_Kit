#!/bin/bash
# File: crossroad_camera_demo.sh
# 2019/05/03	henry1758f 0.0.1	First Create
# 2019/07/11	henry1758f 0.0.2	Fix Github Issue #14
# 2019/07/15	henry1758f 0.0.3	Bug Fixed
export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
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
	echo " >> 1. person-vehicle-bike-detection-crossroad-0078 "
	echo " >> 2. person-vehicle-bike-detection-crossroad-0078-fp16 "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " person-vehicle-bike-detection-crossroad-0078 ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/person-vehicle-bike-detection-crossroad-0078.xml
			inference_D_choose
		;;
		"2")
			echo " person-vehicle-bike-detection-crossroad-0078-fp16 ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/person-vehicle-bike-detection-crossroad-0078-fp16.xml
			inference_D_choose
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
			echo " person-attributes-recognition-crossroad-0230 ->"
			MODEL_LOC_1="-m_pa ${MODEL_LOC}/Security/object_attributes/pedestrian/person-attributes-recognition-crossroad-0230/dldt/person-attributes-recognition-crossroad-0230.xml"
			inference_D1_choose
		;;
		"2")
			echo " person-attributes-recognition-crossroad-0230-fp16 ->"
			MODEL_LOC_1="-m_pa ${MODEL_LOC}/Security/object_attributes/pedestrian/person-attributes-recognition-crossroad-0230/dldt/person-attributes-recognition-crossroad-0230-fp16.xml"
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
	echo " >> 1. person-reidentification-retail-0079 "
	echo " >> 2. person-reidentification-retail-0079-fp16 "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " person-reidentification-retail-0079 ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/person-reidentification-retail-0079.xml"
			inference_D2_choose
		;;
		"2")
			echo " person-reidentification-retail-0079-fp16 ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/person-reidentification-retail-0079-fp16.xml"
			inference_D2_choose
		;;
		"3")
			echo " PATH to your model ->"
			MODEL_LOC_2="-m_reid ${choose}"
			inference_D2_choose
		;;
		*)
			echo " [Ignore.]"
		;;
	esac
}

clear
banner_show
model_0_choose
model_1_choose
model_2_choose
source_choose
cd $SAMPLE_LOC
echo "./crossroad_camera_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2}"
./crossroad_camera_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2}
