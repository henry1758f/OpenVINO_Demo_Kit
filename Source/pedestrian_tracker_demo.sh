# File: pedestrian_tracker_demo.sh
# 2019/07/26	henry1758f 0.0.1	First Create
# 2019/07/26	henry1758f 1.0.0	Workable and Improved Output information 

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."

function banner_show()
{
	echo "|=========================================|"
	echo "|         Pedestrian tracker demo         |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a Pedestrian Detection Retail model]"
	echo " >> 1. person-detection-retail-0013.xml 	[FP32] "
	echo " >> 2. person-detection-retail-0013.xml 	[FP16] "
	echo " >> 3. person-detection-retail-0013.xml 	[INT8] "
	echo " >> 4. person-detection-retail-0002.xml 	[FP32] "
	echo " >> 5. person-detection-retail-0002.xml 	[FP16] "

	echo " >> 6. pedestrian-detection-adas-0002.xml 	[FP32] "
	echo " >> 7. pedestrian-detection-adas-0002.xml 	[FP16] "
	echo " >> 8. pedestrian-detection-adas-0002.xml 	[INT8] "
	echo " >> 9. pedestrian-detection-adas-0002.xml 	[INT1] "
	echo " >> 10. pedestrian-and-vehicle-detector-adas-0001.xml 	[FP32] "
	echo " >> 11. pedestrian-and-vehicle-detector-adas-0001.xml 	[FP16] "

	echo " >> 12. person-vehicle-bike-detection-crossroad-0078.xml 	[FP32] "
	echo " >> 13. person-vehicle-bike-detection-crossroad-0078.xml 	[FP16] "
	echo " >> 14. person-vehicle-bike-detection-crossroad-0078.xml 	[INT8] "
	echo " >> 15. person-vehicle-bike-detection-crossroad-1016.xml 	[FP32] "
	echo " >> 16. person-vehicle-bike-detection-crossroad-1016.xml 	[FP16] "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " person-detection-retail-0013.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/pedestrian/rmnet_ssd/0013/dldt/FP32/person-detection-retail-0013.xml
			inference_D_choose
		;;
		"2")
			echo " person-detection-retail-0013.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/pedestrian/rmnet_ssd/0013/dldt/FP16/person-detection-retail-0013.xml
			inference_D_choose
		;;
		"3")
			echo " person-detection-retail-0013.xml 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/pedestrian/rmnet_ssd/0013/dldt/INT8/person-detection-retail-0013.xml
			inference_D_choose
		;;
		"4")
			echo " person-detection-retail-0002.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/pedestrian/hypernet-rfcn/0026/dldt/FP32/person-detection-retail-0002.xml
			inference_D_choose
		;;
		"5")
			echo " person-detection-retail-0002.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/pedestrian/hypernet-rfcn/0026/dldt/FP16/person-detection-retail-0002.xml
			inference_D_choose
		;;

		"6")
			echo " pedestrian-detection-adas-0002.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/pedestrian/mobilenet-reduced-ssd/dldt/FP32/pedestrian-detection-adas-0002.xml
			inference_D_choose
		;;
		"7")
			echo " pedestrian-detection-adas-0002.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/pedestrian/mobilenet-reduced-ssd/dldt/FP16/pedestrian-detection-adas-0002.xml
			inference_D_choose
		;;
		"8")
			echo " pedestrian-detection-adas-0002.xml 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/pedestrian/mobilenet-reduced-ssd/dldt/INT8/pedestrian-detection-adas-0002.xml
			inference_D_choose
		;;
		"9")
			echo " pedestrian-detection-adas-0002.xml 	[INT1] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/pedestrian/mobilenet-reduced-ssd-binary/dldt/INT1/pedestrian-detection-adas-binary-0001.xml
			inference_D_choose
		;;
		"10")
			echo " pedestrian-and-vehicle-detector-adas-0001.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/pedestrian-and-vehicle/mobilenet-reduced-ssd/dldt/FP32/pedestrian-and-vehicle-detector-adas-0001.xml
			inference_D_choose
		;;
		"11")
			echo " pedestrian-and-vehicle-detector-adas-0001.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/pedestrian-and-vehicle/mobilenet-reduced-ssd/dldt/FP16/pedestrian-and-vehicle-detector-adas-0001.xml
			inference_D_choose
		;;
		"12")
			echo " person-vehicle-bike-detection-crossroad-0078.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/FP32/person-vehicle-bike-detection-crossroad-0078.xml
			inference_D_choose
		;;
		"13")
			echo " person-vehicle-bike-detection-crossroad-0078.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/FP32/person-vehicle-bike-detection-crossroad-0078.xml
			inference_D_choose
		;;
		"14")
			echo " person-vehicle-bike-detection-crossroad-0078.xml 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/0078/dldt/INT8/person-vehicle-bike-detection-crossroad-0078.xml
			inference_D_choose
		;;
		"15")
			echo " person-vehicle-bike-detection-crossroad-1016.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/1016/dldt/FP32/person-vehicle-bike-detection-crossroad-1016.xml
			inference_D_choose
		;;
		"16")
			echo " person-vehicle-bike-detection-crossroad-1016.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Security/object_detection/crossroad/1016/dldt/FP16/person-vehicle-bike-detection-crossroad-1016.xml
			inference_D_choose
		;;

		"0")
			return 1
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
	echo " >> input \"0\" for download and using default Source, or typein the path to the source you want."
	read I_SOURCE
	case $I_SOURCE in
		"0")
			echo "Model PATH [Default]= /opt/intel/openvino/deployment_tools/demo/car_1.bmp"
			I_SOURCE=/opt/intel/openvino/deployment_tools/demo/car_1.bmp
		;;
		*)
			echo " Model PATH=${I_SOURCE}"
			;;
	esac
}

