#!/bin/bash
# File: interactive_face_detection_demo.sh
# 2019/05/03	henry1758f 0.0.1	First Create
# 2019/05/03	henry1758f 1.0.0	Stable and script fixed
# 2019/07/04	henry1758f 1.1.0	Add default trick
# 2019/07/11	henry1758f 1.1.1	Fix Github Issue #14

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$(HOME)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=$(HOME)/openvino_models/models/SYNNEX_demo

function banner_show()
{
	echo "|=========================================|"
	echo "|     interactive_face_detection_demo     |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a Face Detection model.]"
	echo " >> 1. face-detection-adas-0001 "
	echo " >> 2. face-detection-adas-0001-fp16 "
	echo " >> 3. face-detection-retail-0004"
	echo " >> 4. face-detection-retail-0004-fp16"
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " face-detection-adas-0001 ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"2")
			echo " face-detection-adas-0001-fp16 ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/face-detection-adas-0001-fp16.xml
			inference_D_choose
		;;
		"3")
			echo " face-detection-retail-0004 ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/sqnet1.0modif-ssd/0004/dldt/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"4")
			echo " face-detection-retail-0004-fp16 ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/sqnet1.0modif-ssd/0004/dldt/face-detection-retail-0004-fp16.xml
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
			echo "Model PATH [Default]= cam"
			I_SOURCE=cam
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
	MODEL_LOC_1="${MODEL_LOC_1} -d_ag ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Age gender recognition model.]"
	echo " >> 1. age-gender-recognition-retail-0013 "
	echo " >> 2. age-gender-recognition-retail-0013-fp16 "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "
	local choose
	read choose
	case $choose in
		"1")
			echo " age-gender-recognition-retail-0013 ->"
			MODEL_LOC_1="-m_ag ${MODEL_LOC}/Retail/object_attributes/age_gender/dldt/age-gender-recognition-retail-0013.xml"
			inference_D1_choose
		;;
		"2")
			echo " age-gender-recognition-retail-0013-fp16 ->"
			MODEL_LOC_1="-m_ag ${MODEL_LOC}/Retail/object_attributes/age_gender/dldt/age-gender-recognition-retail-0013-fp16.xml"
			inference_D1_choose
		;;
		"3")
			echo " PATH to your model ->"
			MODEL_LOC_1="-m_ag ${choose}"
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
	MODEL_LOC_2="${MODEL_LOC_2} -d_hp ${TARGET_2}"
}
function model_2_choose()
{
	echo " [Select a Headpose Estimation model.]"
	echo " >> 1. head-pose-estimation-adas-0001 "
	echo " >> 2. head-pose-estimation-adas-0001-fp16 "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " head-pose-estimation-adas-0001 ->"
			MODEL_LOC_2="-m_hp ${MODEL_LOC}/Transportation/object_attributes/headpose/vanilla_cnn/dldt/head-pose-estimation-adas-0001.xml"
			inference_D2_choose
		;;
		"2")
			echo " head-pose-estimation-adas-0001-fp16 ->"
			MODEL_LOC_2="-m_hp ${MODEL_LOC}/Transportation/object_attributes/headpose/vanilla_cnn/dldt/head-pose-estimation-adas-0001-fp16.xml"
			inference_D2_choose
		;;
		"3")
			echo " PATH to your model ->"
			MODEL_LOC_2="-m_hp ${choose}"
			inference_D2_choose
		;;
		*)
			echo " [Ignore.]"
		;;
	esac
}

function inference_D3_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_3
	MODEL_LOC_3="${MODEL_LOC_3} -d_em ${TARGET_3}"
}
function model_3_choose()
{
	echo " [Select a Emotions recognition model.]"
	echo " >> 1. emotions-recognition-retail-0003 "
	echo " >> 2. emotions-recognition-retail-0003-fp16 "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " emotions-recognition-retail-0003 ->"
			MODEL_LOC_3="-m_em ${MODEL_LOC}/Retail/object_attributes/emotions_recognition/0003/dldt/emotions-recognition-retail-0003.xml"
			inference_D3_choose
		;;
		"2")
			echo " emotions-recognition-retail-0003-fp16 ->"
			MODEL_LOC_3="-m_em ${MODEL_LOC}/Retail/object_attributes/emotions_recognition/0003/dldt/emotions-recognition-retail-0003-fp16.xml"
			inference_D3_choose
		;;
		"3")
			echo " PATH to your model ->"
			MODEL_LOC_3="-m_em ${choose}"
			inference_D3_choose
		;;
		*)
			echo " [Ignore.]"
		;;
	esac
}

function inference_D4_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_4
	MODEL_LOC_4="${MODEL_LOC_4} -d_lm ${TARGET_4}"
}
function model_4_choose()
{
	echo " [Select a Facial Landmarks model.]"
	echo " >> 1. facial-landmarks-35-adas-0002 "
	echo " >> 2. facial-landmarks-35-adas-0002-fp16 "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " facial-landmarks-35-adas-0002 ->"
			MODEL_LOC_4="-m_lm ${MODEL_LOC}/Transportation/object_attributes/facial_landmarks/custom-35-facial-landmarks/dldt/facial-landmarks-35-adas-0002.xml"
			inference_D4_choose
		;;
		"2")
			echo " facial-landmarks-35-adas-0002-fp16 ->"
			MODEL_LOC_4="-m_lm ${MODEL_LOC}/Transportation/object_attributes/facial_landmarks/custom-35-facial-landmarks/dldt/facial-landmarks-35-adas-0002-fp16.xml"
			inference_D4_choose
		;;
		"3")
			echo " PATH to your model ->"
			MODEL_LOC_4="-m_lm ${choose}"
			inference_D4_choose
		;;
		*)
			echo " [Ignore.]"
		;;
	esac
}

function set_default()
{
	echo " All model will run on CPU... "
	MODEL_LOC_0="${MODEL_LOC}/Retail/object_detection/face/sqnet1.0modif-ssd/0004/dldt/face-detection-retail-0004.xml"
	MODEL_LOC_1="-m_ag ${MODEL_LOC}/Retail/object_attributes/age_gender/dldt/age-gender-recognition-retail-0013.xml"
	MODEL_LOC_2="-m_hp ${MODEL_LOC}/Transportation/object_attributes/headpose/vanilla_cnn/dldt/head-pose-estimation-adas-0001.xml"
	MODEL_LOC_3="-m_em ${MODEL_LOC}/Retail/object_attributes/emotions_recognition/0003/dldt/emotions-recognition-retail-0003.xml"
	MODEL_LOC_4="-m_lm ${MODEL_LOC}/Transportation/object_attributes/facial_landmarks/custom-35-facial-landmarks/dldt/facial-landmarks-35-adas-0002.xml"
	I_SOURCE="cam"
	TARGET_0="CPU"
}
function set_others()
{
	model_1_choose
	model_2_choose
	model_3_choose
	model_4_choose
}

clear
banner_show
 
model_0_choose && set_others || set_default

source_choose
cd $SAMPLE_LOC
echo "./interactive_face_detection_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2} ${MODEL_LOC_3} ${MODEL_LOC_4}"
./interactive_face_detection_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2} ${MODEL_LOC_3} ${MODEL_LOC_4}
