#!/bin/bash
# File: security_barrier_camera_demo.sh
# 2019/04/22	henry1758f 0.0.1	First Create
# 2019/05/03	henry1758f 1.0.0	license-plate-recognition and turn model1 and 2 to options
# 2019/05/03	henry1758f 1.0.1	Script Fixed
# 2019/05/03	henry1758f 1.0.2	Script Fixed

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=/home/$(whoami)/openvino_models/models/SYNNEX_demo

function banner_show()
{
	echo "|=========================================|"
	echo "|        security_barrier_camera_demo     |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a vehicle and license detection model.]"
	echo " >> 1. vehicle-license-plate-detection-barrier-0106 "
	echo " >> 2. vehicle-license-plate-detection-barrier-0106-fp16 "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " vehicle-license-plate-detection-barrier-0106 ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/barrier/0106/dldt/vehicle-license-plate-detection-barrier-0106.xml
			inference_D_choose
		;;
		"2")
			echo " vehicle-license-plate-detection-barrier-0106-fp16 ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/barrier/0106/dldt/vehicle-license-plate-detection-barrier-0106-fp16.xml
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
	MODEL_LOC_1="${MODEL_LOC_1} -d_va ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Vehicle Attributes recognition model.]"
	echo " >> 1. vehicle-attributes-recognition-barrier-0039 "
	echo " >> 2. vehicle-attributes-recognition-barrier-0039-fp16 "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "
	local choose
	read choose
	case $choose in
		"1")
			echo " vehicle-license-plate-detection-barrier-0106 ->"
			MODEL_LOC_1="-m_va ${MODEL_LOC}/Security/object_attributes/vehicle/resnet10_update_1/dldt/vehicle-attributes-recognition-barrier-0039.xml"
			inference_D1_choose
		;;
		"2")
			echo " vehicle-license-plate-detection-barrier-0106-fp16 ->"
			MODEL_LOC_1="-m_va ${MODEL_LOC}/Security/object_attributes/vehicle/resnet10_update_1/dldt/vehicle-attributes-recognition-barrier-0039-fp16.xml"
			inference_D1_choose
		;;
		"3")
			echo " PATH to your model ->"
			MODEL_LOC_2="-m_va ${choose}"
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
	MODEL_LOC_2="${MODEL_LOC_2} -d_lpr ${TARGET_2}"
}
function model_2_choose()
{
	echo " [Select a License Plate Recognition model.]"
	echo " >> 1. license-plate-recognition-barrier-0001 "
	echo " >> 2. license-plate-recognition-barrier-0001-fp16 "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " license-plate-recognition-barrier-0001 ->"
			MODEL_LOC_2="-m_lpr ${MODEL_LOC}/Security/optical_character_recognition/license_plate/dldt/license-plate-recognition-barrier-0001.xml"
			inference_D2_choose
		;;
		"2")
			echo " license-plate-recognition-barrier-0001-fp16 ->"
			MODEL_LOC_2="-m_lpr ${MODEL_LOC}/Security/optical_character_recognition/license_plate/dldt/license-plate-recognition-barrier-0001-fp16.xml"
			inference_D2_choose
		;;
		"3")
			echo " PATH to your model ->"
			MODEL_LOC_2="-m_lpr ${choose}"
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
echo "./security_barrier_camera_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2}"
./security_barrier_camera_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2}
