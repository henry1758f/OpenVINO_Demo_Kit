#!/bin/bash
# File: model_downloader.sh
# 2019/04/19	henry1758f 0.0.1	First Create
# 2019/07/25	henry1758f 1.0.0	For v2019.2.242
INTEL_OPENVINO_DIR=/opt/intel/openvino
downloader_path="${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/downloader.py"
models_path="$HOME/openvino_models/models/SYNNEX_demo/"
converter_path="${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/converter.py"

function banner_show()
{
	echo
	echo "|=========================================|"
	echo "|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |"
	echo "|                                         |"
	echo "|            Model Downloader             |"
	echo "|=========================================|"
	echo "  Ver. 1.0.0 | Support OpenVINO $VERSION_VINO"
	echo ""
	echo ""
}

function feature_choose()
{
	echo " 1. Download all from DLDT. (about 16.4G Bytes)"
	echo " 2. Typein specific DLDT model."
	echo " 3. Typein an URL of the model."
	echo " 4. Convert all public model to IR"
	echo " 5. EXIT the downloader."

	local choose
	read choose
	case $choose in
		"1")
			python3 $downloader_path --all -o $models_path

		;;
		"2")			
			echo " > These are the model that supported, choose one to download...."
			python3 $downloader_path --print_all
			local MODEL_NAME
			echo ">>>"
			read MODEL_NAME

			python3 $downloader_path --name $MODEL_NAME -o $models_path
		;;
		"3")
			local MODEL_PATH
			echo " > Type the URL of the model....."
			read MODEL_PATH
			sudo apt-get update
			sudo apt-get install curl
			cd $models_path
			curl -O $MODEL_PATH
			echo " > Download Finish!!"
		;;
		"4")
			echo " > Convert all public model to IR....."
			python3 -mpip install --user -r ${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/requirements.in
			python3 -mpip install --user -r ${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/requirements-pytorch.in
			echo "excuting ..... python3 $converter_path --all --download_dir $models_path --output_dir $models_path/../../ir -j8"
			python3 $converter_path --all --download_dir $models_path --output_dir $models_path/../../ir -j8
		;;
		"5")
			exit
		;;
		*)
			echo "Please input a vailed number"
			clear
			banner_show
			feature_choose
		;;
	esac

}

cd /opt/intel/openvino/deployment_tools/tools/model_downloader

source /opt/intel/openvino/bin/setupvars.sh

clear

test -e ${models_path} || echo "${models_path} is not exist , create the folder..."
test -e ${models_path} || mkdir ${models_path}

banner_show
feature_choose


