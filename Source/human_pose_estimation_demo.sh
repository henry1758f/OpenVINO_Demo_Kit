# File: OpenVINO_demo_SYNNEX.sh
# 2019/04/22	henry1758f 0.0.1	First Create
# 2019/04/30	henry1758f 1.0.0	Stable

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

clear
banner_show

echo "Select Human Pose Estimation model >>>"
model_0_choose
inference_D_choose
source_choose
cd $SAMPLE_LOC
./human_pose_estimation_demo -m ${MODEL_LOC} -i ${I_SOURCE} -d ${TARGET_0}