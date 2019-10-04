# File: benchmark_app.sh
# 2019/07/26	henry1758f 0.0.1	First Create
# 2019/07/30	henry1758f 1.0.0	workable
# 2019/07/30	henry1758f 2.0.0	Add Object Detection Models, new feature:export benchmark result is now available
# 2019/07/30	henry1758f 2.1.0	new feature:setting multiple testing times is now available
# 2019/10/04	henry1758f 3.0.0	Fit OpenVINOv2019.3.334, 76 kinds of model is available
# 2019/10/04	henry1758f 3.0.1	Fix Error when there's no IR file the MO cannot been excute correctly

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO,MULTI...Please choose your target device."
converter_path="${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/converter.py"

# Classification Models


model_enable_count=76



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
	echo " 1. alexnet"
	echo " 2. brain-tumor-segmentation-0001"
	echo " 3. caffenet"
	echo " 4. ctpn"
	echo " 5. deeplabv3"
	echo " 6. densenet-121"
	echo " 7. densenet-121-tf"
	echo " 8. densenet-161"
	echo " 9. densenet-161-tf"
	echo "10. densenet-169"
	echo "11. densenet-169-tf"
	echo "12. densenet-201"
	echo "13. face-detection-retail-0044"
	echo "14. face-recognition-mobilefacenet-arcface"
	echo "15. face-recognition-resnet100-arcface"
	echo "16. face-recognition-resnet34-arcface"
	echo "17. face-recognition-resnet50-arcface"
	echo "18. facenet-20180408-102900"
	echo "19. faster_rcnn_inception_resnet_v2_atrous_coco"
	echo "20. faster_rcnn_inception_v2_coco"
	echo "21. faster_rcnn_resnet101_coco"
	echo "22. faster_rcnn_resnet50_coco"
	echo "23. googlenet-v1"
	echo "24. googlenet-v2"
	echo "25. googlenet-v3"
	echo "26. googlenet-v3-pytorch"
	echo "27. googlenet-v4"
	echo "28. inception-resnet-v2"
	echo "29. inception-resnet-v2-tf"
	echo "30. license-plate-recognition-barrier-0007"
	echo "31. mask_rcnn_inception_resnet_v2_atrous_coco"
	echo "32. mask_rcnn_inception_v2_coco"
	echo "33. mask_rcnn_resnet101_atrous_coco"
	echo "34. mask_rcnn_resnet50_atrous_coco"
	echo "35. mobilenet-ssd"
	echo "36. mobilenet-v1-0.25-128"
	echo "37. mobilenet-v1-0.50-160"
	echo "38. mobilenet-v1-0.50-224"
	echo "39. mobilenet-v1-1.0-224"
	echo "40. mobilenet-v1-1.0-224-tf"
	echo "41. mobilenet-v2"
	echo "42. mobilenet-v2-1.0-224"
	echo "43. mobilenet-v2-1.4-224"
	echo "44. mobilenet-v2-pytorch"
	echo "45. mtcnn-o"
	echo "46. mtcnn-p"
	echo "47. mtcnn-r"
	echo "48. octave-densenet-121-0.125"
	echo "49. octave-resnet-101-0.125"
	echo "50. octave-resnet-200-0.125"
	echo "51. octave-resnet-26-0.25"
	echo "52. octave-resnet-50-0.125"
	echo "53. octave-resnext-101-0.25"
	echo "54. octave-resnext-50-0.25"
	echo "55. octave-se-resnet-50-0.125"
	echo "56. resnet-101"
	echo "57. resnet-152"
	echo "58. resnet-50"
	echo "59. resnet-50-pytorch"
	echo "60. se-inception"
	echo "61. se-resnet-101"
	echo "62. se-resnet-152"
	echo "63. se-resnet-50"
	echo "64. se-resnext-101"
	echo "65. se-resnext-50"
	echo "66. squeezenet1.0"
	echo "67. squeezenet1.1"
	echo "68. ssd300"
	echo "69. ssd512"
	echo "70. ssd_mobilenet_v1_coco"
	echo "71. ssd_mobilenet_v1_fpn_coco"
	echo "72. ssd_mobilenet_v2_coco"
	echo "73. ssdlite_mobilenet_v2"
	echo "74. vgg16"
	echo "75. vgg19"
	echo "76. Sphereface"

}
function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function test_models
{
	#echo "[DEBUG] $2 $1"
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
			echo " alexnet.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/alexnet/$2/alexnet.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=alexnet --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/alexnet/$2/alexnet.xml
		;;
		"2")
			echo " brain-tumor-segmentation-0001.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/brain-tumor-segmentation-0001/$2/brain-tumor-segmentation-0001.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=brain-tumor-segmentation-0001 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/brain-tumor-segmentation-0001/$2/brain-tumor-segmentation-0001.xml
		;;
		"3")
			echo " caffenet.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/caffenet/$2/caffenet.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=caffenet --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/caffenet/$2/caffenet.xml
		;;
		"4")
			echo " ctpn.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ctpn/$2/ctpn.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ctpn --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ctpn/$2/ctpn.xml
		;;
		"5")
			echo " deeplabv3.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/deeplabv3/$2/deeplabv3.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=deeplabv3 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/deeplabv3/$2/deeplabv3.xml
		;;
		"6")
			echo " densenet-121.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-121/$2/densenet-121.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=densenet-121 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-121/$2/densenet-121.xml
		;;
		"7")
			echo " densenet-121-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-121-tf/$2/densenet-121-tf.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=densenet-121-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-121-tf/$2/densenet-121-tf.xml
		;;
		"8")
			echo " densenet-161.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-161/$2/densenet-161.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=densenet-161 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-161/$2/densenet-161.xml
		;;
		"9")
			echo " densenet-161-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-161-tf/$2/densenet-161-tf.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=densenet-161-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-161-tf/$2/densenet-161-tf.xml
		;;
		"10")
			echo " densenet-169.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-169/$2/densenet-169.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=densenet-169 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-169/$2/densenet-169.xml
		;;
		"11")
			echo " densenet-169-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-169-tf/$2/densenet-169-tf.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=densenet-169-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-169-tf/$2/densenet-169-tf.xml
		;;
		"12")
			echo " densenet-201.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-201/$2/densenet-201.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=densenet-201 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-201/$2/densenet-201.xml
		;;
		"13")
			echo " face-detection-retail-0044.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-detection-retail-0044/$2/face-detection-retail-0044.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-detection-retail-0044 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/face-detection-retail-0044/$2/face-detection-retail-0044.xml
		;;
		"14")
			echo " face-recognition-mobilefacenet-arcface.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-recognition-mobilefacenet-arcface/$2/face-recognition-mobilefacenet-arcface.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-recognition-mobilefacenet-arcface --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/face-recognition-mobilefacenet-arcface/$2/face-recognition-mobilefacenet-arcface.xml
		;;
		"15")
			echo " face-recognition-resnet100-arcface.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-recognition-resnet100-arcface/$2/face-recognition-resnet100-arcface.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-recognition-resnet100-arcface --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/face-recognition-resnet100-arcface/$2/face-recognition-resnet100-arcface.xml
		;;
		"16")
			echo " face-recognition-resnet34-arcface.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-recognition-resnet34-arcface/$2/face-recognition-resnet34-arcface.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-recognition-resnet34-arcface --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/face-recognition-resnet34-arcface/$2/face-recognition-resnet34-arcface.xml
		;;
		"17")
			echo " face-recognition-resnet50-arcface.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-recognition-resnet50-arcface/$2/face-recognition-resnet50-arcface.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-recognition-resnet50-arcface --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/face-recognition-resnet50-arcface/$2/face-recognition-resnet50-arcface.xml
		;;
		"18")
			echo " facenet-20180408-102900.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/facenet-20180408-102900/$2/facenet-20180408-102900.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=facenet-20180408-102900 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/facenet-20180408-102900/$2/facenet-20180408-102900.xml
		;;
		"19")
			echo " faster_rcnn_inception_resnet_v2_atrous_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_inception_resnet_v2_atrous_coco/$2/faster_rcnn_inception_resnet_v2_atrous_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=faster_rcnn_inception_resnet_v2_atrous_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/faster_rcnn_inception_resnet_v2_atrous_coco/$2/faster_rcnn_inception_resnet_v2_atrous_coco.xml
		;;
		"20")
			echo " faster_rcnn_inception_v2_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_inception_v2_coco/$2/faster_rcnn_inception_v2_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=faster_rcnn_inception_v2_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/faster_rcnn_inception_v2_coco/$2/faster_rcnn_inception_v2_coco.xml
		;;
		"21")
			echo " faster_rcnn_resnet101_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_resnet101_coco/$2/faster_rcnn_resnet101_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=faster_rcnn_resnet101_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/faster_rcnn_resnet101_coco/$2/faster_rcnn_resnet101_coco.xml
		;;
		"22")
			echo " faster_rcnn_resnet50_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/faster_rcnn_resnet50_coco/$2/faster_rcnn_resnet50_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=faster_rcnn_resnet50_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/faster_rcnn_resnet50_coco/$2/faster_rcnn_resnet50_coco.xml
		;;
		"23")
			echo " googlenet-v1.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v1/$2/googlenet-v1.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v1 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v1/$2/googlenet-v1.xml
		;;
		"24")
			echo " googlenet-v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v2/$2/googlenet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v2 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v2/$2/googlenet-v2.xml
		;;
		"25")
			echo " googlenet-v3.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v3/$2/googlenet-v3.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v3 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v3/$2/googlenet-v3.xml
		;;
		"26")
			echo " googlenet-v3-pytorch.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v3-pytorch/$2/googlenet-v3-pytorch.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v3-pytorch --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v3-pytorch/$2/googlenet-v3-pytorch.xml
		;;
		"27")
			echo " googlenet-v4.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v4/$2/googlenet-v4.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v4 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v4/$2/googlenet-v4.xml
		;;
		"28")
			echo " inception-resnet-v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/inception-resnet-v2/$2/inception-resnet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=inception-resnet-v2 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/inception-resnet-v2/$2/inception-resnet-v2.xml
		;;
		"29")
			echo " inception-resnet-v2-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/inception-resnet-v2-tf/$2/inception-resnet-v2-tf.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=inception-resnet-v2-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/inception-resnet-v2-tf/$2/inception-resnet-v2-tf.xml
		;;
		"30")
			echo " license-plate-recognition-barrier-0007.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/license-plate-recognition-barrier-0007/$2/license-plate-recognition-barrier-0007.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=license-plate-recognition-barrier-0007 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/license-plate-recognition-barrier-0007/$2/license-plate-recognition-barrier-0007.xml
		;;
		"31")
			echo " mask_rcnn_inception_resnet_v2_atrous_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mask_rcnn_inception_resnet_v2_atrous_coco/$2/mask_rcnn_inception_resnet_v2_atrous_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mask_rcnn_inception_resnet_v2_atrous_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mask_rcnn_inception_resnet_v2_atrous_coco/$2/mask_rcnn_inception_resnet_v2_atrous_coco.xml
		;;
		"32")
			echo " mask_rcnn_inception_v2_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mask_rcnn_inception_v2_coco/$2/mask_rcnn_inception_v2_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mask_rcnn_inception_v2_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mask_rcnn_inception_v2_coco/$2/mask_rcnn_inception_v2_coco.xml
		;;
		"33")
			echo " mask_rcnn_resnet101_atrous_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mask_rcnn_resnet101_atrous_coco/$2/mask_rcnn_resnet101_atrous_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mask_rcnn_resnet101_atrous_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mask_rcnn_resnet101_atrous_coco/$2/mask_rcnn_resnet101_atrous_coco.xml
		;;
		"34")
			echo " mask_rcnn_resnet50_atrous_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mask_rcnn_resnet50_atrous_coco/$2/mask_rcnn_resnet50_atrous_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mask_rcnn_resnet50_atrous_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mask_rcnn_resnet50_atrous_coco/$2/mask_rcnn_resnet50_atrous_coco.xml
		;;
		"35")
			echo " mobilenet-ssd.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-ssd/$2/mobilenet-ssd.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-ssd --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-ssd/$2/mobilenet-ssd.xml
		;;
		"36")
			echo " mobilenet-v1-0.25-128.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.25-128/$2/mobilenet-v1-0.25-128.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-0.25-128 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-0.25-128/$2/mobilenet-v1-0.25-128.xml
		;;
		"37")
			echo " mobilenet-v1-0.50-160.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-160/$2/mobilenet-v1-0.50-160.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-0.50-160 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-160/$2/mobilenet-v1-0.50-160.xml
		;;
		"38")
			echo " mobilenet-v1-0.50-224.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-224/$2/mobilenet-v1-0.50-224.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-0.50-224 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-224/$2/mobilenet-v1-0.50-224.xml
		;;
		"39")
			echo " mobilenet-v1-1.0-224.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224/$2/mobilenet-v1-1.0-224.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-1.0-224 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224/$2/mobilenet-v1-1.0-224.xml
		;;
		"40")
			echo " mobilenet-v1-1.0-224-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224-tf/$2/mobilenet-v1-1.0-224-tf.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-1.0-224-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224-tf/$2/mobilenet-v1-1.0-224-tf.xml
		;;
		"41")
			echo " mobilenet-v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2/$2/mobilenet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v2 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v2/$2/mobilenet-v2.xml
		;;
		"42")
			echo " mobilenet-v2-1.0-224.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-1.0-224/$2/mobilenet-v2-1.0-224.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v2-1.0-224 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v2-1.0-224/$2/mobilenet-v2-1.0-224.xml
		;;
		"43")
			echo " mobilenet-v2-1.4-224.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-1.4-224/$2/mobilenet-v2-1.4-224.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v2-1.4-224 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v2-1.4-224/$2/mobilenet-v2-1.4-224.xml
		;;
		"44")
			echo " mobilenet-v2-pytorch.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-pytorch/$2/mobilenet-v2-pytorch.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v2-pytorch --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v2-pytorch/$2/mobilenet-v2-pytorch.xml
		;;
		"45")
			echo " mtcnn-o.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mtcnn-o/$2/mtcnn-o.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mtcnn-o --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mtcnn-o/$2/mtcnn-o.xml
		;;
		"46")
			echo " mtcnn-p.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mtcnn-p/$2/mtcnn-p.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mtcnn-p --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mtcnn-p/$2/mtcnn-p.xml
		;;
		"47")
			echo " mtcnn-r.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mtcnn-r/$2/mtcnn-r.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mtcnn-r --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mtcnn-r/$2/mtcnn-r.xml
		;;
		"48")
			echo " octave-densenet-121-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-densenet-121-0.125/$2/octave-densenet-121-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-densenet-121-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-densenet-121-0.125/$2/octave-densenet-121-0.125.xml
		;;
		"49")
			echo " octave-resnet-101-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-101-0.125/$2/octave-resnet-101-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnet-101-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnet-101-0.125/$2/octave-resnet-101-0.125.xml
		;;
		"50")
			echo " octave-resnet-200-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-200-0.125/$2/octave-resnet-200-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnet-200-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnet-200-0.125/$2/octave-resnet-200-0.125.xml
		;;
		"51")
			echo " octave-resnet-26-0.25.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-26-0.25/$2/octave-resnet-26-0.25.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnet-26-0.25 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnet-26-0.25/$2/octave-resnet-26-0.25.xml
		;;
		"52")
			echo " octave-resnet-50-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-50-0.125/$2/octave-resnet-50-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnet-50-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnet-50-0.125/$2/octave-resnet-50-0.125.xml
		;;
		"53")
			echo " octave-resnext-101-0.25.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnext-101-0.25/$2/octave-resnext-101-0.25.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnext-101-0.25 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnext-101-0.25/$2/octave-resnext-101-0.25.xml
		;;
		"54")
			echo " octave-resnext-50-0.25.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnext-50-0.25/$2/octave-resnext-50-0.25.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnext-50-0.25 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnext-50-0.25/$2/octave-resnext-50-0.25.xml
		;;
		"55")
			echo " octave-se-resnet-50-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-se-resnet-50-0.125/$2/octave-se-resnet-50-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-se-resnet-50-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-se-resnet-50-0.125/$2/resnet-101.xml
		;;
		"56")
			echo " resnet-101.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/resnet-101/$2/resnet-101.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=resnet-101 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/resnet-101/$2/resnet-101.xml
		;;
		"57")
			echo " resnet-152.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/resnet-152/$2/resnet-152.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=resnet-152 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/resnet-152/$2/resnet-152.xml
		;;
		"58")
			echo " resnet-50.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/resnet-50/$2/resnet-50.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=resnet-50 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/resnet-50/$2/resnet-50.xml
		;;
		"59")
			echo " resnet-50-pytorch.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/resnet-50-pytorch/$2/resnet-50-pytorch.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=resnet-50-pytorch --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/resnet-50-pytorch/$2/resnet-50-pytorch.xml
		;;
		"60")
			echo " se-inception.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-inception/$2/se-inception.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-inception --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-inception/$2/se-inception.xml
		;;
		"61")
			echo " se-resnet-101.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-101/$2/se-resnet-101.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnet-101 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnet-101/$2/se-resnet-101.xml
		;;
		"62")
			echo " se-resnet-152.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-152/$2/se-resnet-152.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnet-152 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnet-152/$2/se-resnet-152.xml
		;;
		"63")
			echo " se-resnet-50.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-50/$2/se-resnet-50.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnet-50 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnet-50/$2/se-resnet-50.xml
		;;
		"64")
			echo " se-resnext-101.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnext-101/$2/se-resnext-101.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnext-101 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnext-101/$2/se-resnext-101.xml
		;;
		"65")
			echo " se-resnext-50.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnext-50/$2/se-resnext-50.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnext-50 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnext-50/$2/se-resnext-50.xml
		;;
		"66")
			echo " squeezenet1.0.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/squeezenet1.0/$2/squeezenet1.0.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=squeezenet1.0 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/squeezenet1.0/$2/squeezenet1.0.xml
		;;
		"67")
			echo " squeezenet1.1.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/squeezenet1.1/$2/squeezenet1.1.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=squeezenet1.1 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/squeezenet1.1/$2/squeezenet1.1.xml
		;;
		"68")
			echo " ssd300.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd300/$2/ssd300.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd300 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd300/$2/ssd300.xml
		;;
		"69")
			echo " ssd512.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd512/$2/ssd512.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd512 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd512/$2/ssd512.xml
		;;
		"70")
			echo " ssd_mobilenet_v1_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_coco/$2/ssd_mobilenet_v1_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd_mobilenet_v1_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_coco/$2/ssd_mobilenet_v1_coco.xml
		;;
		"71")
			echo " ssd_mobilenet_v1_fpn_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_fpn_coco/$2/ssd_mobilenet_v1_fpn_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd_mobilenet_v1_fpn_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd_mobilenet_v1_fpn_coco/$2/ssd_mobilenet_v1_fpn_coco.xml
		;;
		"72")
			echo " ssd_mobilenet_v2_coco.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssd_mobilenet_v2_coco/$2/ssd_mobilenet_v2_coco.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssd_mobilenet_v2_coco --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssd_mobilenet_v2_coco/$2/ssd_mobilenet_v2_coco.xml
		;;
		"73")
			echo " ssdlite_mobilenet_v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/ssdlite_mobilenet_v2/$2/ssdlite_mobilenet_v2.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=ssdlite_mobilenet_v2 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/ssdlite_mobilenet_v2/$2/ssdlite_mobilenet_v2.xml
		;;
		"74")
			echo " vgg16vgg19.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/vgg16vgg19/$2/vgg16vgg19.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=vgg16vgg19 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/vgg16vgg19/$2/vgg16vgg19.xml
		;;
		"75")
			echo " vgg19.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/vgg19/$2/vgg19.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=vgg19 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/vgg19/$2/vgg19.xml
		;;
		"76")
			echo " Sphereface.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/Sphereface/$2/Sphereface.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=Sphereface --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/Sphereface/$2/Sphereface.xml
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
			for ((i=1; i<=model_enable_count; i=i+1))
			do
				test_models $i FP32
				echo "============================================"
				echo "[INFO] [$i]Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0"

				if [ $recording == "true" ]; then
					echo "============================================" &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
					echo "[$i] Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0" &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
					for ((j=1; j<=$3; j=j+1))
					do
						echo "	[ FP32 ] Test $j "
						echo "	[ FP32 ] Test $j " &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
						$SAMPLE_LOC/benchmark_app -m ${MODEL_0_LOC} -i /opt/intel/openvino/deployment_tools/demo/car.png -d $TARGET_0 | grep -e 'Count:' -e 'Duration' -e 'Latency' -e 'Throughput' &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
					done
				else
					$SAMPLE_LOC/benchmark_app -m ${MODEL_0_LOC} -i /opt/intel/openvino/deployment_tools/demo/car.png -d $TARGET_0 | grep -e 'Count:' -e 'Duration' -e 'Latency' -e 'Throughput'
				fi

				test_models $i FP16
				echo "[INFO] [$i]Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0"

				if [ $recording == "true" ]; then
					echo "[$i] Testing Benchmark for \" ${MODEL_0_LOC} \" with $TARGET_0" &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
					for ((j=1; j<=$3; j=j+1))
					do
						echo "	[ FP16 ] Test $j "
						echo "	[ FP16 ] Test $j " &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
						$SAMPLE_LOC/benchmark_app -m ${MODEL_0_LOC} -i /opt/intel/openvino/deployment_tools/demo/car.png -d $TARGET_0 | grep -e 'Count:' -e 'Duration' -e 'Latency' -e 'Throughput' &>> ~/OpenVINO_Benchmark_Test_${cap_time}.txt
					done
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