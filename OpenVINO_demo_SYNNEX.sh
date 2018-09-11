#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh
# ver 0.0.1
# This is design for connecting to the share folder on TWNB17034
# 2018/09/07 	henry1758	0.0.1 	first-create
#

export SAMPLE_LOC="/opt/intel/computer_vision_sdk/deployment_tools/inference_engine/samples/intel64/Release"
export MODEL_LOC="/opt/intel/computer_vision_sdk/deployment_tools/intel_models"
export SETVAR="/opt/intel/computer_vision_sdk/bin/setupvars.sh"
export VERSION="0.0.1"
export VERSION_VINO="v3.343"
function model_chooser_option_printer()
{
	echo "   1.  age-gender-recognition-retail-0013"
	echo "   2.  emotions-recognition-retail-0003"
	echo "   3.  face-detection-adas-0001"
	echo "   4.  face-detection-retail-0004"
	echo "   5.  face-person-detection-retail-0002"
	echo "   6.  face-reidentification-retail-0001"
	echo "   7.  head-pose-estimation-adas-0001"
	echo "   8.  landmarks-regression-retail-0001"
	echo "   9.  license-plate-recognition-barrier-0001"
	echo "   10. pedestrian-and-vehicle-detector-adas-0001"
	echo "   11. pedestrian-detection-adas-0002"
	echo "   12. person-attributes-recognition-crossroad-0031"
	echo "   13. person-detection-action-recognition-0001"
	echo "   14. person-detection-retail-0001"
	echo "   15. person-detection-retail-0013"
	echo "   16. person-reidentification-retail-0031"
	echo "   17. person-reidentification-retail-0076"
	echo "   18. person-reidentification-retail-0079"
	echo "   19. person-vehicle-bike-detection-crossroad-0078"
	echo "   20. road-segmentation-adas-0001"
	echo "   21. semantic-segmentation-adas-0001"
	echo "   22. vehicle-attributes-recognition-barrier-0039"
	echo "   23. vehicle-detection-adas-0002"
	echo "   24. vehicle-license-plate-detection-barrier-0106"
}

function model_chooser()
{
	local choose 
	read choose
	case $choose in 
		"1")
			eval "$1=\"age-gender-recognition-retail-0013\""
			return
			;;
		"2")
			eval "$1=\"emotions-recognition-retail-0003\""
			return
			;;
		"3")
			eval "$1=\"face-detection-adas-0001\""
			return
			;;
		"4")
			eval "$1=\"face-detection-retail-0004\""
			return
			;;
		"5")
			eval "$1=\"face-person-detection-retail-0002\""
			return
			;;
		"6")
			eval "$1=\"face-reidentification-retail-0001\""
			return
			;;
		"7")
			eval "$1=\"head-pose-estimation-adas-0001\""
			return
			;;
		"8")
			eval "$1=\"landmarks-regression-retail-0001\""
			return
			;;
		"9")
			eval "$1=\"license-plate-recognition-barrier-0001\""
			return
			;;
		"10")
			eval "$1=\"pedestrian-and-vehicle-detector-adas-0001\""
			return
			;;
		"11")
			eval "$1=\"pedestrian-detection-adas-0002\""
			return
			;;
		"12")
			eval "$1=\"person-attributes-recognition-crossroad-0031\""
			return
			;;
		"13")
			eval "$1=\"person-detection-action-recognition-0001\""
			return
			;;
		"14")
			eval "$1=\"person-detection-retail-0001\""
			return
			;;
		"15")
			eval "$1=\"person-detection-retail-0013\""
			return
			;;
		"16")
			eval "$1=\"person-reidentification-retail-0031\""
			return
			;;
		"17")
			eval "$1=\"person-reidentification-retail-0076\""
			return
			;;
		"18")
			eval "$1=\"person-reidentification-retail-0079\""
			return
			;;
		"19")
			eval "$1=\"person-vehicle-bike-detection-crossroad-0078\""
			return
			;;
		"20")
			eval "$1=\"road-segmentation-adas-0001\""
			return
			;;
		"21")
			eval "$1=\"semantic-segmentation-adas-0001\""
			return
			;;
		"22")
			eval "$1=\"vehicle-attributes-recognition-barrier-0039\""
			return
			;;
		"23")
			eval "$1=\"vehicle-detection-adas-0002\""
			return
			;;
		"24")
			eval "$1=\"vehicle-license-plate-detection-barrier-0106\""
			return
			;;		
		"0")
			echo "[WARNING] You do not choose any IR model! "
			eval "$1=\"0\""
			return
			;;	
		*)
			echo "Please Type the path of your IR model ... $choose"
			local STR
			read STR
			if [ -f $STR ]; then
				echo "$STR"
				echo " * Comfirm! "
			else 
				echo "File $STR does not exits. "
				exit 1
			fi
			;;
		esac
	exit 1
}

