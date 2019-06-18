# File: classification_demo.sh
# 2019/05/08	henry1758f 0.0.1	First Create
# 2019/05/09	henry1758f 1.0.0	workable
# 2019/06/04	henry1758f 1.1.0	add squeezenet1.0 and labels file copy process
# 2019/06/11	henry1758f 1.1.1	add densenet201/169/161
# 2019/06/18	henry1758f 1.1.2	add googlenetv1/v2/v4,Inceptionv3

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=/home/$(whoami)/openvino_models/models/SYNNEX_demo

export squeezenet11="${MODEL_LOC}/../../ir/FP32/classification/squeezenet/1.1/caffe"
export squeezenet11_fp16="${MODEL_LOC}/../../ir/FP16/classification/squeezenet/1.1/caffe"
export squeezenet10="${MODEL_LOC}/../../ir/FP32/classification/squeezenet/1.0/caffe"
export squeezenet10_fp16="${MODEL_LOC}/../../ir/FP16/classification/squeezenet/1.0/caffe"
export alexnet="${MODEL_LOC}/../../ir/FP32/classification/alexnet/caffe"
export alexnet_fp16="${MODEL_LOC}/../../ir/FP16/classification/alexnet/caffe"
export densenet201="${MODEL_LOC}/../../ir/FP32/classification/densenet/201/caffe"
export densenet201_fp16="${MODEL_LOC}/../../ir/FP16/classification/densenet/201/caffe"
export densenet169="${MODEL_LOC}/../../ir/FP32/classification/densenet/169/caffe"
export densenet169_fp16="${MODEL_LOC}/../../ir/FP16/classification/densenet/169/caffe"
export densenet161="${MODEL_LOC}/../../ir/FP32/classification/densenet/161/caffe"
export densenet161_fp16="${MODEL_LOC}/../../ir/FP16/classification/densenet/161/caffe"
export densenet121="${MODEL_LOC}/../../ir/FP32/classification/densenet/121/caffe"
export densenet121_fp16="${MODEL_LOC}/../../ir/FP16/classification/densenet/121/caffe"
export googlenetv1="${MODEL_LOC}/../../ir/FP32/classification/googlenet/v1/caffe"
export googlenetv1_fp16="${MODEL_LOC}/../../ir/FP16/classification/googlenet/v1/caffe"
export googlenetv2="${MODEL_LOC}/../../ir/FP32/classification/googlenet/v2/caffe"
export googlenetv2_fp16="${MODEL_LOC}/../../ir/FP16/classification/googlenet/v2/caffe"
export googlenetv3="${MODEL_LOC}/../../ir/FP32/classification/googlenet/v3/tf"
export googlenetv3_fp16="${MODEL_LOC}/../../ir/FP16/classification/googlenet/v3/tf"
export googlenetv4="${MODEL_LOC}/../../ir/FP32/classification/googlenet/v4/caffe"
export googlenetv4_fp16="${MODEL_LOC}/../../ir/FP16/classification/googlenet/v4/caffe"

function banner_show()
{
	echo "|=========================================|"
	echo "|        Image Classification Demo        |"
	echo "|=========================================|"
}

