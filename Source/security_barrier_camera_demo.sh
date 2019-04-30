#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh
# 2019/04/22	henry1758f 0.0.1	First Create
# 2019/04/30	henry1758f 0.1.0	vehicle detection and attribute recognition

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=/home/$(whoami)/openvino_models/models/SYNNEX_demo

function banner_show()
{
	echo "|=========================================|"
	echo "|        security_barrier_camera_demo     |"
	echo "|=========================================|"
}
function model_0_choose()
{
	echo " >> 1. vehicle-license-plate-detection-barrier-0106 "
	echo " >> 2. vehicle-license-plate-detection-barrier-0106-fp16 "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " vehicle-license-plate-detection-barrier-0106 ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/barrier/0106/dldt/vehicle-license-plate-detection-barrier-0106.xml
		;;
		"2")
			echo " vehicle-license-plate-detection-barrier-0106-fp16 ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/barrier/0106/dldt/vehicle-license-plate-detection-barrier-0106-fp16.xml
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_0=${choose}
			;;
	esac
}

function inference_D_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_0
}
function source_choose()
{
	echo " >> input \"cam\" for using camera as inference source, or typein the path to the source you want."
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


function model_1_choose()
{
	echo " >> 1. vehicle-license-plate-detection-barrier-0106 "
	echo " >> 2. vehicle-license-plate-detection-barrier-0106-fp16 "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " vehicle-license-plate-detection-barrier-0106 ->"
			MODEL_LOC_1="-m_va ${MODEL_LOC}/Security/object_attributes/vehicle/resnet10_update_1/dldt/vehicle-attributes-recognition-barrier-0039.xml"
		;;
		"2")
			echo " vehicle-license-plate-detection-barrier-0106-fp16 ->"
			MODEL_LOC_1="-m_va ${MODEL_LOC}/Security/object_attributes/vehicle/resnet10_update_1/dldt/vehicle-attributes-recognition-barrier-0039-fp16.xml"
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_1="-m_va ${choose}"
			;;
	esac
}

function inference_D1_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_1
	MODEL_LOC_1="${MODEL_LOC_1} -d_va ${TARGET_1}"
}


clear
banner_show

echo "Select Human Pose Estimation model >>>"
model_0_choose
inference_D_choose
model_1_choose
inference_D1_choose
source_choose
cd $SAMPLE_LOC
echo "./security_barrier_camera_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1}"
./security_barrier_camera_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1}
