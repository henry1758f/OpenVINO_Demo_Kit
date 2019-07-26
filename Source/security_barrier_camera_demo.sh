#!/bin/bash
# File: security_barrier_camera_demo.sh
# 2019/04/22	henry1758f 0.0.1	First Create
# 2019/05/03	henry1758f 1.0.0	license-plate-recognition and turn model1 and 2 to options
# 2019/07/25	henry1758f 2.0.0	Fit openVINO v2019.2.242
# 2019/07/26	henry1758f 2.0.1	Improved Output information 

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."

function banner_show()
{
	echo "|=========================================|"
	echo "|        security_barrier_camera_demo     |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a vehicle and license detection model.]"
	echo " >> 1. vehicle-license-plate-detection-barrier-0106	[FP32] "
	echo " >> 2. vehicle-license-plate-detection-barrier-0106	[FP16] "
	echo " >> 3. vehicle-license-plate-detection-barrier-0106	[INT8] "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " vehicle-license-plate-detection-barrier-0106 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/barrier/0106/dldt/FP32/vehicle-license-plate-detection-barrier-0106.xml
			inference_D_choose
		;;
		"2")
			echo " vehicle-license-plate-detection-barrier-0106-fp16 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/barrier/0106/dldt/FP16/vehicle-license-plate-detection-barrier-0106.xml
			inference_D_choose
		;;
		"3")
			echo " vehicle-license-plate-detection-barrier-0106 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/barrier/0106/dldt/INT8/vehicle-license-plate-detection-barrier-0106.xml
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
	echo " >> input \"cam\" for using camera as inference source,\"0\" for default Source, or typein the path to the source you want. Support multiple source by \"<source1> <source2> <source3>...\""
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
	echo "$select_inf"
	read TARGET_1
	MODEL_LOC_1="${MODEL_LOC_1} -d_va ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Vehicle Attributes recognition model.]"
	echo " >> 1. vehicle-attributes-recognition-barrier-0039 	[FP32]"
	echo " >> 2. vehicle-attributes-recognition-barrier-0039 	[FP16]"
	echo " >> 3. vehicle-attributes-recognition-barrier-0039 	[INT8]"
	echo " >> 4. input a path to your model "
	echo " >> Or press ENTER to ignore it. "
	local choose
	read choose
	case $choose in
		"1")
			echo " vehicle-license-plate-detection-barrier-0106 	[FP32] ->"
			MODEL_LOC_1="-m_va ${MODEL_LOC}/Security/object_attributes/vehicle/resnet10_update_1/dldt/FP32/vehicle-attributes-recognition-barrier-0039.xml"
			inference_D1_choose
		;;
		"2")
			echo " vehicle-license-plate-detection-barrier-0106 	[FP16] ->"
			MODEL_LOC_1="-m_va ${MODEL_LOC}/Security/object_attributes/vehicle/resnet10_update_1/dldt/FP16/vehicle-attributes-recognition-barrier-0039.xml"
			inference_D1_choose
		;;
		"3")
			echo " vehicle-license-plate-detection-barrier-0106 	[INT8] ->"
			MODEL_LOC_1="-m_va ${MODEL_LOC}/Security/object_attributes/vehicle/resnet10_update_1/dldt/INT8/vehicle-attributes-recognition-barrier-0039.xml"
			inference_D1_choose
		;;
		"4")
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
	echo "$select_inf"
	read TARGET_2
	MODEL_LOC_2="${MODEL_LOC_2} -d_lpr ${TARGET_2}"
}
function model_2_choose()
{
	echo " [Select a License Plate Recognition model.]"
	echo " >> 1. license-plate-recognition-barrier-0001 	[FP32]"
	echo " >> 2. license-plate-recognition-barrier-0001 	[FP16]"
	echo " >> 3. license-plate-recognition-barrier-0001 	[INT8]"
	echo " >> 4. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " license-plate-recognition-barrier-0001 	[FP32] ->"
			MODEL_LOC_2="-m_lpr ${MODEL_LOC}/Security/optical_character_recognition/license_plate/dldt/FP32/license-plate-recognition-barrier-0001.xml"
			inference_D2_choose
		;;
		"2")
			echo " license-plate-recognition-barrier-0001 	[FP16] ->"
			MODEL_LOC_2="-m_lpr ${MODEL_LOC}/Security/optical_character_recognition/license_plate/dldt/FP16/license-plate-recognition-barrier-0001.xml"
			inference_D2_choose
		;;
		"3")
			echo " license-plate-recognition-barrier-0001 	[INT8] ->"
			MODEL_LOC_2="-m_lpr ${MODEL_LOC}/Security/optical_character_recognition/license_plate/dldt/INT8/license-plate-recognition-barrier-0001.xml"
			inference_D2_choose
		;;
		"4")
			echo " PATH to your model ->"
			MODEL_LOC_2="-m_lpr ${choose}"
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
	MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/barrier/0106/dldt/FP32/vehicle-license-plate-detection-barrier-0106.xml
	MODEL_LOC_1="-m_va ${MODEL_LOC}/Security/object_attributes/vehicle/resnet10_update_1/dldt/FP32/vehicle-attributes-recognition-barrier-0039.xml"
	MODEL_LOC_2="-m_lpr ${MODEL_LOC}/Security/optical_character_recognition/license_plate/dldt/FP32/license-plate-recognition-barrier-0001.xml"
	I_SOURCE="/opt/intel/openvino/deployment_tools/demo/car_1.bmp"
	TARGET_0="CPU"
}
function set_others()
{
	model_1_choose
	model_2_choose
	source_choose
}
clear
banner_show
model_0_choose && set_others || set_default

cd $DEMO_LOC
ARGS=" -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2} -r "
echo "RUN ./security_barrier_camera_demo $ARGS "
./security_barrier_camera_demo $ARGS
