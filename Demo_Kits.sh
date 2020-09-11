#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh
# 2019/04/16	henry1758f 2.0.0	First Create
# 2019/07/26	henry1758f 3.0.0	fit OpenVINO 2019R2, Add pedestrian_tracker_demo, segmentation_demo, Improved Output information and Fixed bugs
# 2019/07/31	henry1758f 3.1.1	benchmark_app new feature:setting multiple testing times is now available
# 2019/10/24	henry1758f 4.0.0	*Bug fixed *Add 5 new demo support *fit for OpenVINO 2019R3 version
# 2020/09/09	henry1758f 5.0.0	Support OpenVINO v2020.3, Totally 18 Demos, benchmark Tool, Model Downloader are included.
# 2020/09/10	henry1758f 5.0.1	Add auto install feature.

export VERSION="5.0.1"
export VERSION_VINO="2020.3.194"
export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export Source_Sample_Build="./Source/sample_build.sh"
export Source_Model_Downloader="./Source/model_downloader.sh"
export SOURCE=./Source/

function Inference_Engine_Sample_List()
{
	source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
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
	echo "  4. Human Pose Estimation Demo. (2D)"
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
	echo " 15. Multi Camera Multi Person demo"
	echo " 16. Face Recognition Demo"
	echo " 17. Speech Recognition Demo "
	echo " 18. Real Time Speech Recognition Demo"

	local choose
	read choose

	case $choose in
		"0")
			echo " You choose Benchmark App ->"
			python3 ${SOURCE}benchmark_app.py
		;;
		"1")
			echo " You choose security_barrier_camera_demo ->"
			python3 ${SOURCE}security_barrier_camera_demo.py
		;;
		"2")
			echo " You choose interactive_face_detection_demo ->"
			python3 ${SOURCE}interactive_face_detection_demo.py
		;;
		"3")
			echo " You choose classification_demo ->"
			python3 ${SOURCE}classification_demo.py
		;;
		"4")
			echo " Human Pose Estimation Demo (2D) ->"
			python3 ${SOURCE}human_pose_estimation_demo.py
		;;
		"5")
			echo " Object Detection and ASYNC API Demo ->"
			python3 ${SOURCE}object_detection_demo_ssd_async.py
		;;
		"6")
			echo " Crossroad Camera Demo ->"
			python3 ${SOURCE}crossroad_camera_demo.py
		;;
		"7")
			echo " super_resolution_demo ->"
			python3 ${SOURCE}super_resolution_demo.py
		;;
		"8")
			echo " pedestrian tracker demo ->"
			python3 ${SOURCE}pedestrian_tracker_demo.py
		;;
		"9")
			echo " smart_classroom_demo ->"
			python3 ${SOURCE}smart_classroom_demo.py
		;;
		"10")
			echo " Image Segmentation Demo ->"
			python3 ${SOURCE}segmentation_demo.py
		;;
		"11")
			echo " Instance Segmentation Demo ->"
			python3 ${SOURCE}instance_segmentation_demo.py
		;;
		"12")
			echo " Gaze Estimation Demo ->"
			python3 ${SOURCE}gaze_estimation_demo.py
		;;
		"13")
			echo " Text Detection Demo ->"
			python3 ${SOURCE}text_detection_demo.py
		;;
		"14")
			echo " Action Recognition Demo ->"
			python3 ${SOURCE}action_recognition_demo.py
		;;
		"15")
			echo " Multi Camera Multi Person demo ->"
			python3 ${SOURCE}multi_camera_multi_person_tracking.py

		;;
		"16")
			echo " Face Recognition Demo ->"
			python3 ${SOURCE}face_recognition_demo.py

		;;
		"17")
			echo " Offline Speech Recognition Demo ->"
			#${INTEL_OPENVINO_DIR}deployment_tools/demo/demo_speech_recognition.sh
			python3 ${SOURCE}offline_speech_recognition_demo.py
		;;
		"18")
			echo " Real Time Speech Recognition Demo ->"
#			${INTEL_OPENVINO_DIR}data_processing/audio/speech_recognition/build_gcc.sh
			${INTEL_OPENVINO_DIR}deployment_tools/demo/demo_speech_recognition.sh
		;;
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
	test -e ${INTEL_OPENVINO_DIR}/bin/setupvars.sh || echo " 5. Install OpenVINO."

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
		"5")
			wget -q --spider https://apt.repos.intel.com/openvino/2020/GPG-PUB-KEY-INTEL-OPENVINO-2020
			if [ $? -eq 0 ];then
				echo "[INFO] Start download and install openVINO $VERSION_VINO"
				wget https://apt.repos.intel.com/openvino/2020/GPG-PUB-KEY-INTEL-OPENVINO-2020
				apt-key add GPG-PUB-KEY-INTEL-OPENVINO-2020
				touch /etc/apt/sources.list.d/intel-openvino-2020.list
				echo deb https://apt.repos.intel.com/openvino/2020 all main > /etc/apt/sources.list.d/intel-openvino-2020.list
				apt update
				apt install intel-openvino-dev-ubuntu18-$VERSION_VINO
			else
				echo "Please check your internet connection! We need internet to download openVINO!"
				sleep 1
				
			fi
			clear
			banner_show
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
	echo "| Ver. $VERSION | Support OpenVINO v$VERSION_VINO"
	openvino_link=$(ls -l /opt/intel/openvino | grep "openvino" | cut -d">" -f 2 |cut -d"/" -f 4)
	if [ -d "${INTEL_OPENVINO_DIR}" ]; then
		echo "| You've installed ${openvino_link}"
	else
		echo "[WARN] OpenVINO not detected!"
	fi
	echo "|"
}


banner_show
feature_choose


