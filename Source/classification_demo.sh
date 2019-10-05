# File: classification_demo.sh
# 2019/05/08	henry1758f 0.0.1	First Create
# 2019/05/09	henry1758f 1.0.0	workable
# 2019/07/26	henry1758f 2.0.0	Fit openVINO v2019.2.242
# 2019/07/26	henry1758f 2.0.1	Improved Output information 
# 2019/10/05	henry1758f 2.1.0	classification_demo  fit OpenVINO 2019R3

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
label_path="$HOME/SYNNEX_work/Source/labels"
converter_path="${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/converter.py"

export model_enable_count=22

function banner_show()
{
	echo "|=========================================|"
	echo "|        Image Classification Demo        |"
	echo "|=========================================|"
}


function model_list()
{
	echo " 1. alexnet"
	echo " 2. caffenet"
	echo " 3. densenet-121"
	echo " 4. densenet-121-tf"
	echo " 5. densenet-161"
	echo " 6. densenet-161-tf"
	echo " 7. densenet-169"
	echo " 8. densenet-169-tf"
	echo " 9. densenet-201"
	echo "10. googlenet-v1"
	echo "11. googlenet-v2"
	echo "12. googlenet-v3"
	echo "13. googlenet-v3-pytorch"
	echo "14. googlenet-v4"
	echo "15. inception-resnet-v2"
	echo "16. inception-resnet-v2-tf"
	echo "17. mobilenet-v1-0.25-128"
	echo "18. mobilenet-v1-0.50-160"
	echo "19. mobilenet-v1-0.50-224"
	echo "20. mobilenet-v1-1.0-224"
	echo "21. mobilenet-v1-1.0-224-tf"
	echo "22. mobilenet-v2"
	echo "23. mobilenet-v2-1.0-224"
	echo "24. mobilenet-v2-1.4-224"
	echo "25. mobilenet-v2-pytorch"
	echo "26. octave-densenet-121-0.125"
	echo "27. octave-resnet-101-0.125"
	echo "28. octave-resnet-200-0.125"
	echo "29. octave-resnet-26-0.25"
	echo "30. octave-resnet-50-0.125"
	echo "31. octave-resnext-101-0.25"
	echo "32. octave-resnext-50-0.25"
	echo "33. octave-se-resnet-50-0.125"
	echo "34. resnet-101"
	echo "35. resnet-152"
	echo "36. resnet-50"
	echo "37. resnet-50-pytorch"
	echo "38. se-inception"
	echo "39. se-resnet-101"
	echo "40. se-resnet-152"
	echo "41. se-resnet-50"
	echo "42. se-resnext-101"
	echo "43. se-resnext-50"
	echo "44. squeezenet1.0"
	echo "45. squeezenet1.1"
	echo "46. vgg16"
	echo "47. vgg19"
	echo "48. Sphereface"
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
			test -e ${MODEL_LOC}/../../ir/public/alexnet/$2/alexnet.xml  || ( echo "[Run Model Optimizer Demo]" ; python3 $converter_path --name=alexnet --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/alexnet/$2/alexnet.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/alexnet/$2/alexnet.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/alexnet/$2/alexnet.xml
		;;
		"2")
			echo " caffenet.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/caffenet/$2/caffenet.xml  || ( echo "[Run Model Optimizer Demo]" ;	python3 $converter_path --name=caffenet --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/caffenet/$2/caffenet.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/caffenet/$2/caffenet.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/caffenet/$2/caffenet.xml
		;;
		"3")
			echo " densenet-121.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-121/$2/densenet-121.xml  || ( echo "[Run Model Optimizer Demo]" ; python3 $converter_path --name=densenet-121 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/densenet-121/$2/densenet-121.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/densenet-121/$2/densenet-121.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-121/$2/densenet-121.xml
		;;
		"4")
			echo " densenet-121-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-121-tf/$2/densenet-121-tf.xml  || ( echo "[Run Model Optimizer Demo]" ; python3 $converter_path --name=densenet-121-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/densenet-121-tf/$2/densenet-121-tf.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/densenet-121-tf/$2/densenet-121-tf.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-121-tf/$2/densenet-121-tf.xml
		;;
		"5")
			echo " densenet-161.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-161/$2/densenet-161.xml  || ( echo "[Run Model Optimizer Demo]" ; python3 $converter_path --name=densenet-161 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/densenet-161/$2/densenet-161.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/densenet-161/$2/densenet-161.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-161/$2/densenet-161.xml
		;;
		"6")
			echo " densenet-161-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-161-tf/$2/densenet-161-tf.xml  || ( echo "[Run Model Optimizer Demo]" ; python3 $converter_path --name=densenet-161-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/densenet-161-tf/$2/densenet-161-tf.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/densenet-161-tf/$2/densenet-161-tf.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-161-tf/$2/densenet-161-tf.xml
		;;
		"7")
			echo " densenet-169.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-169/$2/densenet-169.xml  || ( echo "[Run Model Optimizer Demo]" ; python3 $converter_path --name=densenet-169 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/densenet-169/$2/densenet-169.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/densenet-169/$2/densenet-169.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-169/$2/densenet-169.xml
		;;
		"8")
			echo " densenet-169-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-169-tf/$2/densenet-169-tf.xml  || ( echo "[Run Model Optimizer Demo]" ; python3 $converter_path --name=densenet-169-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/densenet-169-tf/$2/densenet-169-tf.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/densenet-169-tf/$2/densenet-169-tf.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-169-tf/$2/densenet-169-tf.xml
		;;
		"9")
			echo " densenet-201.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/densenet-201/$2/densenet-201.xml  || ( echo "[Run Model Optimizer Demo]" ; python3 $converter_path --name=densenet-201 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2 )
			test -e ${MODEL_LOC}/../../ir/public/densenet-201/$2/densenet-201.labels || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/densenet-201/$2/densenet-201.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/densenet-201/$2/densenet-201.xml
		;;
		"10")
			echo " googlenet-v1.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v1/$2/googlenet-v1.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v1 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v1/$2/googlenet-v1.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/googlenet-v1/$2/googlenet-v1.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v1/$2/googlenet-v1.xml
		;;
		"11")
			echo " googlenet-v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v2/$2/googlenet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v2 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v2/$2/googlenet-v2.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/googlenet-v2/$2/googlenet-v2.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v2/$2/googlenet-v2.xml
		;;
		"12")
			echo " googlenet-v3.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v3/$2/googlenet-v3.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v3 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v3/$2/googlenet-v3.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/googlenet-v3/$2/googlenet-v3.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v3/$2/googlenet-v3.xml
		;;
		"13")
			echo " googlenet-v3-pytorch.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v3-pytorch/$2/googlenet-v3-pytorch.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v3-pytorch --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v3-pytorch/$2/googlenet-v3-pytorch.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/googlenet-v3-pytorch/$2/googlenet-v3-pytorch.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v3-pytorch/$2/googlenet-v3-pytorch.xml
		;;
		"14")
			echo " googlenet-v4.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v4/$2/googlenet-v4.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=googlenet-v4 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/googlenet-v4/$2/googlenet-v4.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/googlenet-v4/$2/googlenet-v4.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/googlenet-v4/$2/googlenet-v4.xml
		;;
		"15")
			echo " inception-resnet-v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/inception-resnet-v2/$2/inception-resnet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=inception-resnet-v2 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/inception-resnet-v2/$2/inception-resnet-v2.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/inception-resnet-v2/$2/inception-resnet-v2.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/inception-resnet-v2/$2/inception-resnet-v2.xml
		;;
		"16")
			echo " inception-resnet-v2-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/inception-resnet-v2-tf/$2/inception-resnet-v2-tf.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=inception-resnet-v2-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/inception-resnet-v2-tf/$2/inception-resnet-v2-tf.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/inception-resnet-v2-tf/$2/inception-resnet-v2-tf.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/inception-resnet-v2-tf/$2/inception-resnet-v2-tf.xml
		;;
		"17")
			echo " mobilenet-v1-0.25-128.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.25-128/$2/mobilenet-v1-0.25-128.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-0.25-128 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.25-128/$2/mobilenet-v1-0.25-128.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.25-128/$2/mobilenet-v1-0.25-128.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-0.25-128/$2/mobilenet-v1-0.25-128.xml
		;;
		"18")
			echo " mobilenet-v1-0.50-160.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-160/$2/mobilenet-v1-0.50-160.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-0.50-160 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-160/$2/mobilenet-v1-0.50-160.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-160/$2/mobilenet-v1-0.50-160.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-160/$2/mobilenet-v1-0.50-160.xml
		;;
		"19")
			echo " mobilenet-v1-0.50-224.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-224/$2/mobilenet-v1-0.50-224.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-0.50-224 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-224/$2/mobilenet-v1-0.50-224.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-224/$2/mobilenet-v1-0.50-224.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-0.50-224/$2/mobilenet-v1-0.50-224.xml
		;;
		"20")
			echo " mobilenet-v1-1.0-224.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224/$2/mobilenet-v1-1.0-224.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-1.0-224 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224/$2/mobilenet-v1-1.0-224.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224/$2/mobilenet-v1-1.0-224.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224/$2/mobilenet-v1-1.0-224.xml
		;;
		"21")
			echo " mobilenet-v1-1.0-224-tf.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224-tf/$2/mobilenet-v1-1.0-224-tf.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v1-1.0-224-tf --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224-tf/$2/mobilenet-v1-1.0-224-tf.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224-tf/$2/mobilenet-v1-1.0-224-tf.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224-tf/$2/mobilenet-v1-1.0-224-tf.xml
		;;
		"22")
			echo " mobilenet-v2.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2/$2/mobilenet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v2 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2/$2/mobilenet-v2.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v2/$2/mobilenet-v2.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v2/$2/mobilenet-v2.xml
		;;
		"23")
			echo " mobilenet-v2-1.0-224.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-1.0-224/$2/mobilenet-v2-1.0-224.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v2-1.0-224 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-1.0-224/$2/mobilenet-v2-1.0-224.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v2-1.0-224/$2/mobilenet-v2-1.0-224.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v2-1.0-224/$2/mobilenet-v2-1.0-224.xml
		;;
		"24")
			echo " mobilenet-v2-1.4-224.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-1.4-224/$2/mobilenet-v2-1.4-224.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v2-1.4-224 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-1.4-224/$2/mobilenet-v2-1.4-224.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v1-1.0-224-tf/$2/mobilenet-v1-1.0-224-tf.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v2-1.4-224/$2/mobilenet-v2-1.4-224.xml
		;;
		"25")
			echo " mobilenet-v2-pytorch.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-pytorch/$2/mobilenet-v2-pytorch.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=mobilenet-v2-pytorch --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/mobilenet-v2-pytorch/$2/mobilenet-v2-pytorch.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/mobilenet-v2-pytorch/$2/mobilenet-v2-pytorch.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/mobilenet-v2-pytorch/$2/mobilenet-v2-pytorch.xml
		;;
		"26")
			echo " octave-densenet-121-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-densenet-121-0.125/$2/octave-densenet-121-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-densenet-121-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/octave-densenet-121-0.125/$2/octave-densenet-121-0.125.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/octave-densenet-121-0.125/$2/octave-densenet-121-0.125.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-densenet-121-0.125/$2/octave-densenet-121-0.125.xml
		;;
		"27")
			echo " octave-resnet-101-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-101-0.125/$2/octave-resnet-101-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnet-101-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-101-0.125/$2/octave-resnet-101-0.125.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/octave-resnet-101-0.125/$2/octave-resnet-101-0.125.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnet-101-0.125/$2/octave-resnet-101-0.125.xml
		;;
		"28")
			echo " octave-resnet-200-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-200-0.125/$2/octave-resnet-200-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnet-200-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-200-0.125/$2/octave-resnet-200-0.125.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/octave-resnet-200-0.125/$2/octave-resnet-200-0.125.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnet-200-0.125/$2/octave-resnet-200-0.125.xml
		;;
		"29")
			echo " octave-resnet-26-0.25.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-26-0.25/$2/octave-resnet-26-0.25.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnet-26-0.25 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-26-0.25/$2/octave-resnet-26-0.25.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/octave-resnet-26-0.25/$2/octave-resnet-26-0.25.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnet-26-0.25/$2/octave-resnet-26-0.25.xml
		;;
		"30")
			echo " octave-resnet-50-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-50-0.125/$2/octave-resnet-50-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnet-50-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/octave-resnet-50-0.125/$2/octave-resnet-50-0.125.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/octave-resnet-50-0.125/$2/octave-resnet-50-0.125.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnet-50-0.125/$2/octave-resnet-50-0.125.xml
		;;
		"31")
			echo " octave-resnext-101-0.25.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnext-101-0.25/$2/octave-resnext-101-0.25.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnext-101-0.25 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/octave-resnext-101-0.25/$2/octave-resnext-101-0.25.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/octave-resnext-101-0.25/$2/octave-resnext-101-0.25.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnext-101-0.25/$2/octave-resnext-101-0.25.xml
		;;
		"32")
			echo " octave-resnext-50-0.25.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-resnext-50-0.25/$2/octave-resnext-50-0.25.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-resnext-50-0.25 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/octave-resnext-50-0.25/$2/octave-resnext-50-0.25.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/octave-resnext-50-0.25/$2/octave-resnext-50-0.25.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-resnext-50-0.25/$2/octave-resnext-50-0.25.xml
		;;
		"33")
			echo " octave-se-resnet-50-0.125.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/octave-se-resnet-50-0.125/$2/octave-se-resnet-50-0.125.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=octave-se-resnet-50-0.125 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/octave-se-resnet-50-0.125/$2/octave-se-resnet-50-0.125.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/octave-se-resnet-50-0.125/$2/octave-se-resnet-50-0.125.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/octave-se-resnet-50-0.125/$2/octave-se-resnet-50-0.125.xml
		;;
		"34")
			echo " resnet-101.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/resnet-101/$2/resnet-101.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=resnet-101 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/resnet-101/$2/resnet-101.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/resnet-101/$2/resnet-101.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/resnet-101/$2/resnet-101.xml
		;;
		"35")
			echo " resnet-152.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/resnet-152/$2/resnet-152.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=resnet-152 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/resnet-152/$2/resnet-152.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/resnet-152/$2/resnet-152.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/resnet-152/$2/resnet-152.xml
		;;
		"36")
			echo " resnet-50.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/resnet-50/$2/resnet-50.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=resnet-50 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/resnet-50/$2/resnet-50.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/resnet-50/$2/resnet-50.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/resnet-50/$2/resnet-50.xml
		;;
		"37")
			echo " resnet-50-pytorch.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/resnet-50-pytorch/$2/resnet-50-pytorch.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=resnet-50-pytorch --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/resnet-50-pytorch/$2/resnet-50-pytorch.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/resnet-50-pytorch/$2/resnet-50-pytorch.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/resnet-50-pytorch/$2/resnet-50-pytorch.xml
		;;
		"38")
			echo " se-inception.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-inception/$2/se-inception.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-inception --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/se-inception/$2/se-inception.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/se-inception/$2/se-inception.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-inception/$2/se-inception.xml
		;;
		"39")
			echo " se-resnet-101.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-101/$2/se-resnet-101.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnet-101 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-101/$2/se-resnet-101.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/se-resnet-101/$2/se-resnet-101.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnet-101/$2/se-resnet-101.xml
		;;
		"40")
			echo " se-resnet-152.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-152/$2/se-resnet-152.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnet-152 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-152/$2/se-resnet-152.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/se-resnet-152/$2/se-resnet-152.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnet-152/$2/se-resnet-152.xml
		;;
		"41")
			echo " se-resnet-50.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-50/$2/se-resnet-50.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnet-50 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/se-resnet-50/$2/se-resnet-50.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/se-resnet-50/$2/se-resnet-50.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnet-50/$2/se-resnet-50.xml
		;;
		"42")
			echo " se-resnext-101.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnext-101/$2/se-resnext-101.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnext-101 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/se-resnext-101/$2/se-resnext-101.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/se-resnext-101/$2/se-resnext-101.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnext-101/$2/se-resnext-101.xml
		;;
		"43")
			echo " se-resnext-50.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/se-resnext-50/$2/se-resnext-50.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=se-resnext-50 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/se-resnext-50/$2/se-resnext-50.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/se-resnext-50/$2/se-resnext-50.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/se-resnext-50/$2/se-resnext-50.xml
		;;
		"44")
			echo " squeezenet1.0.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/squeezenet1.0/$2/squeezenet1.0.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=squeezenet1.0 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/squeezenet1.0/$2/squeezenet1.0.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/squeezenet1.0/$2/squeezenet1.0.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/squeezenet1.0/$2/squeezenet1.0.xml
		;;
		"45")
			echo " squeezenet1.1.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/squeezenet1.1/$2/squeezenet1.1.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=squeezenet1.1 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/squeezenet1.1/$2/squeezenet1.1.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/squeezenet1.1/$2/squeezenet1.1.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/squeezenet1.1/$2/squeezenet1.1.xml
		;;
		"46")
			echo " vgg16.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/vgg16/$2/vgg16.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=vgg16 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/vgg16/$2/vgg16.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/vgg16/$2/vgg16.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/vgg16/$2/vgg16.xml
		;;
		"47")
			echo " vgg19.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/vgg19/$2/vgg19.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=vgg19 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/vgg19/$2/vgg19.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/vgg19/$2/vgg19.labels )
			MODEL_0_LOC=${MODEL_LOC}/../../ir/public/vgg19/$2/vgg19.xml
		;;
		"48")
			echo " Sphereface.xml [$2] ->"
			test -e ${MODEL_LOC}/../../ir/public/Sphereface/$2/Sphereface.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=Sphereface --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=$2  )
			test -e ${MODEL_LOC}/../../ir/public/Sphereface/$2/Sphereface.labels  || ( echo "> copy ImageNet Labels"; cp -r $label_path/ImageNet/ImageNet.labels ${MODEL_LOC}/../../ir/public/Sphereface/$2/Sphereface.labels )
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
function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}

