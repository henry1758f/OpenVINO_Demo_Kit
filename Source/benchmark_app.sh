# File: benchmark_app.sh
# 2019/07/26	henry1758f 0.0.1	First Create
# 2019/07/30	henry1758f 1.0.0	workable
# 2019/07/30	henry1758f 2.0.0	Add Object Detection Models, new feature:export benchmark result is now available

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO,MULTI...Please choose your target device."
# Classification Models
squeezenet11_name="squeezenet1.1"
squeezenet11="classification/squeezenet/1.1/caffe"
squeezenet11_fp16="classification/squeezenet/1.1/caffe"
squeezenet10_name="squeezenet1.0"
squeezenet10="classification/squeezenet/1.0/caffe"
squeezenet10_fp16="classification/squeezenet/1.0/caffe"
alexnet_name="alexnet"
alexnet="classification/alexnet/caffe"
alexnet_fp16="classification/alexnet/caffe"
densenet201_name="densenet-201"
densenet201="classification/densenet/201/caffe"
densenet201_fp16="classification/densenet/201/caffe"
densenet169_name="densenet-169"
densenet169="classification/densenet/169/caffe"
densenet169_fp16="classification/densenet/169/caffe"
densenet161_name="densenet-161"
densenet161="classification/densenet/161/caffe"
densenet161_fp16="classification/densenet/161/caffe"
densenet121_name="densenet-121"
densenet121="classification/densenet/121/caffe"
densenet121_fp16="classification/densenet/121/caffe"
googlenetv1_name="googlenet-v1"
googlenetv1="classification/googlenet/v1/caffe"
googlenetv1_fp16="classification/googlenet/v1/caffe"
googlenetv2_name="googlenet-v2"
googlenetv2="classification/googlenet/v2/caffe"
googlenetv2_fp16="classification/googlenet/v2/caffe"
googlenetv3_name="inception_v3_2016_08_28_frozen"
googlenetv3="classification/googlenet/v3/tf"
googlenetv3_fp16="classification/googlenet/v3/tf"
googlenetv4_name="googlenet-v4"
googlenetv4="classification/googlenet/v4/caffe"
googlenetv4_fp16="classification/googlenet/v4/caffe"
vgg16_name="vgg16"
vgg16="classification/vgg/16/caffe"
vgg16_fp16="classification//vgg/16/caffe"
vgg19_name="vgg19"
vgg19="classification/vgg/19/caffe"
vgg19_fp16="classification//vgg/19/caffe"
inception_resnetv2_name="inception-resnet-v2"
inception_resnetv2="classification/inception-resnet/v2/caffe"
inception_resnetv2_fp16="classification/inception-resnet/v2/caffe"
mobilenetv1_name="mobilenet-v1-1.0-224"
mobilenetv1="classification/mobilenet/v1/1.0/224/cf"
mobilenetv1_fp16="classification/mobilenet/v1/1.0/224/cf"
mobilenetv2_name="mobilenet-v2"
mobilenetv2="classification/mobilenet/v2/cf"
mobilenetv2_fp16="classification/mobilenet/v2/cf"
mobilenetv2_tf_name="mobilenet_v2_1.4_224_frozen"
mobilenetv2_tf="classification/mobilenet/v2/tf/mobilenet_v2_1.4_224"
mobilenetv2_tf_fp16="classification/mobilenet/v2/tf/mobilenet_v2_1.4_224"
seinception_name="se-inception"
seinception="classification/se-networks/se-inception/caffe"
seinception_fp16="classification/se-networks/se-inception/caffe"
seresnet50_name="se-resnet-50"
seresnet50="classification/se-networks/se-resnet-50/caffe"
seresnet50_fp16="classification/se-networks/se-resnet-50/caffe"
seresnet101_name="se-resnet-101"
seresnet101="classification/se-networks/se-resnet-101/caffe"
seresnet101_fp16="classification/se-networks/se-resnet-101/caffe"
seresnet152_name="se-resnet-152"
seresnet152="classification/se-networks/se-resnet-152/caffe"
seresnet152_fp16="classification/se-networks/se-resnet-152/caffe"
seresnext50_name="se-resnext-50"
seresnext50="classification/se-networks/se-resnext-50/caffe"
seresnext50_fp16="classification/se-networks/se-resnext-50/caffe"
seresnext101_name="se-resnext-101"
seresnext101="classification/se-networks/se-resnext-101/caffe"
seresnext101_fp16="classification/se-networks/se-resnext-101/caffe"
# Object Detection Models
ssd_mobilenet_v2_coco_frozen_name="frozen_inference_graph"
ssd_mobilenet_v2_coco_frozen="object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29"
ssd_mobilenet_v1_coco_frozen_name="frozen_inference_graph"
ssd_mobilenet_v1_coco_frozen="object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco_2018_01_28"
ssd_512_name="VGG_VOC0712Plus_SSD_512x512_iter_240000"
ssd_512="object_detection/common/ssd/512/caffe/models/VGGNet/VOC0712Plus/SSD_512x512"
ssd_300_name="VGG_VOC0712Plus_SSD_300x300_ft_iter_160000"
ssd_300="object_detection/common/ssd/300/caffe/models/VGGNet/VOC0712Plus/SSD_300x300_ft"
mobilenet_ssd_name="mobilenet-ssd"
mobilenet_ssd="object_detection/common/mobilenet-ssd/caffe"
mtcnn_o_name="mtcnn-o"
mtcnn_o="object_detection/common/mtcnn/o/caffe"
mtcnn_p_name="mtcnn-p"
mtcnn_p="object_detection/common/mtcnn/p/caffe"
mtcnn_r_name="mtcnn-r"
mtcnn_r="object_detection/common/mtcnn/r/caffe"
faster_rcnn_inception_v2_name="frozen_inference_graph"
faster_rcnn_inception_v2="object_detection/common/faster_rcnn/faster_rcnn_inception_v2_coco/tf/faster_rcnn_inception_v2_coco_2018_01_28"
faster_rcnn_resnet101_name="frozen_inference_graph"
faster_rcnn_resnet101="object_detection/common/faster_rcnn/faster_rcnn_resnet101_coco/tf/faster_rcnn_resnet101_coco_2018_01_28"
faster_rcnn_resnet50_name="frozen_inference_graph"
faster_rcnn_resnet50="object_detection/common/faster_rcnn/faster_rcnn_resnet50_coco/faster_rcnn_resnet50_coco_2018_01_28"
faster_rcnn_Inception_resnet_v2_atrous_name="frozen_inference_graph"
faster_rcnn_Inception_resnet_v2_atrous="object_detection/common/faster_rcnn/faster_rcnn_inception_resnet_v2_atrous_coco/faster_rcnn_inception_resnet_v2_atrous_coco_2018_01_28"


