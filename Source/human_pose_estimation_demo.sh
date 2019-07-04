# File: human_pose_estimation_demo.sh
# 2019/04/22	henry1758f 0.0.1	First Create
# 2019/04/30	henry1758f 1.0.0	Stable
# 2019/07/04	henry1758f 1.1.0	Add default trick

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=/home/$(whoami)/openvino_models/models/SYNNEX_demo


function banner_show()
{
	echo "|=========================================|"
	echo "|        Human Pose Estimation Demo       |"
	echo "|=========================================|"
}

function model_0_choose()
{
	echo " >> 1. human-pose-estimation-0001 "
	echo " >> 2. human-pose-estimation-0001-fp16 "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " human-pose-estimation-0001 ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/human_pose_estimation/mobilenet-v1/dldt/human-pose-estimation-0001.xml
		;;
		"2")
			echo " human-pose-estimation-0001-fp16 ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/human_pose_estimation/mobilenet-v1/dldt/human-pose-estimation-0001-fp16.xml
		;;
		"0")
			return 1
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC=${choose}
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
}
function set_default()
{
	echo " All model will run on CPU... "
	MODEL_LOC="${MODEL_LOC}/Transportation/human_pose_estimation/mobilenet-v1/dldt/human-pose-estimation-0001.xml"
	I_SOURCE="cam"
	TARGET_0="CPU"
}
function set_others()
{
	inference_D_choose
	source_choose
}
clear
banner_show

echo "Select Human Pose Estimation model >>>"
model_0_choose && set_others || set_default

cd $SAMPLE_LOC
./human_pose_estimation_demo -m ${MODEL_LOC} -i ${I_SOURCE} -d ${TARGET_0}