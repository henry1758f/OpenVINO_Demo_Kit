#!/bin/bash
# File: face_recognition_demo.sh
# 2019/10/28	henry1758f 0.0.1	First Create

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."
cpu_ext_path="/opt/intel/openvino/inference_engine/lib/intel64/libcpu_extension_avx2.so"
face_lib_path="$HOME/Pictures/face_gallery"

function banner_show()
{
	echo "|=========================================|"
	echo "|          face_recognition_demo          |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a Face Detection model.]"
	echo " >> 1. face-detection-adas-0001 	[FP32]"
	echo " >> 2. face-detection-adas-0001 	[FP16]"
	echo " >> 3. face-detection-adas-0001 	[INT8]"
	echo " >> 4. face-detection-adas-0001 	[INT1]"
	echo " >> 5. face-detection-retail-0004 	[FP32]"
	echo " >> 6. face-detection-retail-0004 	[FP16]"
	echo " >> 7. face-detection-retail-0004 	[INT8]"
	echo " >> 8. face-detection-retail-0005 	[FP32]"
	echo " >> 9. face-detection-retail-0005 	[FP16]"
	echo " >>10. face-detection-retail-0005 	[INT8]"
	echo " >>11. face-detection-retail-0044 	[FP32]"
	echo " >>12. face-detection-retail-0044 	[FP16]"
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " face-detection-adas-0001 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-0001/FP32/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"2")
			echo " face-detection-adas-0001 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-0001/FP16/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"3")
			echo " face-detection-adas-0001 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-0001/INT8/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"4")
			echo " face-detection-adas-0001 	[INT1] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-adas-binary-0001/INT1/face-detection-adas-binary-0001.xml
			inference_D_choose
		;;
		"5")
			echo " face-detection-retail-0004 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0004/FP32/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"6")
			echo " face-detection-retail-0004 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0004/FP16/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"7")
			echo " face-detection-retail-0004 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0004/INT8/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"8")
			echo " face-detection-retail-0005 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0005/FP32/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"9")
			echo " face-detection-retail-0005 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0005/FP16/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"10")
			echo " face-detection-retail-0005 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0005/INT8/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"11")
			echo " face-detection-retail-0044.xml [FP32] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-detection-retail-0044/FP32/face-detection-retail-0044.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-detection-retail-0044 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=FP32  )
			MODEL_LOC_0=${MODEL_LOC}/../../ir/public/face-detection-retail-0044/FP32/face-detection-retail-0044.xml
			inference_D_choose
		;;
		"12")
			echo " face-detection-retail-0044.xml [FP16] ->"
			test -e ${MODEL_LOC}/../../ir/public/face-detection-retail-0044/FP16/face-detection-retail-0044.xml  || ( echo "[Run Model Optimizer Demo]" && 	python3 $converter_path --name=face-detection-retail-0044 --download_dir $MODEL_LOC --output_dir $MODEL_LOC/../../ir --precisions=FP16  )
			MODEL_LOC_0=${MODEL_LOC}/../../ir/public/face-detection-retail-0044/FP16/face-detection-retail-0044.xml
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
function inference_D1_choose()
{
	echo "$select_inf"
	read TARGET_1
	MODEL_LOC_1="${MODEL_LOC_1} -d_lm ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Person Attributes recognition model.]"
	echo " >> 1. landmarks-regression-retail-0009.xml 	[FP32] "
	echo " >> 2. landmarks-regression-retail-0009.xml 	[FP16] "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " landmarks-regression-retail-0009.xml 	[FP32] ->"
			MODEL_LOC_1="-m_lm ${MODEL_LOC}/intel/landmarks-regression-retail-0009/FP32/landmarks-regression-retail-0009.xml"
			inference_D1_choose
		;;
		"2")
			echo " landmarks-regression-retail-0009.xml 	[FP16] ->"
			MODEL_LOC_1="-m_lm ${MODEL_LOC}/intel/landmarks-regression-retail-0009/FP16/landmarks-regression-retail-0009.xml"
			inference_D1_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_1="-m_lm ${choose}"
			inference_D1_choose
			;;
	esac
}

function inference_D2_choose()
{
	echo "$select_inf"
	read TARGET_2
	MODEL_LOC_2="${MODEL_LOC_2} -d_reid ${TARGET_2}"
}
function model_2_choose()
{
	echo " [Select a Person Reidentification model.]"
	echo " >> 1. face-reidentification-retail-0095.xml 	[FP32] "
	echo " >> 2. face-reidentification-retail-0095.xml 	[FP16] "
	echo " >> Or input a path to your model "

	local choose
	read choose
	case $choose in
		"1")
			echo " face-reidentification-retail-0095.xml 	[FP32] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/intel/face-reidentification-retail-0095/FP32/face-reidentification-retail-0095.xml"
			inference_D2_choose
		;;
		"2")
			echo " face-reidentification-retail-0095.xml 	[FP16] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/intel/face-reidentification-retail-0095/FP16/face-reidentification-retail-0095.xml"
			inference_D2_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_2="-m_reid ${choose}"
			inference_D2_choose
			;;
	esac
}

function source_choose()
{
	echo " >> input the Path to the input video ('0' for the camera, default)"
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
	MODEL_LOC_0=${MODEL_LOC}/intel/face-detection-retail-0004/FP32/face-detection-retail-0004.xml
	MODEL_LOC_1="-m_lm ${MODEL_LOC}/intel/landmarks-regression-retail-0009/FP32/landmarks-regression-retail-0009.xml"
	MODEL_LOC_2="-m_reid ${MODEL_LOC}/intel/face-reidentification-retail-0095/FP32/face-reidentification-retail-0095.xml"

	I_SOURCE=0
	TARGET_0="CPU"
}
function set_others()
{
	model_1_choose
	model_2_choose
	source_choose
}
function set_gallery()
{
	echo " input the path of the face gallery, or input \"0\" for default location... "
	echo "  (default : ${face_lib_path} )"
	echo " >> "
	read choose
	if [ $choose == "0" ];then
		test -e ${face_lib_path} || mkdir ${face_lib_path}
		face_lib_path="-fg $face_lib_path"
		retuen 0
	else
		face_lib_path="-fg $choose"
	fi
}
clear
banner_show

set_default
model_0_choose && set_others
set_gallery

ARGS=" -m_fd ${MODEL_LOC_0} ${MODEL_LOC_1} ${MODEL_LOC_2} -i ${I_SOURCE} -d_fd ${TARGET_0} -l ${cpu_ext_path} --verbose ${face_lib_path}"
test -e $DEMO_LOC/python_demos/face_recognition_demo/face_recognition_demo.py || cp -r /opt/intel/openvino/inference_engine/demos/python_demos $DEMO_LOC
echo "RUN $DEMO_LOC/python_demos/face_recognition_demo/face_recognition_demo.py $ARGS"
python3 $DEMO_LOC/python_demos/face_recognition_demo/face_recognition_demo.py $ARGS
