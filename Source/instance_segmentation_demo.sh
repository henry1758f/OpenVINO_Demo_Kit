#!/bin/bash
# File: instance_segmentation_demo.sh
# 2019/10/07	henry1758f 0.0.1	First Create

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
coco_labels_path="/opt/intel/openvino/inference_engine/demos/python_demos/instance_segmentation_demo/coco_labels.txt"

function banner_show()
{
	echo "|=========================================|"
	echo "|       Instance Segmentation Demo        |"
	echo "|=========================================|"
}


function model_0_choose()
{
	echo " [Select an Instance Segmentation Models]"
	echo " >> 1. instance-segmentation-security-0010.xml 	[FP32]  >(80 classes of objects) "
	echo " >> 2. instance-segmentation-security-0010.xml 	[FP16]  >(80 classes of objects) "
	echo " >> 3. instance-segmentation-security-0050.xml 	[FP32]  >(80 classes of objects) "
	echo " >> 4. instance-segmentation-security-0050.xml 	[FP16]  >(80 classes of objects) "
	echo " >> 5. instance-segmentation-security-0083.xml 	[FP32]  >(80 classes of objects) "
	echo " >> 6. instance-segmentation-security-0083.xml 	[FP16]  >(80 classes of objects) "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in

		"1")
			echo " instance-segmentation-security-0010.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/instance-segmentation-security-0010/FP32/instance-segmentation-security-0010.xml
		;;
		"2")
			echo " instance-segmentation-security-0010.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/instance-segmentation-security-0010/FP16/instance-segmentation-security-0010.xml
		;;
		"3")
			echo " instance-segmentation-security-0050.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/instance-segmentation-security-0050/FP32/instance-segmentation-security-0050.xml
		;;
		"4")
			echo " instance-segmentation-security-0050.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/instance-segmentation-security-0050/FP16/instance-segmentation-security-0050.xml
		;;
		"5")
			echo " instance-segmentation-security-0083.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/instance-segmentation-security-0083/FP32/instance-segmentation-security-0083.xml
		;;
		"6")
			echo " instance-segmentation-security-0083.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/instance-segmentation-security-0083/FP16/instance-segmentation-security-0083.xml

		;;
		"0")
			return 1
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_0=${choose}
			;;
	esac
}

function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function source_choose()
{
	echo " >> input the camera number to use that camera as inference source (eq. /dev/video0 then typein 0), or typein the path to the source you want."
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
	MODEL_LOC_0=${MODEL_LOC}/intel/instance-segmentation-security-0083/FP32/instance-segmentation-security-0083.xml
	test -e $USER_IMG_LOC/640px-20180402_091550_KKA-2591.jpg || wget -P $USER_IMG_LOC https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/20180402_091550_KKA-2591.jpg/640px-20180402_091550_KKA-2591.jpg
	I_SOURCE=0
	TARGET_0="CPU"
}
function set_others()
{
	inference_D_choose
	source_choose
}
clear
banner_show

set_default
model_0_choose && set_others


ARGS=" -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0} --labels ${coco_labels_path} -l ${INTEL_OPENVINO_DIR}/inference_engine/lib/intel64/libcpu_extension_avx2.so"
test -e $DEMO_LOC/python_demos/instance_segmentation_demo/instance_segmentation_demo.py || cp -r /opt/intel/openvino/inference_engine/demos/python_demos $DEMO_LOC
echo "RUN python3 $DEMO_LOC/python_demos/instance_segmentation_demo/instance_segmentation_demo.py $ARGS"
python3 $DEMO_LOC/python_demos/instance_segmentation_demo/instance_segmentation_demo.py $ARGS