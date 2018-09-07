#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh
# ver 0.0.1
# This is design for connecting to the share folder on TWNB17034
# 2018/09/07 	henry1758	0.0.1 	first-create
#

export VERSION="0.0.1"

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
			echo " You choose security_barrier_camera_sample (TBD)"
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