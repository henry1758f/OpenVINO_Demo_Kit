# File: style_transfer_sample.sh
# 2019/07/26	henry1758f 0.0.1	First Create
export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."

function banner_show()
{
	echo "|=========================================|"
	echo "|          Style Transfer Sample          |"
	echo "|=========================================|"
}

function model_0_choose()
{
	echo " >> 1. human-pose-estimation-0001 	[FP32] "
	echo " >> 2. human-pose-estimation-0001 	[FP16] "
	echo " >> 3. human-pose-estimation-0001 	[INT8] "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " human-pose-estimation-0001 	[FP32] ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/human_pose_estimation/mobilenet-v1/dldt/FP32/human-pose-estimation-0001.xml
		;;
		"2")
			echo " human-pose-estimation-0001 	[FP16] ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/human_pose_estimation/mobilenet-v1/dldt/FP16/human-pose-estimation-0001.xml
		;;
		"3")
			echo " human-pose-estimation-0001 	[INT8] ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/human_pose_estimation/mobilenet-v1/dldt/INT8/human-pose-estimation-0001.xml
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
	echo " >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
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
	MODEL_LOC="${MODEL_LOC}/Transportation/human_pose_estimation/mobilenet-v1/dldt/FP16/human-pose-estimation-0001.xml"
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

cd $DEMO_LOC
ARGS=" -m ${MODEL_LOC} -i ${I_SOURCE} -d ${TARGET_0}"
echo "./style_transfer_sample $ARGS"
./style_transfer_sample $ARGS