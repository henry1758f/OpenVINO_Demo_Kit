#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh
# 2019/04/16	henry1758f 2.0.0	First Create
# 2019/07/26	henry1758f 3.0.0	fit OpenVINO 2019R2, Add pedestrian_tracker_demo, segmentation_demo, Improved Output information and Fixed bugs
# 2019/07/31	henry1758f 3.1.1	benchmark_app new feature:setting multiple testing times is now available
# 2019/10/04	henry1758f 4.0.0-beta01	Benchmark App fit OpenVINO 2019R3
# 2019/10/04	henry1758f 4.0.0-beta02	security_barrier_camera_demo and interactive_face_detection_demo fit OpenVINO 2019R3
# 2019/10/04	henry1758f 4.0.0-beta03	Fix Error when there's no IR file the MO cannot been excute correctly in Benchmark App
# 2019/10/05	henry1758f 4.0.0-beta04 object_detection_demo_ssd_async, classification_demo  fit OpenVINO 2019R2 and fix mispell in benchmark_app
# 2019/10/07	henry1758f 4.0.0-beta05 optimized the object_detection_demo_ssd_async scripts, deleted unnecessary labels
# 2019/10/07	henry1758f 4.0.0-beta06 Human Pose Estimation Demo and Crossroad Camera Demo fit OpenVINO 2019R3
# 2019/10/07	henry1758f 4.0.0-beta07 super_resolution_demo and pedestrian tracker demo fit OpenVINO 2019R3
# 2019/10/07	henry1758f 4.0.0-beta08 smart classroom demo fit OpenVINO 2019R3
# 2019/10/07	henry1758f 4.0.0-beta09 segmentation_demo fit OpenVINO 2019R3
# 2019/10/07	henry1758f 4.0.0-beta10 Add Instance Segmentation Demo
# 2019/10/07	henry1758f 4.0.0-beta11 Add Gaze Estimation Demo
# 2019/10/07	henry1758f 4.0.0-beta12 Fix path error of face-detection-retail-0044 in interactive_face_detection_demo.sh
# 2019/10/07	henry1758f 4.0.0-beta13 Add Text Detection Demo
# 2019/10/07	henry1758f 4.0.0-beta14 Add Action Recognition Demo
# 2019/10/08	henry1758f 4.0.0-beta15 Add Query Device feature

export VERSION="4.0.0-beta15"
export VERSION_VINO="v2019.3.334"
export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export Source_Sample_Build="./Source/sample_build.sh"
export Source_Model_Downloader="./Source/model_downloader.sh"
export SOURCE=./Source/

function Inference_Engine_Sample_List()
{
	echo "|=========================================|"
	echo "|        Intel OpenVINO Demostration      |"
	echo "|        Inference Engine Sample Demo     |"
	echo "|                                         |"
	echo "|=========================================|"
	echo ""
	echo "  0. Benchmark App."
	echo "  1. security_barrier_camera_demo. "
	echo "  2. interactive_face_detection_demo."
	echo "  3. classification_demo."
	echo "  4. Human Pose Estimation Demo."
	echo "  5. Object Detection and ASYNC API Demo."
	echo "  6. Crossroad Camera Demo."
	echo "  7. super_resolution_demo."
	echo "  8. pedestrian tracker demo."
	echo "  9. smart_classroom_demo."
	echo " 10. Image Segmentation Demo."
	echo " 11. Instance Segmentation Demo"
	echo " 12. Gaze Estimation Demo"
	echo " 13. Text Detection Demo"
	echo " 14. Action Recognition Demo"
	echo " 15. Multi Camera Multi Person demo(TBD)"
  

	local choose
	read choose
	case $choose in
		"0")
			echo " You choose Benchmark App ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}benchmark_app.sh
		;;
		"1")
			echo " You choose security_barrier_camera_demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}security_barrier_camera_demo.sh
		;;
		"2")
			echo " You choose interactive_face_detection_demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}interactive_face_detection_demo.sh
		;;
		"3")
			echo " You choose classification_demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}classification_demo.sh
		;;
		"4")
			echo " Human Pose Estimation Demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}human_pose_estimation_demo.sh
		;;
		"5")
			echo " Object Detection and ASYNC API Demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}object_detection_demo_ssd_async.sh
		;;
		"6")
			echo " Crossroad Camera Demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}crossroad_camera_demo.sh
		;;
		"7")
			echo " super_resolution_demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}super_resolution_demo.sh
		;;
		"8")
			echo " pedestrian tracker demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}pedestrian_tracker_demo.sh
		;;
		"9")
			echo " smart_classroom_demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}smart_classroom_demo.sh
		;;
		"10")
			echo " Image Segmentation Demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}segmentation_demo.sh
		;;
		"11")
			echo " Instance Segmentation Demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}instance_segmentation_demo.sh
		;;
		"12")
			echo " Gaze Estimation Demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}gaze_estimation_demo.sh
		;;
		"13")
			echo " Text Detection Demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}text_detection_demo.sh
		;;
		"14")
			echo " Action Recognition Demo ->"
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
			${SOURCE}action_recognition_demo.sh
		;;
#		"11")
#			echo " Speech Sample (TBD) ->"
#			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
#			${SOURCE}speech_sample.sh
#		;;
		*)
			echo "Please input a vailed number"
			sleep 1
			clear
			banner_show
			Inference_Engine_Sample_List
			;;
	esac

}

function feature_choose()
{
	echo " 1. Inference Engine Sample Demo."
	test -e ${SAMPLE_LOC}/benchmark_app && echo " 2. Sample Build.(Done!)" || echo " 2. Sample Build."
	echo " 3. Model Downloader."
	echo " 4. Query Device."


	local choose
	read choose
	case $choose in
		"1")
			Inference_Engine_Sample_List
		;;
		"2")
			$Source_Sample_Build
			clear
			banner_show
			feature_choose
		;;
		"3")
			$Source_Model_Downloader
			clear
			banner_show
			feature_choose
		;;
		"4")
			test -e $SAMPLE_LOC/hello_query_device || $Source_Sample_Build
			$SAMPLE_LOC/hello_query_device
			read -n 1 -s -r -p "> Press any key to continue"
			clear
			feature_choose
			;;
		*)
			echo "Please input a vailed number"
			sleep 1
			clear
			banner_show
			feature_choose
			;;
	esac

}

function banner_show()
{
	echo
	echo "|=========================================|"
	echo "|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |"
	echo "|                                         |"
	echo "|        Intel OpenVINO Demostration      |"
	echo "|=========================================|"
	echo "  Ver. $VERSION | Support OpenVINO $VERSION_VINO"
	echo ""
}


banner_show
feature_choose


