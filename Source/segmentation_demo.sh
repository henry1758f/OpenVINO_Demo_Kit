# File: segmentation_demo.sh
# 2019/07/26	henry1758f 0.0.1	First Create
# 2019/07/25	henry1758f 1.0.0	Workable
export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
export USER_IMG_LOC=$HOME/Pictures/Test_Image
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."

function banner_show()
{
	echo "|=========================================|"
	echo "|         Image Segmentation Demo         |"
	echo "|=========================================|"
}

function model_0_choose()
{
	echo " [Select a Segmentation Models]"
	echo " >> 1. road-segmentation-adas-0001.xml 	[FP32]  >(Background, road, curb, mark) "
	echo " >> 2. road-segmentation-adas-0001.xml 	[FP16]  >(Background, road, curb, mark) "
	echo " >> 3. semantic-segmentation-adas-0001.xml 	[FP32]  >(road,sidewalk,building,wall,fence,pole,traffic light,traffic sign,vegetation,terrain,sky,person,rider,car,truck,bus,train,motorcycle,bicycle,ego-vehicle) "
	echo " >> 4. semantic-segmentation-adas-0001.xml 	[FP16]  >(road,sidewalk,building,wall,fence,pole,traffic light,traffic sign,vegetation,terrain,sky,person,rider,car,truck,bus,train,motorcycle,bicycle,ego-vehicle) "
	#echo " >> 5. instance-segmentation-security-0010.xml 	[FP32]  >(80 classes of objects) "
	#echo " >> 6. instance-segmentation-security-0010.xml 	[FP16]  >(80 classes of objects) "
	#echo " >> 7. instance-segmentation-security-0050.xml 	[FP32]  >(80 classes of objects) "
	#echo " >> 8. instance-segmentation-security-0050.xml 	[FP16]  >(80 classes of objects) "
	#echo " >> 9. instance-segmentation-security-0083.xml 	[FP32]  >(80 classes of objects) "
	#echo " >>10. instance-segmentation-security-0083.xml 	[FP16]  >(80 classes of objects) "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " road-segmentation-adas-0001.xml 	[FP32] ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/segmentation/curbs/dldt/FP32/road-segmentation-adas-0001.xml
		;;
		"2")
			echo " road-segmentation-adas-0001.xml 	[FP16] ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/segmentation/curbs/dldt/FP16/road-segmentation-adas-0001.xml
		;;
		"3")
			echo " semantic-segmentation-adas-0001.xml 	[FP32] ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/segmentation/semantic_segmentation/icnet_icv/dldt/FP32/semantic-segmentation-adas-0001.xml
		;;
		"4")
			echo " semantic-segmentation-adas-0001.xml 	[FP16] ->"
			MODEL_LOC=${MODEL_LOC}/Transportation/segmentation/semantic_segmentation/icnet_icv/dldt/FP16/semantic-segmentation-adas-0001.xml
		;;
#		"5")
#			echo " instance-segmentation-security-0010.xml 	[FP32] ->"
#			MODEL_LOC=${MODEL_LOC}/Security/instance_segmentation/common/0010/dldt/FP32/instance-segmentation-security-0010.xml
#		;;
#		"6")
#			echo " instance-segmentation-security-0010.xml 	[FP16] ->"
#			MODEL_LOC=${MODEL_LOC}/Security/instance_segmentation/common/0010/dldt/FPFP16/instance-segmentation-security-0010.xml
#		;;
#		"7")
#			echo " instance-segmentation-security-0050.xml 	[FP32] ->"
#			MODEL_LOC=${MODEL_LOC}/Security/instance_segmentation/common/0050/dldt/FP32/instance-segmentation-security-0050.xml
#		;;
#		"8")
#			echo " instance-segmentation-security-0050.xml 	[FP16] ->"
#			MODEL_LOC=${MODEL_LOC}/Security/instance_segmentation/common/0050/dldt/FP16/instance-segmentation-security-0050.xml
#		;;
#		"9")
#			echo " instance-segmentation-security-0083.xml 	[FP32] ->"
#			MODEL_LOC=${MODEL_LOC}/Security/instance_segmentation/common/0083/dldt/FP32/instance-segmentation-security-0083.xml
#		;;
#		"10")
#			echo " instance-segmentation-security-0083.xml 	[FP16] ->"
#			MODEL_LOC=${MODEL_LOC}/Security/instance_segmentation/common/0083/dldt/FP16/instance-segmentation-security-0083.xml
#		;;
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
	echo "$select_inf"
	read TARGET_0
}
function source_choose()
{
	echo " >> input \"0\" for download and using default image as inference source, or typein the path to the source you want."
	read I_SOURCE
}
function set_default()
{
	echo " All model will run on CPU... "
	MODEL_LOC=${MODEL_LOC}/Transportation/segmentation/semantic_segmentation/icnet_icv/dldt/FP32/semantic-segmentation-adas-0001.xml
	test -e $USER_IMG_LOC/640px-20180402_091550_KKA-2591.jpg || wget -P $USER_IMG_LOC https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/20180402_091550_KKA-2591.jpg/640px-20180402_091550_KKA-2591.jpg
	I_SOURCE=$USER_IMG_LOC/640px-20180402_091550_KKA-2591.jpg
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
xdg-open ${I_SOURCE}
ARGS=" -m ${MODEL_LOC} -i ${I_SOURCE} -d ${TARGET_0}"
echo "RUN ./segmentation_demo $ARGS"
./segmentation_demo $ARGS
echo " [INFO] Output Image had been saved as $HOME/Pictures/out_0.bmp"
cp -r out_0.bmp $HOME/Pictures/
rm out_0.bmp
xdg-open $HOME/Pictures/out_0.bmp