# File: smart_classroom_demo.sh
# 2019/05/06	henry1758f 0.0.1	First Create
# 2019/07/19	henry1758f 1.0.0	Add int8 model options and quick demo trick
# 2019/07/26	henry1758f 2.0.0	Fit openVINO v2019.2.242
# 2019/07/26	henry1758f 2.0.1	Improved Output information 

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export DEMO_LOC="$HOME/inference_engine_demos_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."

function banner_show()
{
	echo "|=========================================|"
	echo "|           smart_classroom_demo          |"
	echo "|=========================================|"
}

function inference_D_choose()
{
	echo "$select_inf"
	read TARGET_0
}
function model_0_choose()
{
	echo " [Select a Face Detection model.]"
	echo " >> 1. face-detection-adas-0001.xml 	[FP32] "
	echo " >> 2. face-detection-adas-0001.xml 	[FP16] "
	echo " >> 3. face-detection-adas-0001.xml 	[INT8] "
	echo " >> 4. face-detection-adas-0001.xml 	[INT1] "
	echo " >> 5. face-detection-retail-0004.xml 	[FP32] "
	echo " >> 6. face-detection-retail-0004.xml 	[FP16] "
	echo " >> 7. face-detection-retail-0004.xml 	[INT8] "
	echo " >> 8. face-detection-retail-0005.xml 	[FP32] "
	echo " >> 9. face-detection-retail-0005.xml 	[FP16] "
	echo " >>10. face-detection-retail-0005.xml 	[INT8] "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " face-detection-adas-0001.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/FP32/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"2")
			echo " face-detection-adas-0001.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/FP16/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"3")
			echo " face-detection-adas-0001.xml 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/INT8/face-detection-adas-0001.xml
			inference_D_choose
		;;
		"4")
			echo " face-detection-adas-0001.xml 	[INT1] ->"
			MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights_binary/dldt/INT1/face-detection-adas-binary-0001.xml
			inference_D_choose
		;;
		"5")
			echo " face-detection-retail-0004.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/sqnet1.0modif-ssd/0004/dldt/FP32/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"6")
			echo " face-detection-retail-0004.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/sqnet1.0modif-ssd/0004/dldt/FP16/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"7")
			echo " face-detection-retail-0004.xml 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/sqnet1.0modif-ssd/0004/dldt/INT8/face-detection-retail-0004.xml
			inference_D_choose
		;;
		"8")
			echo " face-detection-retail-0005.xml 	[FP32] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/mobilenet_v2/0005/dldt/FP32/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"9")
			echo " face-detection-retail-0005.xml 	[FP16] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/mobilenet_v2/0005/dldt/FP16/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"10")
			echo " face-detection-retail-0005.xml 	[INT8] ->"
			MODEL_LOC_0=${MODEL_LOC}/Retail/object_detection/face/mobilenet_v2/0005/dldt/INT8/face-detection-retail-0005.xml
			inference_D_choose
		;;
		"0")
			return 1
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_0=${choose}
			inference_D_choose
			;;
	esac
}

function source_choose()
{
	echo " >> input \"cam\" for using camera as inference source,\"0\" for default Source, or typein the path to the source you want."
	read I_SOURCE
	case $I_SOURCE in
		"0")
			echo "Model PATH [Default]= cam"
			I_SOURCE=cam
		;;
		*)
			echo " Model PATH=${I_SOURCE}"
			;;
	esac
}

function inference_D1_choose()
{
	echo "$select_inf"
	read TARGET_1
	MODEL_LOC_1="${MODEL_LOC_1} -d_lm ${TARGET_1}"
}
function model_1_choose()
{
	echo " [Select a Person Attributes recognition model.]"
	echo " >> 1. landmarks-regression-retail-0009.xml 	[FP32] "
	echo " >> 2. landmarks-regression-retail-0009.xml 	[FP16] "
	echo " >> Or input a path to your model "
	local choose
	read choose
	case $choose in
		"1")
			echo " landmarks-regression-retail-0009.xml 	[FP32] ->"
			MODEL_LOC_1="-m_lm ${MODEL_LOC}/Retail/object_attributes/landmarks_regression/0009/dldt/FP32/landmarks-regression-retail-0009.xml"
			inference_D1_choose
		;;
		"2")
			echo " landmarks-regression-retail-0009.xml 	[FP16] ->"
			MODEL_LOC_1="-m_lm ${MODEL_LOC}/Retail/object_attributes/landmarks_regression/0009/dldt/FP16/landmarks-regression-retail-0009.xml"
			inference_D1_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_1="-m_lm ${choose}"
			inference_D_choose
			;;
	esac
}