function inference_D1_choose()
{
	echo "$select_inf"
	read TARGET_1
	MODEL_LOC_1="${MODEL_LOC_1} -d_reid ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Person Reidentification model.]"
	echo " >> 1. person-reidentification-retail-0031.xml 	[FP32] "
	echo " >> 2. person-reidentification-retail-0031.xml 	[FP16] "
	echo " >> 3. person-reidentification-retail-0031.xml 	[INT8] "
	echo " >> 4. person-reidentification-retail-0076.xml 	[FP32] "
	echo " >> 5. person-reidentification-retail-0076.xml 	[FP16] "
	echo " >> 6. person-reidentification-retail-0076.xml 	[INT8] "
	echo " >> 7. person-reidentification-retail-0079.xml 	[FP32] "
	echo " >> 8. person-reidentification-retail-0079.xml 	[FP16] "
	echo " >> 9. person-reidentification-retail-0079.xml 	[INT8] "
	echo " >>10. input a path to your model "

	local choose
	read choose
	case $choose in
		"1")
			echo " person-reidentification-retail-0031.xml 	[FP32] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0031/dldt/FP32/person-reidentification-retail-0031.xml"
			inference_D2_choose
		;;
		"2")
			echo " person-reidentification-retail-0031.xml 	[FP16] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0031/dldt/FP16/person-reidentification-retail-0031.xml"
			inference_D2_choose
		;;
		"3")
			echo " person-reidentification-retail-0031.xml 	[INT8] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0031/dldt/INT8/person-reidentification-retail-0031.xml"
			inference_D2_choose
		;;
		"4")
			echo " person-reidentification-retail-0076.xml 	[FP32] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0076/dldt/FP32/person-reidentification-retail-0076.xml"
			inference_D2_choose
		;;
		"5")
			echo " person-reidentification-retail-0076.xml 	[FP16] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0076/dldt/FP16/person-reidentification-retail-0076.xml"
			inference_D2_choose
		;;
		"6")
			echo " person-reidentification-retail-0076.xml 	[INT8] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0076/dldt/INT8/person-reidentification-retail-0076.xml"
			inference_D2_choose
		;;
		"7")
			echo " person-reidentification-retail-0079.xml 	[FP32] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/FP32/person-reidentification-retail-0079.xml"
			inference_D2_choose
		;;
		"8")
			echo " person-reidentification-retail-0079.xml 	[FP16] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/FP16/person-reidentification-retail-0079.xml"
			inference_D2_choose
		;;
		"9")
			echo " person-reidentification-retail-0079.xml 	[INT8] ->"
			MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0079/dldt/INT8/person-reidentification-retail-0079.xml"
			inference_D2_choose
		;;
		"10")
			echo " PATH to your model ->"
			MODEL_LOC_1="-m_reid ${choose}"
			inference_D2_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_1="-m_reid ${choose}"
			inference_D_choose
		;;
	esac
}
function set_default()
{
	echo " All model will run on CPU... "
	MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/pedestrian/rmnet_ssd/0013/dldt/FP16/person-detection-retail-0013.xml
	MODEL_LOC_1="-m_reid ${MODEL_LOC}/Retail/object_reidentification/pedestrian/rmnet_based/0031/dldt/FP16/person-reidentification-retail-0031.xml"
	test -e $HOME/Pictures/sample-videos/people-detection.mp4 || git clone https://github.com/intel-iot-devkit/sample-videos.git $HOME/Pictures/
	test -e $HOME/Pictures/sample-videos/people-detection.mp4 || echo "[ERROR] Cannot find default source!"
	I_SOURCE="$HOME/Pictures/sample-videos/people-detection.mp4"
	TARGET_0="CPU"
}
function set_others()
{
	model_1_choose
	source_choose
}

clear
banner_show
model_0_choose && set_others || set_default	


cd $DEMO_LOC
ARGS=" -m_det ${MODEL_LOC_0} -i ${I_SOURCE} -d_det ${TARGET_0} ${MODEL_LOC_1} "
echo "RUN ./smart_classroom_demo $ARGS"
./pedestrian_tracker_demo $ARGS