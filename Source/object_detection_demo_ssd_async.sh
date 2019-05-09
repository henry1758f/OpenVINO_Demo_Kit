# File: object_detection_demo_ssd_async.sh
# 2019/05/09	henry1758f 0.0.1	First Create
# 2019/05/09	henry1758f 1.0.0	Workable

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=/home/$(whoami)/openvino_models/models/SYNNEX_demo

function banner_show()
{
	echo "|=========================================|"
	echo "|   Object Detection and ASYNC API Demo   |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo " >> CPU(FP32),GPU(FP32/16),MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a Object Detection model.]"
	test -e ${MODEL_LOC}/../../ir/FP32/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco.frozen.xml && echo " 1. ssd_mobilenet_v2_coco.frozen.xml [FP32]" || echo " 1. ssd_mobilenet_v2_coco.frozen.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco.frozen.xml && echo " 2. ssd_mobilenet_v2_coco.frozen.xml [FP16]" || echo " 2. ssd_mobilenet_v2_coco.frozen.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco.frozen.xml && echo " 3. ssd_mobilenet_v1_coco.frozen.xml [FP32]" || echo " 3. ssd_mobilenet_v1_coco.frozen.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco.frozen.xml && echo " 4. ssd_mobilenet_v1_coco.frozen.xml [FP16]" || echo " 4. ssd_mobilenet_v1_coco.frozen.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/object_detection/common/mobilenet_ssd/caffe/mobilenet-ssd.xml && echo " 5. mobilenet-ssd.xml [FP32]" || echo " 5. mobilenet-ssd.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/object_detection/common/mobilenet_ssd/caffe/mobilenet-ssd.xml && echo " 6. mobilenet-ssd.xml [FP16]" || echo " 6. mobilenet-ssd.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/object_detection/common/ssd/512/caffe/ssd512.xml && echo " 7. ssd512.xml [FP32]" || echo " 7. ssd512.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/object_detection/common/ssd/512/caffe/ssd512.xml && echo " 8. ssd512.xml [FP16]" || echo " 8. ssd512.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/object_detection/common/ssd/300/caffe/ssd300.xml && echo " 9. ssd300.xml [FP32]" || echo " 9. ssd300.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/object_detection/common/ssd/300/caffe/ssd300.xml && echo "10. ssd300.xml [FP16]" || echo "10. ssd300.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	echo " >>11. face-detection-adas-0001 "
	echo " >>12. face-detection-adas-0001-fp16 "
	echo " >>13. face-detection-retail-0004"
	echo " >>14. face-detection-retail-0004-fp16"
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"11")
			echo " face-detection-adas-0001 ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"12")
			echo " face-detection-adas-0001-fp16 ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/face-detection-adas-0001-fp16.xml
			inference_D_choose
		;;
		"13")
			echo " face-detection-retail-0004 ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/sqnet1.0modif-ssd/0004/dldt/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"14")
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

clear
banner_show
model_0_choose
source_choose
cd $SAMPLE_LOC
echo "./object_detection_demo_ssd_async -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0}"
./object_detection_demo_ssd_async -m ${MODEL_LOC_0} -i ${I_SOURCE} -d ${TARGET_0}