function security_barrier_camera_sample()
{
	echo "|=========================================|"
	echo "|        Intel OpenVINO Demostration      |"
	echo "|        Inference Engine Sample Demo     |"
	echo "|       security_barrier_camera_sample    |"
	echo "|=========================================|"
	model_chooser_option_printer
	#local model_D
	local model_M_VA
	local model_M_LPR
	local model_LoadSTR
	echo " Choose the model -m..."
	model_chooser model_M
	echo " Choose the model -m_va..."
	model_chooser model_M_VA
	echo " Choose the model -m_lpr..."
	model_chooser model_M_LPR
	#echo $model_D
	if ! source $SETVAR ; then
		prontf "ERROR!"
		exit 1
	fi

	echo "[SYNNEX_DEBUG] model_va = $model_M_VA ; model_lpr = $model_M_LPR"

	if [ "${model_M_VA}" != "0" ]; then
		model_LoadSTR=${model_LoadSTR}" -m_va "${MODEL_LOC}/${model_M_VA}/FP32/${model_M_VA}".xml"
	fi
	if [ "${model_M_LPR}" != "0" ]; then
		model_LoadSTR=${model_LoadSTR}" -m_lpr "${MODEL_LOC}/${model_M_LPR}/FP32/${model_M_LPR}".xml"
	fi

	source $SETVAR	
	cd $SAMPLE_LOC
	printf "Run ./security_barrier_camera_sample -m $MODEL_LOC/$model_M/FP32/$model_M.xml $model_LoadSTR -d CPU -i /opt/intel/computer_vision_sdk/deployment_tools/demo/car_1.bmp\n"
	./security_barrier_camera_sample -m $MODEL_LOC/$model_M/FP32/$model_M.xml $model_LoadSTR -d CPU -i /opt/intel/computer_vision_sdk/deployment_tools/demo/car_1.bmp

}

function feature_choose()
{
	echo " 1. Inference Engine Sample Demo.(TBD)"
	echo " 2. Model Optimizer Demo.(TBD)"
	local choose
	read choose
	case $choose in
		"1")
		Inference_Engine_Sample_List
		;;
		"2")
			echo " You choose Model Optimizer Demo.(TBD)"
			;;
		*)
			echo "Please input a number"
			;;
	esac

}
function Inference_Engine_Sample_List()
{
	echo "|=========================================|"
	echo "|        Intel OpenVINO Demostration      |"
	echo "|        Inference Engine Sample Demo     |"
	echo "|                                         |"
	echo "|=========================================|"
	echo ""
	echo "  1. security_barrier_camera_sample (TBD)"
	echo "  2. interactive_face_dection_sample (TBD)"
	echo "  3. classification_sample (TBD)"
	echo "  4. Show all samples that been built already."
	local choose
	read choose
	case $choose in
		"1")
			echo " You choose security_barrier_camera_sample ->"
			security_barrier_camera_sample
			;;
		"2")
			echo " You choose interactive_face_dection_sample (TBD)"
			;;
		"3")
			echo " You choose interactive_face_dection_sample (TBD)"
			;;
		*)
			echo "Please input a number"
			;;
	esac
}


echo
echo "|=========================================|"
echo "|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |"
echo "|                                         |"
echo "|        Intel OpenVINO Demostration      |"
echo "|=========================================|"
echo "          Version $VERSION                 "
echo ""
echo ""
feature_choose

exit 0