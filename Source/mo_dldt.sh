# File: mo_dldt.sh
# 2019/05/10	henry1758f 0.0.1	First Create
# 2019/05/30	henry1758f 1.0.0	Add ssd_mobilenet_v1,ssd512 and ssd300.
# 2019/05/30	henry1758f 1.0.1	Add mobilenet-ssd but without labels.
# 2019/06/04	henry1758f 1.0.2	Add squeezenet1.1/1.0
# 2019/06/11	henry1758f 1.0.3	Add densenet
# 2019/06/13	henry1758f 1.0.4	Add googlenet
# 2019/06/18	henry1758f 1.0.5	fix googlenetv3
# 2019/06/18	henry1758f 1.0.6	fix googlenetv3
# 2019/06/19	henry1758f 1.0.7	fix googlenetv4
# 2019/06/19	henry1758f 1.0.8	Add vgg16/19

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=/home/$(whoami)/openvino_models/models/SYNNEX_demo
export MO_LOC=/opt/intel/openvino/deployment_tools/model_optimizer
export FPV="FP32"
function target()
{
	case $1 in
		"-fp32")
			FPV="FP32"
		;;
		"-fp16")
			FPV="FP16"
		;;
		*)
		;;
	esac
}

function List()
{
	echo "The Support List as below, after using Demo Script to download model, following models are able to run model optimizer to covert to IR format."
	echo " - ssd_mobilenet_v2_coco.frozen.pb"
	echo " - ssd_mobilenet_v1_coco.frozen.pb"
	echo " - ssd512.caffemodel"
	echo " - ssd300.caffemodel"
}
function MO()
{
	case $1 in
		"ssd_mobilenet_v2_coco.frozen.pb")
			target $2
			test -e ${MODEL_LOC}/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29/frozen_inference_graph.pb || echo "[ERROR!] Can not found \"frozen_inference_graph.pb\" !!!"
			test -e ${MODEL_LOC}/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29/pipeline.config || echo "[ERROR!] Can not found \"pipeline.config\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29
			python3 ${MO_LOC}/mo_tf.py --input_model "${MODEL_LOC}/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29/frozen_inference_graph.pb" --output_dir "${MODEL_LOC}/../../ir/${FPV}/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29" --data_type "${FPV}" --tensorflow_use_custom_operations_config ${INTEL_OPENVINO_DIR}/deployment_tools/model_optimizer/extensions/front/tf/ssd_v2_support.json --output="detection_boxes,detection_scores,num_detections" --tensorflow_object_detection_api_pipeline_config "${MODEL_LOC}/object_detection/common/ssd_mobilenet_v2_coco/tf/ssd_mobilenet_v2_coco_2018_03_29/pipeline.config"
		;;
		"ssd_mobilenet_v1_coco.frozen.pb")
			target $2
			test -e ${MODEL_LOC}/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco_2018_01_28/frozen_inference_graph.pb || echo "[ERROR!] Can not found \"frozen_inference_graph.pb\" !!!"
			test -e ${MODEL_LOC}/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco_2018_01_28/pipeline.config || echo "[ERROR!] Can not found \"pipeline.config\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/
			python3 ${MO_LOC}/mo_tf.py --input_model "${MODEL_LOC}/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco_2018_01_28/frozen_inference_graph.pb" --output_dir "${MODEL_LOC}/../../ir/${FPV}/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco_2018_01_28" --data_type "${FPV}" --tensorflow_use_custom_operations_config ${INTEL_OPENVINO_DIR}/deployment_tools/model_optimizer/extensions/front/tf/ssd_v2_support.json --output="detection_boxes,detection_scores,num_detections" --tensorflow_object_detection_api_pipeline_config "${MODEL_LOC}/object_detection/common/ssd_mobilenet/ssd_mobilenet_v1_coco/tf/ssd_mobilenet_v1_coco_2018_01_28/pipeline.config" 
		;;
		"ssd512.caffemodel")
			target $2
			test -e ${MODEL_LOC}/object_detection/common/ssd/512/caffe/ssd512.caffemodel || echo "[ERROR!] Can not found \"ssd512.caffemodel\" !!!"
			test -e ${MODEL_LOC}/object_detection/common/ssd/512/caffe/ssd512.prototxt || echo "[ERROR!] Can not found \"ssd512.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/object_detection/common/ssd/512/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/object_detection/common/ssd/512/caffe/ssd512.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/object_detection/common/ssd/512/caffe/" --input_proto "${MODEL_LOC}/object_detection/common/ssd/512/caffe/ssd512.prototxt" --data_type "${FPV}" 
		;;
		"ssd300.caffemodel")
			target $2
			test -e ${MODEL_LOC}/object_detection/common/ssd/300/caffe/ssd300.caffemodel || echo "[ERROR!] Can not found \"ssd300.caffemodel\" !!!"
			test -e ${MODEL_LOC}/object_detection/common/ssd/300/caffe/ssd300.prototxt || echo "[ERROR!] Can not found \"ssd300.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/object_detection/common/ssd/300/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/object_detection/common/ssd/300/caffe/ssd300.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/object_detection/common/ssd/300/caffe/" --input_proto "${MODEL_LOC}/object_detection/common/ssd/300/caffe/ssd300.prototxt" --data_type "${FPV}" 
		;;
		"squeezenet1.1.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/squeezenet/1.1/caffe/squeezenet1.1.caffemodel || echo "[ERROR!] Can not found \"squeezenet1.1.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/squeezenet/1.1/caffe/squeezenet1.1.prototxt || echo "[ERROR!] Can not found \"squeezenet1.1.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/squeezenet/1.1/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/squeezenet/1.1/caffe/squeezenet1.1.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/squeezenet/1.1/caffe" --input_proto "${MODEL_LOC}/classification/squeezenet/1.1/caffe/squeezenet1.1.prototxt" --data_type "${FPV}" 
		;;
		"squeezenet1.0.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/squeezenet/1.0/caffe/squeezenet1.0.caffemodel || echo "[ERROR!] Can not found \"squeezenet1.0.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/squeezenet/1.0/caffe/squeezenet1.0.prototxt || echo "[ERROR!] Can not found \"squeezenet1.0.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/squeezenet/1.0/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/squeezenet/1.0/caffe/squeezenet1.0.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/squeezenet/1.0/caffe" --input_proto "${MODEL_LOC}/classification/squeezenet/1.0/caffe/squeezenet1.0.prototxt" --data_type "${FPV}" 
		;;
		"alexnet.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/alexnet/caffe/alexnet.caffemodel || echo "[ERROR!] Can not found \"alexnet.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/alexnet/caffe/alexnet.prototxt || echo "[ERROR!] Can not found \"alexnet.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/alexnet/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/alexnet/caffe/alexnet.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/alexnet/caffe" --input_proto "${MODEL_LOC}/classification/alexnet/caffe/alexnet.prototxt" --data_type "${FPV}" 
		;;
		"densenet-201.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/densenet/201/caffe/densenet-201.caffemodel || echo "[ERROR!] Can not found \"densenet-201.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/densenet/201/caffe/densenet-201.prototxt || echo "[ERROR!] Can not found \"densenet-201.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/densenet/201/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/densenet/201/caffe/densenet-201.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/densenet/201/caffe" --input_proto "${MODEL_LOC}/classification/densenet/201/caffe/densenet-201.prototxt" --data_type "${FPV}" --input_shape=[1,3,224,224] --input=data --mean_values=data[103.94,116.78,123.68] --scale_values=data[58.8235294117647] --output=fc6
		;;
		"densenet-169.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/densenet/169/caffe/densenet-169.caffemodel || echo "[ERROR!] Can not found \"densenet-169.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/densenet/169/caffe/densenet-169.prototxt || echo "[ERROR!] Can not found \"densenet-169.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/densenet/169/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/densenet/169/caffe/densenet-169.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/densenet/169/caffe" --input_proto "${MODEL_LOC}/classification/densenet/169/caffe/densenet-169.prototxt" --data_type "${FPV}" --input_shape=[1,3,224,224] --input=data --mean_values=data[103.94,116.78,123.68] --scale_values=data[58.8235294117647] --output=fc6
		;;
		"densenet-161.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/densenet/161/caffe/densenet-161.caffemodel || echo "[ERROR!] Can not found \"densenet-161.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/densenet/161/caffe/densenet-161.prototxt || echo "[ERROR!] Can not found \"densenet-161.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/densenet/161/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/densenet/161/caffe/densenet-161.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/densenet/161/caffe" --input_proto "${MODEL_LOC}/classification/densenet/161/caffe/densenet-161.prototxt" --data_type "${FPV}" --input_shape=[1,3,224,224] --input=data --mean_values=data[103.94,116.78,123.68] --scale_values=data[58.8235294117647] --output=fc6
		;;
		"densenet-121.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/densenet/121/caffe/densenet-121.caffemodel || echo "[ERROR!] Can not found \"densenet-121.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/densenet/121/caffe/densenet-121.prototxt || echo "[ERROR!] Can not found \"densenet-121.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/densenet/121/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/densenet/121/caffe/densenet-121.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/densenet/121/caffe" --input_proto "${MODEL_LOC}/classification/densenet/121/caffe/densenet-121.prototxt" --data_type "${FPV}" --input_shape=[1,3,224,224] --input=data --mean_values=data[103.94,116.78,123.68] --scale_values=data[58.8235294117647] --output=fc6
		;;
		"googlenet-v1.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/googlenet/v1/caffe/googlenet-v1.caffemodel || echo "[ERROR!] Can not found \"googlenet-v1.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/googlenet/v1/caffe/googlenet-v1.prototxt || echo "[ERROR!] Can not found \"googlenet-v1.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/googlenet/v1/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/googlenet/v1/caffe/googlenet-v1.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/googlenet/v1/caffe" --input_proto "${MODEL_LOC}/classification/googlenet/v1/caffe/googlenet-v1.prototxt" --data_type "${FPV}" --input_shape=[1,3,224,224] --input=data --mean_values=data[104.0,117.0,123.0] --output=prob
		;;
		"googlenet-v2.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/googlenet/v2/caffe/googlenet-v2.caffemodel || echo "[ERROR!] Can not found \"googlenet-v2.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/googlenet/v2/caffe/googlenet-v2.prototxt || echo "[ERROR!] Can not found \"googlenet-v2.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/googlenet/v2/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/googlenet/v2/caffe/googlenet-v2.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/googlenet/v2/caffe" --input_proto "${MODEL_LOC}/classification/googlenet/v2/caffe/googlenet-v2.prototxt" --data_type "${FPV}" --input_shape=[1,3,224,224] --input=data --mean_values=data[104.0,117.0,123.0] --output=prob
		;;
		"googlenet-v3.frozen.pb")
			target $2
			test -e ${MODEL_LOC}/classification/googlenet/v3/tf/inception_v3_2016_08_28_frozen.pb || echo "[ERROR!] Can not found \"inception_v3_2016_08_28_frozen.pb\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/googlenet/v3/tf
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/googlenet/v3/tf/inception_v3_2016_08_28_frozen.pb" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/googlenet/v3/tf"  --data_type "${FPV}" --input_shape=[1,299,299,3] --mean_values=input[127.5,127.5,127.5] --scale_values=input[127.50000414375013] --reverse_input_channels --input=input --output=InceptionV3/Predictions/Softmax
		;;
		"googlenet-v4.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/googlenet/v4/caffe/googlenet-v4.caffemodel || echo "[ERROR!] Can not found \"googlenet-v4.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/googlenet/v4/caffe/googlenet-v4.prototxt || echo "[ERROR!] Can not found \"googlenet-v4.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/googlenet/v4/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/googlenet/v4/caffe/googlenet-v4.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/googlenet/v4/caffe" --input_proto "${MODEL_LOC}/classification/googlenet/v4/caffe/googlenet-v4.prototxt" --data_type "${FPV}" --input_shape=[1,3,299,299] --input=data --mean_values=data[128.0,128.0,128.0] --scale_values=data[128.0] --output=prob
		;;
		"vgg16.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/vgg/16/caffe/vgg16.caffemodel || echo "[ERROR!] Can not found \"vgg16.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/vgg/16/caffe/vgg16.prototxt || echo "[ERROR!] Can not found \"vgg16.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/vgg/16/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/vgg/16/caffe/vgg16.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/vgg/16/caffe" --input_proto "${MODEL_LOC}/classification/vgg/16/caffe/vgg16.prototxt" --data_type "${FPV}" --input_shape=[1,3,224,224] --input=data --mean_values=data[103.939,116.779,123.68] --output=prob
		;;
		"vgg19.caffemodel")
			target $2
			test -e ${MODEL_LOC}/classification/vgg/19/caffe/vgg19.caffemodel || echo "[ERROR!] Can not found \"vgg19.caffemodel\" !!!"
			test -e ${MODEL_LOC}/classification/vgg/19/caffe/vgg19.prototxt || echo "[ERROR!] Can not found \"vgg19.prototxt\" !!!"

			mkdir -p ${MODEL_LOC}/../../ir/${FPV}/classification/vgg/19/caffe
			python3 ${MO_LOC}/mo.py --input_model "${MODEL_LOC}/classification/vgg/19/caffe/vgg19.caffemodel" --output_dir "${MODEL_LOC}/../../ir/${FPV}/classification/vgg/19/caffe" --input_proto "${MODEL_LOC}/classification/vgg/19/caffe/vgg19.prototxt" --data_type "${FPV}" --input_shape=[1,3,224,224] --input=data --mean_values=data[103.939,116.779,123.68] --output=prob
		;;
	esac
}



echo $1
case $1 in
	"-help")
	;;
	"-list")
	;;
	"-m")
		MO $2 $3
	;;
	*)
	;;
esac