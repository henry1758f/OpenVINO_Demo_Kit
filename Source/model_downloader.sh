#!/bin/bash
# File: model_downloader.sh

INTEL_OPENVINO_DIR=/opt/intel/openvino_2021
model_downloader_path="${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/"
models_path="$HOME/openvino_models/models/SYNNEX_demo/"
dataset_path=${PWD}/Source/testing_source/dataset/

function banner_show()
{
	echo
	echo "|=========================================|"
	echo "|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |"
	echo "|                                         |"
	echo "|            Model Downloader             |"
	echo "|=========================================|"
	echo "| Support OpenVINO $VERSION_VINO"
	echo ""
	echo ""
}

function feature_choose()
{
	echo " 1. Download all from DLDT. (about 40.1 GB)"
	echo " 2. Typein specific DLDT model."
	echo " 3. Typein an URL of the model."
	echo " 4. Convert all public model to IR (Need about 29.7G Bytes)"
	echo " 5. EXIT the downloader."
	echo " 6. Quantize all public models. (Need about 3.6GB for COCO and VOC2012 dataset)"

	local choose
	read choose
	case $choose in
		"1")
			python3 "${model_downloader_path}/downloader.py" --all -o ${models_path} -j8
			sleep 10
		;;
		"2")			
			echo " > These are the model that supported, choose one to download...."
			python3 "${model_downloader_path}/downloader.py" --print_all
			local MODEL_NAME
			echo ">>>"
			read MODEL_NAME

			python3 "${model_downloader_path}/downloader.py" --name $MODEL_NAME -o $models_path
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
			python3 -mpip install --user -r "${model_downloader_path}/requirements-tensorflow.in"
			python3 -mpip install --user -r "${model_downloader_path}/requirements-pytorch.in"
			python3 -mpip install --user -r "${model_downloader_path}/requirements-caffe2.in"
			echo "excuting ..... python3 ${model_downloader_path}/converter.py --all --download_dir $models_path --output_dir $models_path/../../ir -j8"
			python3 ${model_downloader_path}/converter.py --all --download_dir $models_path --output_dir $models_path/../../ir -j8
		;;
		"5")
			exit
		;;
		"6")
			test -e ${dataset_path} || echo "${dataset_path} is not exist , create the folder..."
			test -e ${dataset_path} || mkdir ${dataset_path}
			echo " > Downloading COCO dataset......"
			test -e ${dataset_path}val2017 || ( cd ${dataset_path} && { curl -O http://images.cocodataset.org/zips/val2017.zip ; cd -; } && \
				unzip ${dataset_path}val2017.zip -d ${dataset_path} && \
				rm -r ${dataset_path}val2017.zip)
			test -e ${dataset_path}instances_val2017.json || \
			( cd ${dataset_path} && { curl -O http://images.cocodataset.org/annotations/annotations_trainval2017.zip ; cd -; } && \
				unzip ${dataset_path}annotations_trainval2017.zip -d ${dataset_path} && \
				rm -r ${dataset_path}annotations_trainval2017.zip && \
				cp -r ${dataset_path}annotations/* ${dataset_path} && \
				rm -r ${dataset_path}annotations 
			)
			
			
			
			echo " > Downloading ImageNet dataset......[Nothing to do....]"
			#cd ${dataset_path} && { curl -O http://dl.caffe.berkeleyvision.org/caffe_ilsvrc12.tar.gz}
			echo " > Downloading WIDER FACE dataset......[Nothing to do....]"
			echo " > Downloading VOC2012 dataset......"
			test -e ${dataset_path}VOCdevkit || \
			( cd ${dataset_path} && { curl -O http://host.robots.ox.ac.uk/pascal/VOC/voc2012/VOCtrainval_11-May-2012.tar ; cd -; } &&\
				tar xvf ${dataset_path}VOCtrainval_11-May-2012.tar -C ${dataset_path} && \
				rm -r ${dataset_path}VOCtrainval_11-May-2012.tar
			)
			
			echo " > Using Model Quantizer......"
			python3 ${model_downloader_path}/quantizer.py --all --model_dir $models_path/../../ir --output_dir $models_path/../../ir --precisions FP16-INT8 --dataset_dir ${dataset_path}
		;;
		*)
			echo "Please input a vailed number"
			clear
			banner_show
			feature_choose
		;;
	esac

}

source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
python3 -mpip install --user -r "${model_downloader_path}/requirements.in"

clear

test -e ${models_path} || echo "${models_path} is not exist , create the folder..."
test -e ${models_path} || mkdir ${models_path}

banner_show
feature_choose


