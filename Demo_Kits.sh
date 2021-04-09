#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh

export VERSION="6.0.0-beta02"
export VERSION_VINO="2021.3.394"
export INTEL_OPENVINO_DIR=/opt/intel/openvino_2021/
export SAMPLE_LOC="$HOME/inference_engine_OpenVINO_Demo_Kit_samples_build/intel64/Release"
export DEMO_LOC="$HOME/omz_demos_build/intel64/Release"
export Source_Sample_Build="./Source/sample_build.sh"
export Source_Model_Downloader="./Source/model_downloader.sh"
dlworkbench="./Source/dlworkbench.sh"
export SOURCE=./Source/
ubuntu_ver=$(cat /etc/os-release | grep "VERSION_ID" | cut -c 13-17)
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
	echo "  1. Security Barrier Camera Demo. "
	echo "  2. Interactive Face Detection Demo."
	echo "  3. Classification Demo."
	echo "  4. Human Pose Estimation Demo. (2D)"
#	echo "  4-1. Human Pose Estimation Demo. (3D)"
	echo "  5. Object Detection Demo."
	echo "  6. Crossroad Camera Demo."
	echo "  7. Super Resolution Demo."
	echo "  8. Pedestrian Tracker Demo."
	echo "  9. Smart Classroom Demo."
	echo " 10. Image Segmentation Demo."
	echo " 11. Instance Segmentation Demo"
	echo " 12. Gaze Estimation Demo"
	echo " 13. Text Detection Demo"
	echo " 14. Action Recognition Demo"
	echo " 15. Multi Camera Multi Person demo"
	echo " 16. Real Time Speech Recognition Demo"
	echo " 17. Colorization Demo"
	echo " 18. Gesture Recognition Demo"
#	echo " 19. Face Recognition Demo"

	local choose
	read choose

	case $choose in
		"0")
			echo " Benchmark App ->"
			python3 ${SOURCE}benchmark_app.py
		;;
		"1")
			echo " Security Barrier Camera_Demo ->"
			python3 ${SOURCE}security_barrier_camera_demo.py
		;;
		"2")
			echo " Interactive Face Detection Demo ->"
			python3 ${SOURCE}interactive_face_detection_demo.py
		;;
		"3")
			echo " Classification Demo ->"
			python3 ${SOURCE}classification_demo.py
		;;
		"4")
			echo " Human Pose Estimation Demo (2D) ->"
			python3 ${SOURCE}human_pose_estimation_demo.py
		;;
		"4-1")
			echo " Human Pose Estimation Demo (3D) ->"
			# To run this demo, we have to build the Native Python Extension and modify the build script.
			# For more information, please visit 
			# https://community.intel.com/t5/Intel-Distribution-of-OpenVINO/New-3D-human-pose-estimation-demo/m-p/1183638#M18851
			export PYTHONPATH="$PYTHONPATH:{DEMO_LOC}/lib"
			python3 ${SOURCE}3D_human_pose_estimation_demo.py
		;;
		"5")
			echo " Object Detection Demo ->"
			python3 ${SOURCE}object_detection_demo_ssd_async.py
		;;
		"6")
			echo " Crossroad Camera Demo ->"
			python3 ${SOURCE}crossroad_camera_demo.py
		;;
		"7")
			echo " Super Resolution Demo ->"
			python3 ${SOURCE}super_resolution_demo.py
		;;
		"8")
			echo " Pedestrian Tracker Demo ->"
			python3 ${SOURCE}pedestrian_tracker_demo.py
		;;
		"9")
			echo " Smart Classroom Demo ->"
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
			echo " Real Time Speech Recognition Demo ->"
			${INTEL_OPENVINO_DIR}/deployment_tools/demo/demo_speech_recognition.sh
		;;
		"17")
			echo " Colorization Demo ->"
			python3 ${SOURCE}colorization_demo.py
		;;
		"18")
			echo " Gesture Recognition Demo ->"
			python3 ${SOURCE}gesture_recognition_demo.py
		;;
		"19")
			echo " Face Recognition Demo ->"
			python3 ${SOURCE}face_recognition_demo.py
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
	echo " 5. Run Deep Learning Workbench."
	test -e ${INTEL_OPENVINO_DIR}/bin/setupvars.sh || echo " 6. Install OpenVINO."


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
		;;
		"4")
			test -e $SAMPLE_LOC/hello_query_device || $Source_Sample_Build
			$SAMPLE_LOC/hello_query_device
			read -n 1 -s -r -p "> Press any key to continue"
			clear
			banner_show
			feature_choose
			;;
		"5")
			sudo $dlworkbench
			clear
			banner_show
			feature_choose
			;;
		"6")
			echo "[INFO] Installing OpenVINO $VERSION_VINO on Ubuntu $ubuntu_ver ..."
			if [[ "$ubuntu_ver" != "20.04" && "$ubuntu_ver" != "18.04" ]];then
				echo " [ERROR] $VERSION_VINO is not support Ubuntu $ubuntu_ver"
				exit
			fi

			public_key_url="https://apt.repos.intel.com/openvino/2021/GPG-PUB-KEY-INTEL-OPENVINO-2021"
			wget -q --spider $public_key_url
			if [ $? -eq 0 ];then
				echo "[INFO] Start download and install openVINO $VERSION_VINO"
				wget $public_key_url
				public_key_name=${public_key_name#*/}
				sudo apt-key add $public_key_name
				sudo touch /etc/apt/sources.list.d/intel-openvino-2021.list
				sudo su -c "echo deb https://apt.repos.intel.com/openvino/2021 all main > /etc/apt/sources.list.d/intel-openvino-2021.list"
				sudo apt update
				case $ubuntu_ver in
					"20.04")
						sudo apt install intel-openvino-dev-ubuntu20-$VERSION_VINO
						;;
					"18.04")
						sudo apt install intel-openvino-dev-ubuntu18-$VERSION_VINO
						;;
					*)
						echo " [ERROR] $VERSION_VINO is not support Ubuntu $ubuntu_ver"
						exit
						;;
				esac

				source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
				sudo ${INTEL_OPENVINO_DIR}/install_dependencies/install_openvino_dependencies.sh
				sudo ${INTEL_OPENVINO_DIR}/install_dependencies/install_NCS_udev_rules.sh
				# sudo su -c "${INTEL_OPENVINO_DIR}/install_dependencies/install_NEO_OCL_driver.sh"
				sudo ${INTEL_OPENVINO_DIR}/deployment_tools/model_optimizer/install_prerequisites/install_prerequisites.sh
				echo "source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh" > $HOME/.bash.rc
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
	openvino_link=$(ls -l /opt/intel/openvino_2021 | grep "openvino" | cut -d">" -f 2 |cut -d"/" -f 4)
	if [ -d "${INTEL_OPENVINO_DIR}" ]; then
		echo "| You've installed ${openvino_link} on $ubuntu_ver"
	else
		echo "[WARN] OpenVINO not detected!"
	fi
	echo "|"
}


banner_show
feature_choose


