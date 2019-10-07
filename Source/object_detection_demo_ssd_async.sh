# File: object_detection_demo_ssd_async.sh
# 2019/05/09	henry1758f 0.0.1	First Create
# 2019/05/09	henry1758f 1.0.0	Workable
# 2019/07/26	henry1758f 2.0.0	Fit openVINO v2019.2.242
# 2019/07/26	henry1758f 2.0.1	Improved Output information
# 2019/10/05	henry1758f 2.1.0	object_detection_demo_ssd_async fit OpenVINO 2019R3
# 2019/10/07	henry1758f 2.1.1	optimize the script

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo

select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
label_path="$HOME/SYNNEX_work/Source/labels"
converter_path="${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/converter.py"

function banner_show()
{
	echo "|=========================================|"
	echo "|   Object Detection and ASYNC API Demo   |"
	echo "|=========================================|"
}

function model_list()
{
	echo " 1. face-detection-retail-0044"
	echo " 2. faster_rcnn_inception_resnet_v2_atrous_coco"
	echo " 3. faster_rcnn_inception_v2_coco"
	echo " 4. faster_rcnn_resnet101_coco"
	echo " 5. faster_rcnn_resnet50_coco"
	echo " 6. mobilenet-ssd"
	echo " 7. ssd300"
	echo " 8. ssd512"
	echo " 9. ssd_mobilenet_v1_coco"
	echo "10. ssd_mobilenet_v1_fpn_coco"
	echo "11. ssd_mobilenet_v2_coco"
	echo "12. ssdlite_mobilenet_v2"
}
function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function test_models
{
	case $1 in
		"1")
			echo " face-detection-retail-0044.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-detection-retail-0044/$2/face-detection-retail-0044.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-detection-retail-0044 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/face-detection-retail-0044/$2/face-detection-retail-0044.xml
		;;
		"2")
			echo " faster_rcnn_inception_resnet_v2_atrous_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_inception_resnet_v2_atrous_coco/$2/faster_rcnn_inception_resnet_v2_atrous_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=faster_rcnn_inception_resnet_v2_atrous_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_inception_resnet_v2_atrous_coco/$2/faster_rcnn_inception_resnet_v2_atrous_coco.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/faster_rcnn_inception_resnet_v2_atrous_coco/$2/faster_rcnn_inception_resnet_v2_atrous_coco.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/faster_rcnn_inception_resnet_v2_atrous_coco/$2/faster_rcnn_inception_resnet_v2_atrous_coco.xml
		;;
		"3")
			echo " faster_rcnn_inception_v2_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_inception_v2_coco/$2/faster_rcnn_inception_v2_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=faster_rcnn_inception_v2_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_inception_v2_coco/$2/faster_rcnn_inception_v2_coco.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/faster_rcnn_inception_v2_coco/$2/faster_rcnn_inception_v2_coco.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/faster_rcnn_inception_v2_coco/$2/faster_rcnn_inception_v2_coco.xml
		;;
		"4")
			echo " faster_rcnn_resnet101_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_resnet101_coco/$2/faster_rcnn_resnet101_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=faster_rcnn_resnet101_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_resnet101_coco/$2/faster_rcnn_resnet101_coco.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/faster_rcnn_resnet101_coco/$2/faster_rcnn_resnet101_coco.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/faster_rcnn_resnet101_coco/$2/faster_rcnn_resnet101_coco.xml
		;;
		"5")
			echo " faster_rcnn_resnet50_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_resnet50_coco/$2/faster_rcnn_resnet50_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=faster_rcnn_resnet50_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_resnet50_coco/$2/faster_rcnn_resnet50_coco.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/faster_rcnn_resnet50_coco/$2/faster_rcnn_resnet50_coco.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/faster_rcnn_resnet50_coco/$2/faster_rcnn_resnet50_coco.xml
		;;
		"6")
			echo " mobilenet-ssd.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-ssd/$2/mobilenet-ssd.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-ssd --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-ssd/$2/mobilenet-ssd.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/mobilenet-ssd/$2/mobilenet-ssd.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-ssd/$2/mobilenet-ssd.xml
		;;
		"7")
			echo " ssd300.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd300/$2/ssd300.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd300 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/ssd300/$2/ssd300.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/ssd300/$2/ssd300.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd300/$2/ssd300.xml
		;;
		"8")
			echo " ssd512.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd512/$2/ssd512.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd512 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/ssd512/$2/ssd512.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/ssd512/$2/ssd512.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd512/$2/ssd512.xml
		;;
		"9")
			echo " ssd_mobilenet_v1_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_coco/$2/ssd_mobilenet_v1_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd_mobilenet_v1_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_coco/$2/ssd_mobilenet_v1_coco.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_coco/$2/ssd_mobilenet_v1_coco.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_coco/$2/ssd_mobilenet_v1_coco.xml
		;;
		"10")
			echo " ssd_mobilenet_v1_fpn_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_fpn_coco/$2/ssd_mobilenet_v1_fpn_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd_mobilenet_v1_fpn_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_fpn_coco/$2/ssd_mobilenet_v1_fpn_coco.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_fpn_coco/$2/ssd_mobilenet_v1_fpn_coco.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_fpn_coco/$2/ssd_mobilenet_v1_fpn_coco.xml
		;;
		"11")
			echo " ssd_mobilenet_v2_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v2_coco/$2/ssd_mobilenet_v2_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd_mobilenet_v2_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v2_coco/$2/ssd_mobilenet_v2_coco.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v2_coco/$2/ssd_mobilenet_v2_coco.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd_mobilenet_v2_coco/$2/ssd_mobilenet_v2_coco.xml
		;;
		"12")
			echo " ssdlite_mobilenet_v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssdlite_mobilenet_v2/$2/ssdlite_mobilenet_v2.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssdlite_mobilenet_v2 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/ssdlite_mobilenet_v2/$2/ssdlite_mobilenet_v2.labels || ( echo "> copy CocoDataset Labels"; cp -r $label_path/Coco/coco.labels ${MODEL_LOC}/../../ir/public/ssdlite_mobilenet_v2/$2/ssdlite_mobilenet_v2.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssdlite_mobilenet_v2/$2/ssdlite_mobilenet_v2.xml
		;;	
		"0")
			return 1
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_0_LOC=${choose}
		;;
	esac
}

function set_others()
{
	inference_D_choose
	source_choose
}

function model_0_choose()
{
	I_SOURCE="cam"
	TARGET_0="CPU"
	model_list
	echo " [Select a Object Detection model.]"
	read choose
	if [ $choose == "0" ]; then
		test_models 12 FP16
	else
		echo " >> input your data type, support \"FP32\" and \"FP16\" "
		read fpchoose
		test_models $choose $fpchoose
		set_others
	fi
	
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
cd $DEMO_LOC
ARGS=" -m ${MODEL_0_LOC} -i ${I_SOURCE} -d ${TARGET_0}"
echo "RUN ./object_detection_demo_ssd_async $ARGS"
./object_detection_demo_ssd_async $ARGS