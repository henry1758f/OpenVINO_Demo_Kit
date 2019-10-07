#!/bin/bash
# File: text_detection_demo.sh
# 2019/10/07	henry1758f 0.0.1	First Create

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."

function banner_show()
{
	echo "|=========================================|"
	echo "|           Text Detection Demo           |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a Text Detection model.]"
	echo " >> 1. text-detection-0003.xml 		[FP32]"
	echo " >> 2. text-detection-0003.xml 		[FP16]"
	echo " >> 3. text-detection-0003.xml 		[INT8]"
	echo " >> 4. text-detection-0003.xml 		[FP32]"
	echo " >> 5. text-detection-0003.xml 		[FP16]"

	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " gaze-estimation-adas-0002.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/text-detection-0003/FP32/text-detection-0003.xml
			inference_D_choose
		;;
		"2")
			echo " gaze-estimation-adas-0002.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/text-detection-0003/FP16/text-detection-0003.xml
			inference_D_choose
		;;
		"3")
			echo " gaze-estimation-adas-0002.xml 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/text-detection-0003/INT8/text-detection-0003.xml
			inference_D_choose
		;;
		"4")
			echo " gaze-estimation-adas-0002.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/text-detection-0004/FP32/text-detection-0004.xml
			inference_D_choose
		;;
		"5")
			echo " gaze-estimation-adas-0002.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/text-detection-0004/FP16/text-detection-0004.xml
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


function inference_D1_choose()
{
	echo "$select_inf"
	read TARGET_1
	MODEL_LOC_1="${MODEL_LOC_1} -d_tr ${TARGET_1}"
}

function model_1_choose()
{
	echo " [Select a Text Detection model.]"
	echo " >> 1. text-recognition-0012.xml 		[FP32]"
	echo " >> 2. text-recognition-0012.xml 		[FP16]"

	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " text-recognition-0012.xml 	[FP32] ->"
			MODEL_LOC_1="-m_tr ${MODEL_LOC}/intel/text-recognition-0012/FP32/text-recognition-0012.xml"
			inference_D1_choose
		;;
		"2")
			echo " text-recognition-0012.xml 	[FP16] ->"
			MODEL_LOC_1="-m_tr ${MODEL_LOC}/intel/text-recognition-0012/FP32/text-recognition-0012.xml"
			inference_D1_choose
		;;
		"0")
			return 1
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_1=${choose}
			inference_D1_choose
			;;
	esac
}
function datatype_picker()
{
	echo "Input data type: \"image\" (for a single image), \"list\" (for a text file where images paths are listed), \"video\" (for a saved video), \"webcam\" (for a webcamera device). By default, it is \"image\""
	read data_type
}



function source_choose()
{
	echo " >> input \"0\" for default Source, or typein the path to the source you want."
	read I_SOURCE
	case $I_SOURCE in
		"0")
			echo "Model PATH [Default]= /dev/video0"
			I_SOURCE=/dev/video0
		;;
		*)
			echo " Model PATH=${I_SOURCE}"
			;;
	esac
}

function set_default()
{
	#echo " All model will run on CPU... "
	MODEL_LOC_0=${MODEL_LOC}/intel/text-detection-0003/FP32/text-detection-0003.xml
	MODEL_LOC_1="-m_tr ${MODEL_LOC}/intel/text-recognition-0012/FP32/text-recognition-0012.xml"
	I_SOURCE=/dev/video0
	TARGET_0="CPU"
	data_type="webcam"
}
function set_others()
{
	model_1_choose
	model_2_choose
	model_3_choose
	source_choose
	datatype_picker
}

clear
banner_show

set_default
model_0_choose && set_others

cd $DEMO_LOC
ARGS=" -m_td ${MODEL_LOC_0} -i ${I_SOURCE} -d_td ${TARGET_0} ${MODEL_LOC_1} -dt ${data_type}"
echo "RUN ./text_detection_demo $ARGS"
./text_detection_demo $ARGS