function inference_D2_choose()
{
	echo "$select_inf"
	read TARGET_2
	MODEL_LOC_2="${MODEL_LOC_2} -d_reid ${TARGET_2}"
}
function model_2_choose()
{
	echo " [Select a Person Reidentification model.]"
	echo " >> 1. face-reidentification-retail-0095.xml 	[FP32] "
	echo " >> 2. face-reidentification-retail-0095.xml 	[FP16] "
	echo " >> Or input a path to your model "

	local choose
	read choose
	case $choose in
		"1")
			echo " face-reidentification-retail-0095.xml 	[FP32] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/face/mobilenet_based/dldt/FP32/face-reidentification-retail-0095.xml"
			inference_D2_choose
		;;
		"2")
			echo " face-reidentification-retail-0095.xml 	[FP16] ->"
			MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/face/mobilenet_based/dldt/FP16/face-reidentification-retail-0095.xml"
			inference_D2_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_2="-m_reid ${choose}"
			inference_D_choose
			;;
	esac
}

function inference_D3_choose()
{
	echo "$select_inf"
	read TARGET_3
	MODEL_LOC_3="${MODEL_LOC_3} -d_act ${TARGET_3}"
}
function model_3_choose()
{
	echo " [Select a Emotions recognition model.]"
	echo " >> 1. person-detection-action-recognition-0005.xml 	[FP32]  >(sitting, standing, raising hand)"
	echo " >> 2. person-detection-action-recognition-0005.xml 	[FP16]  >(sitting, standing, raising hand)"
	echo " >> 3. person-detection-action-recognition-0005.xml 	[INT8]  >(sitting, standing, raising hand)"
	echo " >> 4. person-detection-action-recognition-0006.xml 	[FP32]  >(sitting, writing, raising hand, standing, turned around, lie on the desk)"
	echo " >> 5. person-detection-action-recognition-0006.xml 	[FP16]  >(sitting, writing, raising hand, standing, turned around, lie on the desk)"
	echo " >> 6. person-detection-action-recognition-0006.xml 	[INT8]  >(sitting, writing, raising hand, standing, turned around, lie on the desk)"
	echo " >> 7. person-detection-raisinghand-recognition-0001.xml 	[FP32]  >(raising hand or not)"
	echo " >> 8. person-detection-raisinghand-recognition-0001.xml 	[FP16]  >(raising hand or not)"
	echo " >> 9. person-detection-action-recognition-teacher-0002.xml 	[FP32]  >(Standing, writing, demonstrating )"
	echo " >>10. person-detection-action-recognition-teacher-0002.xml 	[FP16]  >(Standing, writing, demonstrating )"
	echo " >> Or input a path to your model "

	local choose
	read choose
	case $choose in
		"1")
			echo " person-detection-action-recognition-0005.xml 	[FP32] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0165/dldt/FP32/person-detection-action-recognition-0005.xml"
			inference_D3_choose
		;;
		"2")
			echo " person-detection-action-recognition-0005.xml 	[FP16] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0165/dldt/FP16/person-detection-action-recognition-0005.xml"
			inference_D3_choose
		;;
		"3")
			echo " person-detection-action-recognition-0005.xml 	[INT8] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0165/dldt/INT8/person-detection-action-recognition-0005.xml"
			inference_D3_choose
		;;
		"4")
			echo " person-detection-action-recognition-0006.xml 	[FP32] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0028_tf/dldt/FP32/person-detection-action-recognition-0006.xml"
			inference_D3_choose
		;;
		"5")
			echo " person-detection-action-recognition-0006.xml 	[FP16] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0028_tf/dldt/FP16/person-detection-action-recognition-0006.xml"
			inference_D3_choose
		;;
		"6")
			echo " person-detection-action-recognition-0006.xml 	[INT8] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0028_tf/dldt/INT8/person-detection-action-recognition-0006.xml"
			inference_D3_choose
		;;
		"7")
			echo " person-detection-raisinghand-recognition-0001.xml 	[FP32] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0165_cut_2cl/dldt/FP32/person-detection-raisinghand-recognition-0001.xml"
			inference_D3_choose
		;;
		"8")
			echo " person-detection-raisinghand-recognition-0001.xml 	[FP16] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0165_cut_2cl/dldt/FP16/person-detection-raisinghand-recognition-0001.xml"
			inference_D3_choose
		;;
		"9")
			echo " person-detection-action-recognition-teacher-0002.xml 	[FP32] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/teacher/rmnet_ssd/0005_cut/dldt/FP32/person-detection-action-recognition-teacher-0002.xml"
			inference_D3_choose
		;;
		"10")
			echo " person-detection-action-recognition-teacher-0002.xml 	[FP16] ->"
			MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/teacher/rmnet_ssd/0005_cut/dldt/FP16/person-detection-action-recognition-teacher-0002.xml"
			inference_D3_choose
		;;
		*)
			echo " Model PATH=${choose}"
			MODEL_LOC_3="-m_act ${choose}"
			inference_D_choose
			;;
	esac
}
function face_gallery()
{
	echo " > Creating a Gallery for Face Recognition "
	echo "To recognize faces on a frame, the demo needs a gallery of reference images. Each image should contain a tight crop of face. You can create the gallery from an arbitrary list of images:"
    echo "Put images containing tight crops of frontal-oriented faces to a separate empty folder. Each identity could have multiple images. Name images as id_name.0.png, id_name.1.png, ...."
    echo ""
    echo "If the Gallery folder and images created, please type your gallery folder location or skip it >"
    local choose
    read choose
    case $choose in
		"0")
			FG_LOC="-fg $HOME/Pictures/person/smart_classroom/test/faces_gallery.json"
			test -e $HOME/Pictures/person/smart_classroom/test/faces_gallery.json && echo " [Info] faces_gallery.json founded!" 
			test -e $HOME/Pictures/person/smart_classroom/test/faces_gallery.json || python3 /opt/intel/openvino/deployment_tools/inference_engine/demos/smart_classroom_demo/create_list.py $HOME/Pictures/person/smart_classroom/test
			test -e $HOME/Pictures/person/smart_classroom/test/faces_gallery.json || cp -r faces_gallery.json $HOME/Pictures/person/smart_classroom/test/
			test -e $HOME/Pictures/person/smart_classroom/test/faces_gallery.json || echo " [ERROR] faces_gallery.json not found and cannot create !!"
			test -e $HOME/Pictures/person/smart_classroom/test/faces_gallery.json || FG_LOC=""
		;;
	esac
}
function set_default()
{
	echo " All model will run on CPU... "
	MODEL_LOC_0=${MODEL_LOC}/Transportation/object_detection/face/pruned_mobilenet_reduced_ssd_shared_weights/dldt/FP16/face-detection-adas-0001.xml
	MODEL_LOC_1="-m_lm ${MODEL_LOC}/Retail/object_attributes/landmarks_regression/0009/dldt/FP16/landmarks-regression-retail-0009.xml"
	MODEL_LOC_2="-m_reid ${MODEL_LOC}/Retail/object_reidentification/face/mobilenet_based/dldt/FP16/face-reidentification-retail-0095.xml"
	MODEL_LOC_3="-m_act ${MODEL_LOC}/Retail/action_detection/pedestrian/rmnet_ssd/0028_tf/dldt/FP16/person-detection-action-recognition-0006.xml"
	I_SOURCE="cam"
	TARGET_0="CPU"
}
function set_others()
{
	model_1_choose
	model_2_choose
	model_3_choose
	face_gallery
	source_choose
}

clear
banner_show
model_0_choose && set_others || set_default	


cd $DEMO_LOC
ARGS=" -m_fd ${MODEL_LOC_0} -i ${I_SOURCE} -d_fd ${TARGET_0} ${MODEL_LOC_1} ${MODEL_LOC_2} ${MODEL_LOC_3} ${FG_LOC}"
echo "RUN ./smart_classroom_demo $ARGS"
./smart_classroom_demo $ARGS