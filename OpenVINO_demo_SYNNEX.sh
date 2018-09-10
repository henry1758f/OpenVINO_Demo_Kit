#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh
# ver 0.0.1
# This is design for connecting to the share folder on TWNB17034
# 2018/09/07 	henry1758	0.0.1 	first-create
#

export VERSION="0.0.1"
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
			expr "$1=\"age-gender-recognition-retail-0013\""
			;;
		"2")
			expr "$1=\"emotions-recognition-retail-0003\""
			;;
		"3")
			expr "$1=\"face-detection-adas-0001\""
			;;
		"4")
			expr "$1=\"face-detection-retail-0004\""
			;;
		"5")
			expr "$1=\"face-person-detection-retail-0002\""
			;;
		"6")
			expr "$1=\"face-reidentification-retail-0001\""
			;;
		"7")
			expr "$1=\"head-pose-estimation-adas-0001\""
			;;
		"8")
			expr "$1=\"landmarks-regression-retail-0001\""
			;;
		"9")
			expr "$1=\"license-plate-recognition-barrier-0001\""
			;;
		"10")
			expr "$1=\"pedestrian-and-vehicle-detector-adas-0001\""
			;;
		"11")
			expr "$1=\"pedestrian-detection-adas-0002\""
			;;
		"12")
			expr "$1=\"person-attributes-recognition-crossroad-0031\""
			;;
		"13")
			expr "$1=\"person-detection-action-recognition-0001\""
			;;
		"14")
			expr "$1=\"person-detection-retail-0001\""
			;;
		"15")
			expr "$1=\"person-detection-retail-0013\""
			;;
		"16")
			expr "$1=\"person-reidentification-retail-0031\""
			;;
		"17")
			expr "$1=\"person-reidentification-retail-0076\""
			;;
		"18")
			expr "$1=\"person-reidentification-retail-0079\""
			;;
		"19")
			expr "$1=\"person-vehicle-bike-detection-crossroad-0078\""
			;;
		"20")
			expr "$1=\"road-segmentation-adas-0001\""
			;;
		"21")
			expr "$1=\"semantic-segmentation-adas-0001\""
			;;
		"22")
			expr "$1=\"avehicle-attributes-recognition-barrier-0039\""
			;;
		"23")
			expr "$1=\"vehicle-detection-adas-0002\""
			;;
		"24")
			expr "$1=\"vehicle-license-plate-detection-barrier-0106\""
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
	local model_D
	local model_D_VA
	local model_D_LPR
	echo " Choose the model -d..."
	model_chooser model_D
	echo $model_D

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