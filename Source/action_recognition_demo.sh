#!/bin/bash
# File: action_recognition_demo.sh
# 2019/10/07	henry1758f 0.0.1	First Create


export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
actions_labels_path="/opt/intel/openvino/inference_engine/demos/python_demos/action_recognition/driver_actions.txt"

function banner_show()
{
	echo "|=========================================|"
	echo "|         Action Recognition Demo         |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a encoder model.]"
	echo " >> 1. driver-action-recognition-adas-0002-encoder.xml 		[FP32]"
	echo " >> 2. driver-action-recognition-adas-0002-encoder.xml 		[FP16]"

	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " driver-action-recognition-adas-0002-encoder.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/driver-action-recognition-adas-0002-encoder/FP32/driver-action-recognition-adas-0002-encoder.xml
			inference_D_choose
		;;
		"2")
			echo " driver-action-recognition-adas-0002-encoder.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/driver-action-recognition-adas-0002-encoder/FP16/driver-action-recognition-adas-0002-encoder.xml
			inference_D_choose
		;;
		"0")
			inference_D_choose
			return 1
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_0=${choose}
			inference_D_choose
			;;
	esac
}

function model_1_choose()
{
	echo " [Select a decoder model.]"
	echo " >> 1. driver-action-recognition-adas-0002-decoder.xml 		[FP32]"
	echo " >> 2. driver-action-recognition-adas-0002-decoder.xml 		[FP16]"

	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " driver-action-recognition-adas-0002-decoder.xml 	[FP32] ->"
			MODEL_LOC_1=${MODEL_LOC}/intel/driver-action-recognition-adas-0002-decoder/FP32/driver-action-recognition-adas-0002-decoder.xml
			
		;;
		"2")
			echo " driver-action-recognition-adas-0002-decoder.xml 	[FP16] ->"
			MODEL_LOC_1=${MODEL_LOC}/intel/driver-action-recognition-adas-0002-decoder/FP16/driver-action-recognition-adas-0002-decoder.xml
			
		;;
		"0")
			return 1
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_1=${choose}
			
			;;
	esac
}


function source_choose()
{
	echo " >> input the Id of the video capturing device to open (to open default camera just pass 0), path to a video or a .txt file with a list of ids or video files (one object per line)"
	read choose
	if [ $choose == "0" ];then
		retuen 0
	else
		I_SOURCE=$choose
	fi

}
function set_default()
{
	#echo " All model will run on CPU... "
	MODEL_LOC_0=${MODEL_LOC}/intel/driver-action-recognition-adas-0002-encoder/FP32/driver-action-recognition-adas-0002-encoder.xml
	MODEL_LOC_1=${MODEL_LOC}/intel/driver-action-recognition-adas-0002-decoder/FP32/driver-action-recognition-adas-0002-decoder.xml
	I_SOURCE=0
	TARGET_0="CPU"
}
function set_others()
{
	source_choose
}
clear
banner_show

set_default
model_0_choose && set_others


ARGS=" -m_en ${MODEL_LOC_0} -m_de ${MODEL_LOC_1} -i ${I_SOURCE} -d ${TARGET_0} --labels ${actions_labels_path} "
test -e $DEMO_LOC/python_demos/action_recognition/action_recognition.py || cp -r /opt/intel/openvino/inference_engine/demos/python_demos $DEMO_LOC
echo "RUN python3 $DEMO_LOC/python_demos/action_recognition/action_recognition.py $ARGS"
python3 $DEMO_LOC/python_demos/action_recognition/action_recognition.py $ARGS