function source_choose()
{
	echo " >> input \"0\" for using dafault inference source, or typein the path to the source you want."
	read I_SOURCE
	case $I_SOURCE in
		"0")
			echo " car.png [Default] ->"
			I_SOURCE=/opt/intel/openvino/deployment_tools/demo/car.png
		;;
		*)
			echo " Model PATH=${I_SOURCE}"
			;;
	esac
}

function set_default()
{
	echo " All model will run on CPU... "
	MODEL_0_LOC=${MODEL_LOC}/../../ir/public/squeezenet1.1/FP32/squeezenet1.1.xml
	I_SOURCE="/opt/intel/openvino/deployment_tools/demo/car.png"
	TARGET_0="CPU"
}

function set_others()
{
	inference_D_choose
	source_choose
}

function model_0_choose()
{
	model_list
	read choose
	if [ $choose == "0" ]; then
		set_default
		test_models 45 FP16
	else
		set_default
		echo " >> input your data type, support \"FP32\" and \"FP16\" "
		read fpchoose
		test_models $choose $fpchoose
		set_others
	fi
	
}
clear
banner_show
echo "With ASYNC Demo ??(Y/n) >>"
read ASYNC
if [ $ASYNC == "N" ]||[ $ASYNC == "n" ]; then
	echo "Select Image Classification Model >>>"
else
	echo "> [ASYNC API] Select Image Classification Model >>>"
fi

model_0_choose
ARGS=" -m ${MODEL_0_LOC} -i ${I_SOURCE} -d ${TARGET_0}"


if [ $ASYNC == "N" ]||[ $ASYNC == "n" ]; then
	test -e $SAMPLE_LOC/python_samples/classification_sample/classification_sample.py || cp -r /opt/intel/openvino/inference_engine/samples/python_samples $SAMPLE_LOC
	echo "RUN python3 $SAMPLE_LOC/python_samples/classification_sample/classification_sample.py $ARGS"
	python3 $SAMPLE_LOC/python_samples/classification_sample/classification_sample.py $ARGS
else
	echo "RUN $SAMPLE_LOC/classification_sample_async $ARGS"
	$SAMPLE_LOC/classification_sample_async $ARGS
fi