function model_0_choose()
{
	test -e ${squeezenet11}/squeezenet1.1.xml && echo " 1. squeezenet1.1.xml [FP32]" || echo " 1. squeezenet1.1.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${squeezenet11_fp16}/squeezenet1.1.xml && echo " 2. squeezenet1.1.xml [FP16]" || echo " 2. squeezenet1.1.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${squeezenet10}/squeezenet1.0.xml && echo " 3. squeezenet1.0.xml [FP32]" || echo " 3. squeezenet1.0.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${squeezenet10_fp16}/squeezenet1.0.xml && echo " 4. squeezenet1.0.xml [FP16]" || echo " 4. squeezenet1.0.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${alexnet}/alexnet.xml && echo " 5. alexnet.xml [FP32]" || echo " 5. alexnet.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${alexnet_fp16}/alexnet.xml && echo " 6. alexnet.xml [FP16]" || echo " 6. alexnet.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${densenet201}/densenet-201.xml && echo " 7. densenet-201.xml [FP32]" || echo " 7. densenet-201.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${densenet201_fp16}/densenet-201.xml && echo " 8. densenet-201.xml [FP16]" || echo " 8. densenet-201.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${densenet169}/densenet-169.xml && echo " 9. densenet-169.xml [FP32]" || echo " 9. densenet-169.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${densenet169_fp16}/densenet-169.xml && echo "10. densenet-169.xml [FP16]" || echo "10. densenet-169.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${densenet161}/densenet-161.xml && echo "11. densenet-161.xml [FP32]" || echo "11. densenet-161.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${densenet161_fp16}/densenet-161.xml && echo "12 . densenet-161.xml [FP16]" || echo "12. densenet-161.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${densenet121}/densenet-121.xml && echo "13. densenet-121.xml [FP32]" || echo "13. densenet-121.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${densenet121_fp16}/densenet-121.xml && echo "14. densenet-121.xml [FP16]" || echo "14. densenet-121.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${googlenetv1}/googlenet-v1.xml && echo "15. googlenet-v1.xml [FP32]" || echo "15. googlenet-v1.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${googlenetv1_fp16}/googlenet-v1.xml && echo "16. googlenet-v1.xml [FP16]" || echo "16. googlenet-v1.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${googlenetv2}/googlenet-v2.xml && echo "17. googlenet-v2.xml [FP32]" || echo "17. googlenet-v2.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${googlenetv2_fp16}/googlenet-v2.xml && echo "18. googlenet-v2.xml [FP16]" || echo "18. googlenet-v2.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${googlenetv3}/inception_v3_2016_08_28_frozen.xml && echo "19. inception_v3.xml [FP32]" || echo "19. googlenet-v3.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${googlenetv3_fp16}/inception_v3_2016_08_28_frozen.xml && echo "20. inception_v3.xml [FP16]" || echo "20. googlenet-v3.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${googlenetv4}/googlenet-v4.xml && echo "21. googlenet-v4.xml [FP32]" || echo "21. googlenet-v4.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${googlenetv4_fp16}/googlenet-v4.xml && echo "22. googlenet-v4.xml [FP16]" || echo "22. googlenet-v4.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/inception-resnet/v2/tf/inception-resnet-v2.xml && echo "23. inception-resnet-v2.xml [FP32]" || echo "23. inception-resnet-v2.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/inception-resnet/v2/tf/inception-resnet-v2.xml && echo "24. inception-resnet-v2.xml [FP16]" || echo "24. inception-resnet-v2.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/mobilenet/v1/1.0/224/cf/mobilenet-v1-1.0-224.xml && echo "24. mobilenet-v1-1.0-224.xml [FP32]" || echo "25. mobilenet-v1-1.0-224.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/mobilenet/v1/1.0/224/cf/mobilenet-v1-1.0-224.xml && echo "26. mobilenet-v1-1.0-224.xml [FP16]" || echo "26. mobilenet-v1-1.0-224.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/mobilenet/v2/cf/mobilenet-v2.xml && echo "27. mobilenet-v2.xml [FP32]" || echo "27. mobilenet-v2.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/mobilenet/v2/cf/mobilenet-v2.xml && echo "28. mobilenet-v2.xml [FP16]" || echo "28. mobilenet-v2.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/mobilenet/v2/tf/mobilenet-v2-1.4-224/mobilenet-v2-1.4-224.frozen.xml && echo "29. mobilenet-v2-1.4-224.frozen.xml [FP32]" || echo "29. mobilenet-v2-1.4-224.frozen.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/mobilenet/v2/tf/mobilenet-v2-1.4-224/mobilenet-v2-1.4-224.frozen.xml && echo "30. mobilenet-v2-1.4-224.frozen.xml [FP16]" || echo "30. mobilenet-v2-1.4-224.frozen.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/se-networks/se-inception/caffe/se-inception.xml && echo "31. se-inception.xml [FP32]" || echo "31. se-inception.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/se-networks/se-inception/caffe/se-inception.xml && echo "32. se-inception.xml [FP16]" || echo "32. se-inception.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/se-networks/se-resnet-50/caffe/se-resnet-50.xml && echo "33. se-resnet-50.xml [FP32]" || echo "33. se-resnet-50.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/se-networks/se-resnet-50/caffe/se-resnet-50.xml && echo "34. se-resnet-50.xml [FP16]" || echo "34. se-resnet-50.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/se-networks/se-resnet-101/caffe/se-resnet-101.xml && echo "35. se-resnet-101.xml [FP32]" || echo "35. se-resnet-101.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/se-networks/se-resnet-101/caffe/se-resnet-101.xml && echo "36. se-resnet-101.xml [FP16]" || echo "36. se-resnet-101.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/se-networks/se-resnet-152/caffe/se-resnet-152.xml && echo "37. se-resnet-152.xml [FP32]" || echo "37. se-resnet-152.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/se-networks/se-resnet-152/caffe/se-resnet-152.xml && echo "38. se-resnet-152.xml [FP16]" || echo "38. se-resnet-152.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/se-networks/se-resnext-50/caffe/se-resnext-50.xml && echo "39. se-resnext-50.xml [FP32]" || echo "39. se-resnext-50.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/se-networks/se-resnext-50/caffe/se-resnext-50.xml && echo "40. se-resnext-50.xml [FP16]" || echo "40. se-resnext-50.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/se-networks/se-resnext-101/caffe/se-resnext-101.xml && echo "41. se-resnext-101.xml [FP32]" || echo " 41. se-resnext-101.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/se-networks/se-resnext-101/caffe/se-resnext-101.xml && echo "42. se-resnext-101.xml [FP16]" || echo " 42. se-resnext-101.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/vgg/16/caffe/vgg16.xml && echo "43. vgg16.xml [FP32]" || echo "43. vgg16.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/vgg/16/caffe/vgg16.xml && echo "44. vgg16.xml [FP16]" || echo "44. vgg16.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP32/classification/vgg/19/caffe/vgg19.xml && echo "45. vgg19.xml [FP32]" || echo "45. vgg19.xml [FP32]	File lost! Need to Download and Transfer to IR)"
	test -e ${MODEL_LOC}/../../ir/FP16/classification/vgg/19/caffe/vgg19.xml && echo "46. vgg19.xml [FP16]" || echo "46. vgg19.xml [FP16]	File lost! Need to Download and Transfer to IR)"
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " squeezenet1.1.xml [FP32] ->"
			test -e ${squeezenet11}/squeezenet1.1.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m squeezenet1.1.caffemodel -fp32 && cp -r ./Source/labels/squeezenet_11/squeezenet1.1.labels ${squeezenet11})
			MODEL_LOC=${squeezenet11}/squeezenet1.1.xml
		;;
		"2")
			echo " squeezenet1.1.xml [FP16] ->"
			test -e ${squeezenet11_fp16}/squeezenet1.1.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m squeezenet1.1.caffemodel -fp16 && cp -r ./Source/labels/squeezenet_11/squeezenet1.1.labels ${squeezenet11_fp16})
			MODEL_LOC=${squeezenet11_fp16}/squeezenet1.1.xml
		;;
		"3")
			echo " squeezenet1.0.xml [FP32] ->"
			test -e ${squeezenet10}/squeezenet1.0.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m squeezenet1.0.caffemodel -fp32 && cp -r ./Source/labels/squeezenet_10/squeezenet1.0.labels ${squeezenet10})
			MODEL_LOC=${squeezenet10}/squeezenet1.0.xml
		;;
		"4")
			echo " squeezenet1.0.xml [FP16] ->"
			test -e ${squeezenet10_fp16}/squeezenet1.0.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m squeezenet1.0.caffemodel -fp16 && cp -r ./Source/labels/squeezenet_10/squeezenet1.0.labels ${squeezenet10_fp16})
			MODEL_LOC=${squeezenet10_fp16}/squeezenet1.0.xml
		;;
		"5")
			echo " alexnet.xml [FP32] ->"
			test -e ${alexnet}/alexnet.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m alexnet.caffemodel -fp32 && cp -r ./Source/labels/alexnet/alexnet.labels ${alexnet})
			MODEL_LOC=${alexnet}/alexnet.xml
		;;
		"6")
			echo " alexnet.xml [FP16] ->"
			test -e ${alexnet_fp16}/alexnet.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m alexnet.caffemodel -fp16 && cp -r ./Source/labels/alexnet/alexnet.labels ${alexnet_fp16})
			MODEL_LOC=${alexnet_fp16}/alexnet.xml
		;;
		"7")
			echo " densenet-201.xml [FP32] ->"
			test -e ${densenet201}/densenet-201.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-201.caffemodel -fp32 && cp -r ./Source/labels/densenet/densenet-201.labels ${densenet201})
			MODEL_LOC=${densenet201}/densenet-201.xml
		;;
		"8")
			echo " densenet-201.xml [FP16] ->"
			test -e ${densenet201_fp16}/densenet-201.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-201.caffemodel -fp16 && cp -r ./Source/labels/densenet/densenet-201.labels ${densenet201_fp16})
			MODEL_LOC=${densenet201_fp16}/densenet-201.xml
		;;
		"9")
			echo " densenet-169.xml [FP32] ->"
			test -e ${densenet169}/densenet-169.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-169.caffemodel -fp32 && cp -r ./Source/labels/densenet/densenet-169.labels ${densenet169})
			MODEL_LOC=${densenet169}/densenet-169.xml
		;;
		"10")
			echo " densenet-169.xml [FP16] ->"
			test -e ${densenet169_fp16}/densenet-169.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-169.caffemodel -fp16 && cp -r ./Source/labels/densenet/densenet-169.labels ${densenet169_fp16})
			MODEL_LOC=${densenet169_fp16}/densenet-169.xml
		;;
		"11")
			echo " densenet-161.xml [FP32] ->"
			test -e ${densenet161}/densenet-161.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-161.caffemodel -fp32 && cp -r ./Source/labels/densenet/densenet-161.labels ${densenet161})
			MODEL_LOC=${densenet161}/densenet-161.xml
		;;
		"12")
			echo " densenet-161.xml [FP16] ->"
			test -e ${densenet161_fp16}/densenet-161.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-161.caffemodel -fp16 && cp -r ./Source/labels/densenet/densenet-161.labels ${densenet161_fp16})
			MODEL_LOC=${densenet161_fp16}/densenet-161.xml
		;;
		"13")
			echo " densenet-121.xml [FP32] ->"
			test -e ${densenet121}/densenet-121.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-121.caffemodel -fp32 && cp -r ./Source/labels/densenet/densenet-121.labels ${densenet121})
			MODEL_LOC=${densenet121}/densenet-121.xml
		;;
		"14")
			echo " densenet-121.xml [FP16] ->"
			test -e ${densenet121_fp16}/densenet-121.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m densenet-121.caffemodel -fp16 && cp -r ./Source/labels/densenet/densenet-121.labels ${densenet121_fp16})
			MODEL_LOC=${densenet121_fp16}/densenet-121.xml
		;;
		"15")
			echo " googlenet-v1.xml [FP32] ->"
			test -e ${googlenetv1}/googlenet-v1.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v1.caffemodel -fp32 && cp -r ./Source/labels/googlenet/googlenet-v1.labels ${googlenetv1})
			MODEL_LOC=${googlenetv1}/googlenet-v1.xml
		;;
		"16")
			echo " googlenet-v1.xml [FP16] ->"
			test -e ${googlenetv1_fp16}/googlenet-v1.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v1.caffemodel -fp16 && cp -r ./Source/labels/googlenet/googlenet-v1.labels ${googlenetv1_fp16})
			MODEL_LOC=${googlenetv1_fp16}/googlenet-v1.xml
		;;
		"17")
			echo " googlenet-v2.xml [FP32] ->"
			test -e ${googlenetv2}/googlenet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v2.caffemodel -fp32 && cp -r ./Source/labels/googlenet/googlenet-v2.labels ${googlenetv2})
			MODEL_LOC=${googlenetv2}/googlenet-v2.xml
		;;
		"18")
			echo " googlenet-v2.xml [FP16] ->"
			test -e ${googlenetv2_fp16}/googlenet-v2.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v2.caffemodel -fp16 && cp -r ./Source/labels/googlenet/googlenet-v2.labels ${googlenetv2_fp16})
			MODEL_LOC=${googlenetv2_fp16}/googlenet-v2.xml
		;;
		"19")
			echo " googlenet-v3.xml [FP32] ->"
			test -e ${googlenetv3}/inception_v3_2016_08_28_frozen.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v3.frozen.pb -fp32 && cp -r ./Source/labels/googlenet/inception_v3_2016_08_28_frozen.labels ${googlenetv3})
			MODEL_LOC=${googlenetv3}/inception_v3_2016_08_28_frozen.xml
		;;
		"20")
			echo " googlenet-v3.xml [FP16] ->"
			test -e ${googlenetv3_fp16}/inception_v3_2016_08_28_frozen.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v3.frozen.pb -fp16 && cp -r ./Source/labels/googlenet/inception_v3_2016_08_28_frozen.labels ${googlenetv3_fp16})
			MODEL_LOC=${googlenetv3_fp16}/inception_v3_2016_08_28_frozen.xml
		;;
		"21")
			echo " googlenet-v4.xml [FP32] ->"
			test -e ${googlenetv4}/googlenet-v4.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v4.caffemodel -fp32 && cp -r ./Source/labels/googlenet/googlenet-v4.labels ${googlenetv4})
			MODEL_LOC=${googlenetv4}/googlenet-v4.xml
		;;
		"22")
			echo " googlenet-v4.xml [FP16] ->"			
			test -e ${googlenetv4_fp16}/googlenet-v4.xml  || ( echo "[Run Model Optimizer Demo]" && ./Source/mo_dldt.sh -m googlenet-v4.caffemodel -fp16 && cp -r ./Source/labels/googlenet/googlenet-v4.labels ${googlenetv4_fp16})
			MODEL_LOC=${googlenetv4_fp16}/googlenet-v4.xml
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

clear
banner_show
echo "With ASYNC Demo ??(Y/n) >>"
read ASYNC
case $ASYNC in
		"Y")
			echo "[ASYNC API] Select Image Classification Model >>>"
			model_0_choose
			inference_D_choose
			source_choose
			cd $SAMPLE_LOC
			./classification_sample_async -m ${MODEL_LOC} -i ${I_SOURCE} -d ${TARGET_0}
		;;
		*)
			echo "Select Image Classification Model >>>"
			model_0_choose
			inference_D_choose
			source_choose
			cd $SAMPLE_LOC
			./classification_sample -m ${MODEL_LOC} -i ${I_SOURCE} -d ${TARGET_0}
			;;
	esac

