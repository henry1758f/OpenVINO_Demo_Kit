#!/bin/bash
# File: interactive_face_detection_demo.sh
# 2019/05/03	henry1758f 0.0.1	First Create
# 2019/05/03	henry1758f 1.0.0	Stable and script fixed
# 2019/07/25	henry1758f 2.0.0	fit OpenVINO 2019R2 
# 2019/07/26	henry1758f 2.0.1	Improved Output information 
# 2019/10/07	henry1758f 2.1.0	Fit openVINO v2019.3.334
# 2019/10/07	henry1758f 2.1.1	Fix path error of face-detection-retail-0044

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."

function banner_show()
{
	echo "|=========================================|"
	echo "|     interactive_face_detection_demo     |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a Face Detection model.]"
	echo " >> 1. face-detection-adas-0001 	[FP32]"
	echo " >> 2. face-detection-adas-0001 	[FP16]"
	echo " >> 3. face-detection-adas-0001 	[INT8]"
	echo " >> 4. face-detection-adas-0001 	[INT1]"
	echo " >> 5. face-detection-retail-0004 	[FP32]"
	echo " >> 6. face-detection-retail-0004 	[FP16]"
	echo " >> 7. face-detection-retail-0004 	[INT8]"
	echo " >> 8. face-detection-retail-0005 	[FP32]"
	echo " >> 9. face-detection-retail-0005 	[FP16]"
	echo " >>10. face-detection-retail-0005 	[INT8]"
	echo " >>11. face-detection-retail-0044 	[FP32]"
	echo " >>12. face-detection-retail-0044 	[FP16]"
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " face-detection-adas-0001 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-0001/FP32/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"2")
			echo " face-detection-adas-0001 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-0001/FP16/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"3")
			echo " face-detection-adas-0001 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-0001/INT8/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"4")
			echo " face-detection-adas-0001 	[INT1] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-binary-0001/INT1/face-detection-adas-binary-0001.xml
			inference_D_choose
		;;
		"5")
			echo " face-detection-retail-0004 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0004/FP32/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"6")
			echo " face-detection-retail-0004 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0004/FP16/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"7")
			echo " face-detection-retail-0004 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0004/INT8/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"8")
			echo " face-detection-retail-0005 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0005/FP32/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"9")
			echo " face-detection-retail-0005 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0005/FP16/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"10")
			echo " face-detection-retail-0005 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0005/INT8/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"11")
			echo " face-detection-retail-0044.xml [FP32] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-detection-retail-0044/FP32/face-detection-retail-0044.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-detection-retail-0044 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=FP32  )
			MODEL_LOC_0=${MODEL_LOC}/../../ir/public/face-detection-retail-0044/FP32/face-detection-retail-0044.xml
		;;
		"12")
			echo " face-detection-retail-0044.xml [FP16] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-detection-retail-0044/FP16/face-detection-retail-0044.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-detection-retail-0044 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=FP16  )
			MODEL_LOC_0=${MODEL_LOC}/../../ir/public/face-detection-retail-0044/FP16/face-detection-retail-0044.xml
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
	echo "$select_inf"
	read TARGET_1
	MODEL_LOC_1="${MODEL_LOC_1} -d_ag ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Age gender recognition model.]"
	echo " >> 1. age-gender-recognition-retail-0013 	[FP32]"
	echo " >> 2. age-gender-recognition-retail-0013 	[FP16]"
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "
	local choose
	read choose
	case $choose in
		"1")
			echo " age-gender-recognition-retail-0013 	[FP32] ->"
			MODEL_LOC_1="-m_ag ${MODEL_LOC}/intel/age-gender-recognition-retail-0013/FP32/age-gender-recognition-retail-0013.xml"  
			inference_D1_choose
		;;
		"2")
			echo " age-gender-recognition-retail-0013 	[FP16] ->"
			MODEL_LOC_1="-m_ag ${MODEL_LOC}/intel/age-gender-recognition-retail-0013/FP16/age-gender-recognition-retail-0013.xml"
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
	echo "$select_inf"
	read TARGET_2
	MODEL_LOC_2="${MODEL_LOC_2} -d_hp ${TARGET_2}"
}
function model_2_choose()
{
	echo " [Select a Headpose Estimation model.]"
	echo " >> 1. head-pose-estimation-adas-0001 	[FP32] "
	echo " >> 2. head-pose-estimation-adas-0001 	[FP16] "
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " head-pose-estimation-adas-0001 	[FP32] ->"
			MODEL_LOC_2="-m_hp ${MODEL_LOC}/intel/head-pose-estimation-adas-0001/FP32/head-pose-estimation-adas-0001.xml"    
			inference_D2_choose
		;;
		"2")
			echo " head-pose-estimation-adas-0001 	[FP16] ->"
			MODEL_LOC_2="-m_hp ${MODEL_LOC}/intel/head-pose-estimation-adas-0001/FP16/head-pose-estimation-adas-0001.xml"
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
	echo "$select_inf"
	read TARGET_3
	MODEL_LOC_3="${MODEL_LOC_3} -d_em ${TARGET_3}"
}
function model_3_choose()
{
	echo " [Select a Emotions recognition model.]"
	echo " >> 1. emotions-recognition-retail-0003 	[FP32] "
	echo " >> 2. emotions-recognition-retail-0003 	[FP16] "
	echo " >> 3. emotions-recognition-retail-0003 	[INT8] "
	echo " >> 4. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " emotions-recognition-retail-0003 	[FP32] ->"
			MODEL_LOC_3="-m_em ${MODEL_LOC}/intel/emotions-recognition-retail-0003/FP32/emotions-recognition-retail-0003.xml"
			inference_D3_choose
		;;
		"2")
			echo " emotions-recognition-retail-0003 	[FP16] ->"
			MODEL_LOC_3="-m_em ${MODEL_LOC}/intel/emotions-recognition-retail-0003/FP16/emotions-recognition-retail-0003.xml"
			inference_D3_choose
		;;
		"3")
			echo " emotions-recognition-retail-0003 	[INT8] ->"
			MODEL_LOC_3="-m_em ${MODEL_LOC}/intel/emotions-recognition-retail-0003/INT8/emotions-recognition-retail-0003.xml"
			inference_D3_choose
		;;
		"4")
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
	echo "$select_inf"
	read TARGET_4
	MODEL_LOC_4="${MODEL_LOC_4} -d_lm ${TARGET_4}"
}
function model_4_choose()
{
	echo " [Select a Facial Landmarks model.]"
	echo " >> 1. facial-landmarks-35-adas-0002 	[FP32]"
	echo " >> 2. facial-landmarks-35-adas-0002 	[FP16]"
	echo " >> 3. input a path to your model "
	echo " >> Or press ENTER to ignore it. "

	local choose
	read choose
	case $choose in
		"1")
			echo " facial-landmarks-35-adas-0002 	[FP32] ->"
			MODEL_LOC_4="-m_lm ${MODEL_LOC}/intel/facial-landmarks-35-adas-0002/FP32/facial-landmarks-35-adas-0002.xml" 
			inference_D4_choose
		;;
		"2")
			echo " facial-landmarks-35-adas-0002 	[FP16] ->"
			MODEL_LOC_4="-m_lm ${MODEL_LOC}/intel/facial-landmarks-35-adas-0002/FP16/facial-landmarks-35-adas-0002.xml"
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
	MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-0001/FP32/face-detection-adas-0001.xml
	MODEL_LOC_1="-m_ag ${MODEL_LOC}/intel/age-gender-recognition-retail-0013/FP32/age-gender-recognition-retail-0013.xml"
	MODEL_LOC_2="-m_hp ${MODEL_LOC}/intel/head-pose-estimation-adas-0001/FP32/head-pose-estimation-adas-0001.xml"
	MODEL_LOC_3="-m_em ${MODEL_LOC}/intel/emotions-recognition-retail-0003/FP32/emotions-recognition-retail-0003.xml"
	MODEL_LOC_4="-m_lm ${MODEL_LOC}/intel/facial-landmarks-35-adas-0002/FP32/facial-landmarks-35-adas-0002.xml"
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
cd $DEMO_LOC
ARGS=" -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2} ${MODEL_LOC_3} ${MODEL_LOC_4} -async"
echo "RUN ./interactive_face_detection_demo $ARGS"
./interactive_face_detection_demo $ARGS
