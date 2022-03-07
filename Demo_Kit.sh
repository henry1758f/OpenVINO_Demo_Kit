#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh

export VERSION="7.0.0"
export VERSION_VINO="2021.4.582"
export INTEL_OPENVINO_DIR=/opt/intel/openvino_2021/
export SAMPLE_LOC="$HOME/inference_engine_${PWD##*/}_samples_build/intel64/Release"
export DEMO_LOC="$HOME/omz_demos_build/intel64/Release"
export Source_Sample_Build="./Source/sample_build.sh"
export Source_Model_Downloader="./Source/model_downloader.sh"
dlworkbench="./Source/dlworkbench.sh"
export SOURCE=./Source/
ubuntu_ver=$(cat /etc/os-release | grep "VERSION_ID" | cut -c 13-17)

function feature_choose()
{
	test -e ${SAMPLE_LOC}/benchmark_app && echo " 0. Run Benchmark App"
	echo " 1. Inference Engine Sample Demo."
	test -e ${SAMPLE_LOC}/benchmark_app && echo " 2. Sample Build.(Done!)" || echo " 2. Sample Build."
	echo " 3. Model Downloader."
	echo " 4. Query Device."
	echo " 5. Run Deep Learning Workbench."
	test -e ${INTEL_OPENVINO_DIR}/bin/setupvars.sh || echo " 6. Install OpenVINO."


	local choose
	read choose
	case $choose in
		"0")
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh && python3 ${SOURCE}benchmark.py
		;;
		"1")
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh && python3 ${SOURCE}OpenModelZoo_demos.py
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
			source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh && $SAMPLE_LOC/hello_query_device
			read -n 1 -s -r -p "> Press any key to continue"
			clear
			banner_show
			feature_choose
			;;
		"5")
			xdg-open https://openvinotoolkit.github.io/workbench_aux/
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
			sudo apt install gnupg
			public_key_url="https://apt.repos.intel.com/openvino/2021/GPG-PUB-KEY-INTEL-OPENVINO-2021"
			wget -q --spider $public_key_url
			if [ $? -eq 0 ];then
				echo "[INFO] Start download and install openVINO $VERSION_VINO"
				wget $public_key_url
				sudo apt-key add GPG-PUB-KEY-INTEL-OPENVINO-2021
				echo "deb https://apt.repos.intel.com/openvino/2021 all main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2021.list
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
				sudo ${INTEL_OPENVINO_DIR}/install_dependencies/install_NEO_OCL_driver.sh -a
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