model_enable_count=33



function banner_show()
{
	echo "|=========================================|"
	echo "|              Benchmark App              |"
	echo "|=========================================|"
	echo "|  Support OpenVINO $VERSION_VINO"
	echo ""
}
function model_list()
{
	echo " 1. ${squeezenet11_name}.xml"
	echo " 2. ${squeezenet10_name}.xml "
	echo " 3. ${alexnet_name}.xml "
	echo " 4. ${densenet201_name}.xml "
	echo " 5. ${densenet169_name}.xml "
	echo " 6. ${densenet161_name}.xml "
	echo " 7. ${densenet121_name}.xml "
	echo " 8. ${googlenetv1_name}.xml "
	echo " 9. ${googlenetv2_name}.xml "
	echo "10. ${googlenetv3_name}.xml "
	echo "11. ${googlenetv4_name}.xml "
	echo "12. ${inception_resnetv2_name}.xml "
	echo "13. ${mobilenetv1_name}.xml "
	echo "14. ${mobilenetv2_name}.xml "
	echo "15. ${mobilenetv2_tf_name}.xml "
	echo "16. ${seinception_name}.xml "
	echo "17. ${seresnet50_name}.xml "
	echo "18. ${seresnet101_name}.xml "
	echo "19. ${seresnet152_name}.xml "
	echo "20. ${seresnext50_name}.xml "
	echo "21. ${seresnext101_name}.xml "
	echo "22. ${vgg16_name}.xml "
	echo "23. ${vgg19_name}.xml "

	echo "24. ssd_mobilenet_v2_coco_2018_03_29 (${ssd_mobilenet_v2_coco_frozen_name}.xml) "
	echo "25. ssd_mobilenet_v1_coco_2018_01_28 (${ssd_mobilenet_v1_coco_frozen_name}.xml) "
	echo "26. SSD_512x512 (${ssd_512_name}.xml) "
	echo "27. SSD_300x300_ft (${ssd_300_name}.xml) "
	echo "28. ${mobilenet_ssd_name}.xml "
	echo "29. ${mtcnn_o_name}.xml "
	echo "30. ${mtcnn_p_name}.xml "
	echo "31. ${mtcnn_r_name}.xml "
	echo "32. faster_rcnn_inception_v2_coco_2018_01_28 (${faster_rcnn_inception_v2_name}.xml) "
	echo "33. faster_rcnn_resnet101_coco_2018_01_28 (${faster_rcnn_resnet101_name}.xml) "
	#echo "34. faster_rcnn_resnet50_coco_2018_01_28 (${faster_rcnn_resnet50_name}.xml)  "
	#echo "35. faster_rcnn_inception_resnet_v2_atrous_coco_2018_01_28 (${faster_rcnn_Inception_resnet_v2_atrous_name}.xml) "


}
function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function test_models
{
	echo "[DEBUG] $2 $1"
	case $2 in
		"FP32")
			str_fp="-fp32"
		;;
		"FP16")
			str_fp="-fp16"
		;; 
	esac

	case $1 in
		"1")
			echo " ${squeezenet11_name}.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${squeezenet11}/${squeezenet11_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ${squeezenet11_name}.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${squeezenet11}/squeezenet1.1.xml
		;;
		"2")
			echo " squeezenet1.0.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${squeezenet10}/squeezenet1.0.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m squeezenet1.0.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${squeezenet10}/squeezenet1.0.xml
		;;

		"3")
			echo " alexnet.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${alexnet}/alexnet.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m alexnet.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${alexnet}/alexnet.xml
		;;

		"4")
			echo " densenet-201.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${densenet201}/densenet-201.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-201.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${densenet201}/densenet-201.xml
		;;

		"5")
			echo " densenet-169.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${densenet169}/densenet-169.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-169.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${densenet169}/densenet-169.xml
		;;

		"6")
			echo " densenet-161.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${densenet161}/densenet-161.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-161.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${densenet161}/densenet-161.xml
		;;

		"7")
			echo " densenet-121.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${densenet121}/densenet-121.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-121.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${densenet121}/densenet-121.xml
		;;

		"8")
			echo " googlenet-v1.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${googlenetv1}/googlenet-v1.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v1.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${googlenetv1}/googlenet-v1.xml
		;;

		"9")
			echo " googlenet-v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${googlenetv2}/googlenet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v2.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${googlenetv2}/googlenet-v2.xml
		;;

		"10")
			echo " googlenet-v3.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${googlenetv3}/inception_v3_2016_08_28_frozen.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v3.frozen.pb ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${googlenetv3}/inception_v3_2016_08_28_frozen.xml
		;;

		"11")
			echo " googlenet-v4.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${googlenetv4}/googlenet-v4.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v4.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${googlenetv4}/googlenet-v4.xml
		;;

		"12")
			echo " inception-resnet-v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${inception_resnetv2}/inception-resnet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m inception-resnet-v2.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${inception_resnetv2}/inception-resnet-v2.xml
		;;

		"13")
			echo " mobilenet-v1-1.0-224.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${mobilenetv1}/mobilenet-v1-1.0-224.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mobilenet-v1-1.0-224.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${mobilenetv1}/mobilenet-v1-1.0-224.xml
		;;

		"14")
			echo " mobilenet-v2.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${mobilenetv2}/mobilenet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mobilenet-v2.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${mobilenetv2}/mobilenet-v2.xml
		;;

		"15")
			echo " mobilenet_v2_1.4_224_frozen.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${mobilenetv2_tf}/mobilenet_v2_1.4_224_frozen.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mobilenet_v2_1.4_224_frozen.pb ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${mobilenetv2_tf}/mobilenet_v2_1.4_224_frozen.xml
		;;

		"16")
			echo " se-inception.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${seinception}/se-inception.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m se-inception.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${seinception}/se-inception.xml
		;;

		"17")
			echo " se-resnet-50.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${seresnet50}/se-resnet-50.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m se-resnet-50.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${seresnet50}/se-resnet-50.xml
		;;

		"18")
			echo " se-resnet-101.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${seresnet101}/se-resnet-101.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m se-resnet-101.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${seresnet101}/se-resnet-101.xml
		;;

		"19")
			echo " se-resnet-152.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${seresnet152}/se-resnet-152.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m se-resnet-152.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${seresnet152}/se-resnet-152.xml
		;;

		"20")
			echo " se-resnext-50.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${seresnext50}/se-resnext-50.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m se-resnext-50.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${seresnext50}/se-resnext-50.xml
		;;

		"21")
			echo " se-resnext-101.xml [$2] ->"			
			test -e ${MODEL_LOC}/../../ir/$2/${seresnext101}/se-resnext-101.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m se-resnext-101.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${seresnext101}/se-resnext-101.xml
		;;

		"22")
			echo " vgg16.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${vgg16}/vgg16.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m vgg16.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${vgg16}/vgg16.xml
		;;

		"23")
			echo " vgg19.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${vgg19}/vgg19.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m vgg19.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${vgg19}/vgg19.xml
		;;

		"24")
			echo " ssd_mobilenet_v2_coco_2018_03_29 (${ssd_mobilenet_v2_coco_frozen_name}.xml) [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${ssd_mobilenet_v2_coco_frozen}/${ssd_mobilenet_v2_coco_frozen_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd_mobilenet_v2_coco.frozen.pb ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${ssd_mobilenet_v2_coco_frozen}/${ssd_mobilenet_v2_coco_frozen_name}.xml
		;;
		"25")
			echo " ssd_mobilenet_v1_coco_2018_01_28 (${ssd_mobilenet_v1_coco_frozen_name}.xml) [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${ssd_mobilenet_v1_coco_frozen}/${ssd_mobilenet_v1_coco_frozen_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd_mobilenet_v1_coco.frozen.pb ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${ssd_mobilenet_v1_coco_frozen}/${ssd_mobilenet_v1_coco_frozen_name}.xml
		;;
		"26")
			echo " SSD_512x512 (${ssd_512_name}.xml) [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${ssd_512}/${ssd_512_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd512.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${ssd_512}/${ssd_512_name}.xml
		;;
		"27")
			echo " SSD_300x300_ft (${ssd_300_name}.xml) [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${ssd_300}/${ssd_300_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m ssd300.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${ssd_300}/${ssd_300_name}.xml
		;;
		"28")
			echo " ${mobilenet_ssd_name}.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${mobilenet_ssd}/${mobilenet_ssd_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mobilenet-ssd.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${mobilenet_ssd}/${mobilenet_ssd_name}.xml
		;;
		"29")
			echo " ${mtcnn_o_name}.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${mtcnn_o}/${mtcnn_o_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-o.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${mtcnn_o}/${mtcnn_o_name}.xml
		;;
		"30")
			echo " ${mtcnn_p_name}.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${mtcnn_p}/${mtcnn_p_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-p.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${mtcnn_p}/${mtcnn_p_name}.xml
		;;
		"31")
			echo " ${mtcnn_r_name}.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${mtcnn_r}/${mtcnn_r_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m mtcnn-r.caffemodel ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${mtcnn_r}/${mtcnn_r_name}.xml
		;;
		"32")
			echo " faster_rcnn_inception_v2_coco_2018_01_28 (${faster_rcnn_inception_v2_name}.xml) [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${faster_rcnn_inception_v2}/${faster_rcnn_inception_v2_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m faster_rcnn_inception_v2.pb ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${faster_rcnn_inception_v2}/${faster_rcnn_inception_v2_name}.xml
		;;
		"33")
			echo " faster_rcnn_resnet101_coco_2018_01_28 (${faster_rcnn_resnet101_name}.xml) [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${faster_rcnn_resnet101}/${faster_rcnn_resnet101_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m faster_rcnn_resnet101.pb ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${faster_rcnn_resnet101}/${faster_rcnn_resnet101_name}.xml
		;;
		# TBD
		"34")
			echo " faster_rcnn_resnet50_coco_2018_01_28 (${faster_rcnn_resnet50_name}.xml) [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${faster_rcnn_resnet50}/${faster_rcnn_resnet50_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m faster_rcnn_resnet50.pb ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${faster_rcnn_resnet50}/${faster_rcnn_resnet50_name}.xml
		;;
		"35")
			echo " faster_rcnn_inception_resnet_v2_atrous_coco_2018_01_28 (${faster_rcnn_Inception_resnet_v2_atrous_name}.xml) [$2] ->"
			test -e ${MODEL_LOC}/../../ir/$2/${faster_rcnn_Inception_resnet_v2_atrous}/${faster_rcnn_Inception_resnet_v2_atrous_name}.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m faster_rcnn_Inception_resnet_v2_atrous.pb ${str_fp})
			MODEL_0_LOC=${MODEL_LOC}/../../ir/$2/${faster_rcnn_Inception_resnet_v2_atrous}/${faster_rcnn_Inception_resnet_v2_atrous_name}.xml
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
function excute
{
	cap_time=$(date +'%Y%m%d_%H%M%S')
	case $2 in
		"-log" )
			echo "Creating ~/OpenVINO_Benchmark_Test_${cap_time}.txt ...."
			echo "======= Benchmark Test =======" > ~/OpenVINO_Benchmark_Test_${cap_time}.txt
			echo "Starting time ${cap_time}" &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
			echo "" &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
			recording="true"
		;;
	esac
	case $1 in
		"all" )
			for ((i=24; i<=model_enable_count; i=i+1))
			do
				test_models $i FP32
				echo "============================================"
				echo "[INFO] [$i]Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0"

				if [ $recording == "true" ]; then
					echo "============================================" &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
					echo "[$i] Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0" &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
					$SAMPLE_LOC/benchmark_app -m ${MODEL_0_LOC} -i /opt/intel/openvino/deployment_tools/demo/car.png -d $TARGET_0 | grep -e 'Count:' -e 'Duration' -e 'Latency' -e 'Throughput' &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
				else
					$SAMPLE_LOC/benchmark_app -m ${MODEL_0_LOC} -i /opt/intel/openvino/deployment_tools/demo/car.png -d $TARGET_0 | grep -e 'Count:' -e 'Duration' -e 'Latency' -e 'Throughput'
				fi

				test_models $i FP16
				echo "[INFO] [$i]Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0"

				if [ $recording == "true" ]; then
					echo "[$i] Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0" &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
					$SAMPLE_LOC/benchmark_app -m ${MODEL_0_LOC} -i /opt/intel/openvino/deployment_tools/demo/car.png -d $TARGET_0 | grep -e 'Count:' -e 'Duration' -e 'Latency' -e 'Throughput' &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
				else
					$SAMPLE_LOC/benchmark_app -m ${MODEL_0_LOC} -i /opt/intel/openvino/deployment_tools/demo/car.png -d $TARGET_0 | grep -e 'Count:' -e 'Duration' -e 'Latency' -e 'Throughput'
				fi
			done		
		;;
		"all_FP32" )
		;;
		"all_FP16" )
		;;
		* )
			echo " >> input your data type, support \"FP32\" and \"FP16\" "
			read fpchoose
			test_models $1 $fpchoose
			echo "Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0"
			$SAMPLE_LOC/benchmark_app -m ${MODEL_0_LOC} -i /opt/intel/openvino/deployment_tools/demo/car.png -d $TARGET_0 
		;;
	esac
}
clear
banner_show
inference_D_choose
model_list
echo " >> Or input a path to your model "
read choose
excute $choose