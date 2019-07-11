# File: object_detection_demo_ssd_async.sh
# 2019/05/09	henry1758f 0.0.1	First Create
# 2019/05/09	henry1758f 1.0.0	Workable
# 2019/05/30	henry1758f 1.1.0	Add ssd_mobilenet_v1,ssd512 and ssd300. Support labels.
# 2019/05/30	henry1758f 1.1.1	Add mobilenet-ssd but without labels.
# 2019/07/11	henry1758f 1.1.2	Add mtcnn_o/p/r but without labels.
export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=/home/$(whoami)/openvino_models/models/SYNNEX_demo

export ssd_mobilenet_v2_coco_frozen="${MODEL_LOC}/../../ir/FP32/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29"
export ssd_mobilenet_v2_coco_frozen_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29"
export ssd_mobilenet_v1_coco_frozen="${MODEL_LOC}/../../ir/FP32/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco_2018_01_28"
export ssd_mobilenet_v1_coco_frozen_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco_2018_01_28"
export ssd_512="${MODEL_LOC}/../../ir/FP32/object_detection/common/ssd/512/caffe/models/VGGNet/VOC0712Plus/SSD_512x512"
export ssd_512_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/ssd/512/caffe/models/VGGNet/VOC0712Plus/SSD_512x512"
export ssd_300="${MODEL_LOC}/../../ir/FP32/object_detection/common/ssd/300/caffe/models/VGGNet/VOC0712Plus/SSD_300x300_ft"
export ssd_300_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/ssd/300/caffe/models/VGGNet/VOC0712Plus/SSD_300x300_ft"
export mobilenet_ssd="${MODEL_LOC}/../../ir/FP32/object_detection/common/mobilenet-ssd/caffe"
export mobilenet_ssd_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/mobilenet-ssd/caffe"
export mtcnn_o="${MODEL_LOC}/../../ir/FP32/object_detection/common/mtcnn/o/caffe"
export mtcnn_o_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/mtcnn/o/caffe"
export mtcnn_p="${MODEL_LOC}/../../ir/FP32/object_detection/common/mtcnn/p/caffe"
export mtcnn_p_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/mtcnn/p/caffe"
export mtcnn_r="${MODEL_LOC}/../../ir/FP32/object_detection/common/mtcnn/r/caffe"
export mtcnn_r_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/mtcnn/r/caffe"
export faster_rcnn_inception_v2="${MODEL_LOC}/../../ir/FP32/object_detection/common/faster_rcnn/faster_rcnn_inception_v2_coco/tf/faster_rcnn_inception_v2_coco_2018_01_28"
export faster_rcnn_inception_v2_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/faster_rcnn/faster_rcnn_inception_v2_coco/tf/faster_rcnn_inception_v2_coco_2018_01_28"
export faster_rcnn_resnet101="${MODEL_LOC}/../../ir/FP32/object_detection/common/faster_rcnn/faster_rcnn_resnet101_coco/tf/faster_rcnn_resnet101_coco_2018_01_28"
export faster_rcnn_resnet101_fp16="${MODEL_LOC}/../../ir/FP16/object_detection/common/faster_rcnn/faster_rcnn_resnet101_coco/tf/faster_rcnn_resnet101_coco_2018_01_28"


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
	test -e ${ssd_mobilenet_v2_coco_frozen}/frozen_inference_graph.xml && echo " 1. ssd_mobilenet_v2_coco.frozen.xml [FP32]" || echo " 1. ssd_mobilenet_v2_coco.frozen.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${ssd_mobilenet_v2_coco_frozen_fp16}/frozen_inference_graph.xml && echo " 2. ssd_mobilenet_v2_coco.frozen.xml [FP16]" || echo " 2. ssd_mobilenet_v2_coco.frozen.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${ssd_mobilenet_v1_coco_frozen}/frozen_inference_graph.xml && echo " 3. frozen_inference_graph.xml [ssd_mobilenet_v1_coco_FP32]" || echo " 3. frozen_inference_graph.xml [ssd_mobilenet_v1_coco_P32]	File lost! Need to Download and Transfer to IR)"
	test -e ${ssd_mobilenet_v1_coco_frozen_fp16}/frozen_inference_graph.xml && echo " 4. frozen_inference_graph.xml [ssd_mobilenet_v1_coco_FP16]" || echo " 4. frozen_inference_graph.xml [ssd_mobilenet_v1_coco_FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${mobilenet_ssd}/mobilenet-ssd.xml && echo " 5. mobilenet-ssd.xml [FP32]" || echo " 5. mobilenet-ssd.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${mobilenet_ssd_fp16}/mobilenet-ssd.xml && echo " 6. mobilenet-ssd.xml [FP16]" || echo " 6. mobilenet-ssd.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${ssd_512}/ssd512.xml && echo " 7. ssd512.xml [FP32]" || echo " 7. ssd512.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${ssd_512_fp16}/ssd512.xml && echo " 8. ssd512.xml [FP16]" || echo " 8. ssd512.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${mtcnn_o}/mtcnn-o.xml && echo " 9. mtcnn-o.xml [FP32]" || echo " 9. mtcnn-o.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${mtcnn_o_fp16}/mtcnn-o.xml && echo "10. mtcnn-o.xml [FP16]" || echo "10. mtcnn-o.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${mtcnn_p}/mtcnn-p.xml && echo "11. mtcnn-p.xml [FP32]" || echo "11. mtcnn-p.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${mtcnn_p_fp16}/mtcnn-p.xml && echo "12. mtcnn-p.xml [FP16]" || echo "12. mtcnn-p.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${mtcnn_r}/mtcnn-r.xml && echo "13. mtcnn-r.xml [FP32]" || echo "13. mtcnn-r.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${mtcnn_r_fp16}/mtcnn-r.xml && echo "14. mtcnn-r.xml [FP16]" || echo "14. mtcnn-r.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${faster_rcnn_inception_v2}/ssd300.xml && echo "15. ssd300.xml [FP32]" || echo "15. ssd300.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${faster_rcnn_inception_v2_fp16}/ssd300.xml && echo "16. ssd300.xml [FP16]" || echo "16. ssd300.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${faster_rcnn_resnet101}/ssd300.xml && echo "17. ssd300.xml [FP32]" || echo "17. ssd300.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${faster_rcnn_resnet101_fp16}/ssd300.xml && echo "18. ssd300.xml [FP16]" || echo "18. ssd300.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	echo " >>19. face-detection-adas-0001 "
	echo " >>20. face-detection-adas-0001-fp16 "
	echo " >>21. face-detection-retail-0004"
	echo " >>22. face-detection-retail-0004-fp16"
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " ssd_mobilenet_v2_coco_frozen.xml [FP32] ->"
			test -e ${ssd_mobilenet_v2_coco_frozen}/frozen_inference_graph.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd_mobilenet_v2_coco.frozen.pb -fp32 && cp -r ./Source/labels/ssd_mobilenet_v2_coco_2018_03_29/frozen_inference_graph.labels ${ssd_mobilenet_v2_coco_frozen})
			MODEL_LOC_0=${ssd_mobilenet_v2_coco_frozen}/frozen_inference_graph.xml
			inference_D_choose
		;;
		"2")
			echo " ssd_mobilenet_v2_coco.frozen.xml [FP16] ->"
			test -e ${ssd_mobilenet_v2_coco_frozen_fp16}/frozen_inference_graph.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd_mobilenet_v2_coco.frozen.pb -fp16 && cp -r ./Source/labels/ssd_mobilenet_v2_coco_2018_03_29/frozen_inference_graph.labels ${ssd_mobilenet_v2_coco_frozen_fp16})
			MODEL_LOC_0=${ssd_mobilenet_v2_coco_frozen_fp16}/frozen_inference_graph.xml
			inference_D_choose
		;;
		"3")
			echo " ssd_mobilenet_v1_coco_frozen.xml [FP32] ->"
			test -e ${ssd_mobilenet_v1_coco_frozen}/frozen_inference_graph.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd_mobilenet_v1_coco.frozen.pb -fp32 && cp -r ./Source/labels/ssd_mobilenet_v1_coco_2018_01_28/frozen_inference_graph.labels ${ssd_mobilenet_v1_coco_frozen}) 
			MODEL_LOC_0=${ssd_mobilenet_v1_coco_frozen}/frozen_inference_graph.xml
			inference_D_choose
		;;
		"4")
			echo " ssd_mobilenet_v1_coco.frozen.xml [FP16] ->"
			test -e ${ssd_mobilenet_v1_coco_frozen_fp16}/frozen_inference_graph.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd_mobilenet_v1_coco.frozen.pb -fp16 && cp -r ./Source/labels/ssd_mobilenet_v1_coco_2018_01_28/frozen_inference_graph.labels ${ssd_mobilenet_v1_coco_frozen_fp16})
			MODEL_LOC_0=${ssd_mobilenet_v1_coco_frozen_fp16}/frozen_inference_graph.xml
			inference_D_choose
		;;
		"5")
			echo " mobilenet-ssd.xml [FP32] ->"
			test -e ${mobilenet_ssd}/mobilenet-ssd.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mobilenet-ssd.caffemodel -fp32 && cp -r ./Source/labels/mobilenet-ssd/mobilenet-ssd.labels ${ssd_512}) 
			MODEL_LOC_0=${mobilenet_ssd}/mobilenet-ssd.xml
			inference_D_choose
		;;
		"6")
			echo " mobilenet-ssd.xml [FP16] ->"
			test -e ${mobilenet_ssd_fp16}/mobilenet-ssd.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mobilenet-ssd.caffemodel -fp16 && cp -r ./Source/labels/mobilenet-ssd/mobilenet-ssd.labels ${ssd_512_fp16})
			MODEL_LOC_0=${mobilenet_ssd_fp16}/mobilenet-ssd.xml
			inference_D_choose
		;;
		"7")
			echo " ssd512.xml [FP32] ->"
			test -e ${ssd_512}/ssd512.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd512.caffemodel -fp32 && cp -r ./Source/labels/ssd_512/ssd512.labels ${ssd_512}) 
			MODEL_LOC_0=${ssd_512}/ssd512.xml
			inference_D_choose
		;;
		"8")
			echo " ssd512.xml [FP16] ->"
			test -e ${ssd_512_fp16}/ssd512.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd512.caffemodel -fp16 && cp -r ./Source/labels/ssd_512/ssd512.labels ${ssd_512_fp16})
			MODEL_LOC_0=${ssd_512_fp16}/ssd512.xml
			inference_D_choose
		;;
		"9")
			echo " ssd300.xml [FP32] ->"
			test -e ${ssd_300}/ssd300.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd300.caffemodel -fp32 && cp -r ./Source/labels/ssd_300/ssd300.labels ${ssd_300}) 
			MODEL_LOC_0=${ssd_512}/ssd512.xml
			inference_D_choose
		;;
		"10")
			echo " ssd300.xml [FP16] ->"
			test -e ${ssd_300_fp16}/ssd300.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd300.caffemodel -fp16 && cp -r ./Source/labels/ssd_300/ssd300.labels ${ssd_300_fp16})
			MODEL_LOC_0=${ssd_300_fp16}/ssd300.xml
			inference_D_choose
		;;
		"11")
			echo " mtcnn-o.xml [FP32] ->"
			test -e ${mtcnn_o}/mtcnn-o.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-o.caffemodel -fp32
			MODEL_LOC_0=${mtcnn_o}/mtcnn-o.xml
			inference_D_choose
		;;
		"12")
			echo " mtcnn-o.xml [FP16] ->"
			test -e ${mtcnn_o_fp16}/mtcnn-o.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-o.caffemodel -fp16)
			MODEL_LOC_0=${mtcnn_o_fp16}/mtcnn-o.xml
			inference_D_choose
		;;
		"13")
			echo " mtcnn-p.xml [FP32] ->"
			test -e ${mtcnn_p}/mtcnn-p.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-p.caffemodel -fp32
			MODEL_LOC_0=${mtcnn_p}/mtcnn-p.xml
			inference_D_choose
		;;
		"14")
			echo " mtcnn-p.xml [FP16] ->"
			test -e ${mtcnn_p_fp16}/mtcnn-p.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-p.caffemodel -fp16)
			MODEL_LOC_0=${mtcnn_p_fp16}/mtcnn-p.xml
			inference_D_choose
		;;
		"15")
			echo " mtcnn-r.xml [FP32] ->"
			test -e ${mtcnn_r}/mtcnn-r.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-r.caffemodel -fp32
			MODEL_LOC_0=${mtcnn_r}/mtcnn-r.xml
			inference_D_choose
		;;
		"16")
			echo " mtcnn-r.xml [FP16] ->"
			test -e ${mtcnn_r_fp16}/mtcnn-r.xml || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-r.caffemodel -fp16)
			MODEL_LOC_0=${mtcnn_r_fp16}/mtcnn-r.xml
			inference_D_choose
		;;




		"19")
			echo " face-detection-adas-0001 ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"20")
			echo " face-detection-adas-0001-fp16 ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/face-detection-adas-0001-fp16.xml
			inference_D_choose
		;;
		"21")
			echo " face-detection-retail-0004 ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/sqnet1.0modif-ssd/0004/dldt/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"22")
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