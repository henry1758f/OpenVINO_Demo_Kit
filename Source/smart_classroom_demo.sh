# File: smart_classroom_demo.sh
# 2019/05/06	henry1758f 0.0.1	First Create
# 2019/05/08	henry1758f 0.1.0	demo can be executed but only face-detection


export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=/home/$(whoami)/openvino_models/models/SYNNEX_demo

function banner_show()
{
	echo "|=========================================|"
	echo "|           smart_classroom_demo          |"
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
	MODEL_LOC_1="${MODEL_LOC_1} -d_lm ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Person Attributes recognition model.]"
	echo " >> 1. landmarks-regression-retail-0009 "
	echo " >> 2. landmarks-regression-retail-0009-fp16 "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " landmarks-regression-retail-0009 ->"
			MODEL_LOC_1="-m_lm ${MODEL_LOC}/Retail/object_attributes/landmarks_regression/0009/dldt/landmarks-regression-retail-0009.xml"
			inference_D1_choose
		;;
		"2")
			echo " landmarks-regression-retail-0009-fp16 ->"
			MODEL_LOC_1="-m_lm ${MODEL_LOC}/Retail/object_attributes/landmarks_regression/0009/dldt/landmarks-regression-retail-0009-fp16.xml"
			inference_D1_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_1="-m_lm ${choose}"
			inference_D_choose
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
	echo " >> 1. face-reidentification-retail-0095 "
	echo " >> 2. face-reidentification-retail-0095-fp16 "
	echo " >> Or input a path to your model "

	local choose
	read choose
	case $choose in
		"1")
			echo " person-reidentification-retail-0079 ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/face/mobilenet_based/dldt/face-reidentification-retail-0095.xml"
			inference_D2_choose
		;;
		"2")
			echo " person-reidentification-retail-0079-fp16 ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/face/mobilenet_based/dldt/face-reidentification-retail-0095-fp16.xml"
			inference_D2_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_2="-m_reid ${choose}"
			inference_D_choose
			;;
	esac
}

function inference_D3_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_3
	MODEL_LOC_3="${MODEL_LOC_3} -d_act ${TARGET_3}"
}
function model_3_choose()
{
	echo " [Select a Emotions recognition model.]"
	echo " >> 1. person-detection-action-recognition-0005 "
	echo " >> 2. person-detection-action-recognition-0005-fp16 "
	echo " >> 1. person-detection-action-recognition-teacher "
	echo " >> 2. person-detection-action-recognition-teacher-fp16 "
	echo " >> Or input a path to your model "

	local choose
	read choose
	case $choose in
		"1")
			echo " emotions-recognition-retail-0003 ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0165/dldt/person-detection-action-recognition-0005.xml"
			inference_D3_choose
		;;
		"2")
			echo " emotions-recognition-retail-0003-fp16 ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0165/dldt/person-detection-action-recognition-0005-fp16.xml"
			inference_D3_choose
		;;
		"3")
			echo " emotions-recognition-retail-0003 ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/teacher/rmnet_ssd/0005_cut/dldt/person-detection-action-recognition-teacher-0002.xml"
			inference_D3_choose
		;;
		"4")
			echo " emotions-recognition-retail-0003-fp16 ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/teacher/rmnet_ssd/0005_cut/dldt/person-detection-action-recognition-teacher-0002-fp16.xml"
			inference_D3_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_3="-m_act ${choose}"
			inference_D_choose
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
echo "./smart_classroom_demo -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2} ${MODEL_LOC_3}"
./smart_classroom_demo -m_fd ${MODEL_LOC_0} -i ${I_SOURCE} -d_fd ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2} ${MODEL_LOC_3} #-fg 