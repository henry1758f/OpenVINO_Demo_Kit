#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh
# ver 0.0.1
# This is design for connecting to the share folder on TWNB17034
# 2018/09/07 	henry1758f	0.0.1 	first-create
# 2018/09/11	henry1758f	0.0.2	create security barrier camera demo
# 2018/12/03	henry1758f	0.0.3	Fix to meet OpenVINO R4 and add default config to demo1 and 2
# 2018/12/04	henry1758f	0.0.4	Completed the classification_demo, fixed bugs in model_chooser and path checking
# 2018/12/04	henry1758f	0.0.5	Add facial-landmarks in interactive_face_detection_demo
# 2018/12/05	henry1758f	1.0.0	Add Human Pose Estimation Demo feature and release to SYNNEX Team.
# 2018/12/05	henry1758f	1.0.1	Fix check_dir function Bugs.

export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples/intel64/Release"
export MODEL_LOC="/opt/intel/computer_vision_sdk/deployment_tools/intel_models"
export SETVAR="/opt/intel/computer_vision_sdk/bin/setupvars.sh"
export VERSION="1.0.1"
export VERSION_VINO="v2018.4.420"
function model_chooser_option_printer()
{
	echo "   1.  age-gender-recognition-retail-0013"
	echo "   2.  emotions-recognition-retail-0003"
	echo "   3.  face-detection-adas-0001"
	echo "   4.  face-detection-retail-0004"
	echo "   5.  face-person-detection-retail-0002"
	echo "  *6.  face-reidentification-retail-0071"
	echo "   7.  head-pose-estimation-adas-0001"
	echo "  *8.  landmarks-regression-retail-0009"
	echo "   9.  license-plate-recognition-barrier-0001"
	echo "   10. pedestrian-and-vehicle-detector-adas-0001"
	echo "   11. pedestrian-detection-adas-0002"
	echo "   12. person-attributes-recognition-crossroad-0031"
	echo "  *13. person-detection-action-recognition-0003"
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
	echo "  *25. facial-landmarks-35-adas-0001"
	echo "  *26. human-pose-estimation-0001"
	echo "  *27. single-image-super-resolution-0034"
}

function model_chooser()
{
	local choose 
	read choose
	case $choose in 
		"1")
			eval "$1=\"age-gender-recognition-retail-0013\""
			return
			;;
		"2")
			eval "$1=\"emotions-recognition-retail-0003\""
			return
			;;
		"3")
			eval "$1=\"face-detection-adas-0001\""
			return
			;;
		"4")
			eval "$1=\"face-detection-retail-0004\""
			return
			;;
		"5")
			eval "$1=\"face-person-detection-retail-0002\""
			return
			;;
		"6")
			eval "$1=\"face-reidentification-retail-0071\""
			return
			;;
		"7")
			eval "$1=\"head-pose-estimation-adas-0001\""
			return
			;;
		"8")
			eval "$1=\"landmarks-regression-retail-0009\""
			return
			;;
		"9")
			eval "$1=\"license-plate-recognition-barrier-0001\""
			return
			;;
		"10")
			eval "$1=\"pedestrian-and-vehicle-detector-adas-0001\""
			return
			;;
		"11")
			eval "$1=\"pedestrian-detection-adas-0002\""
			return
			;;
		"12")
			eval "$1=\"person-attributes-recognition-crossroad-0031\""
			return
			;;
		"13")
			eval "$1=\"person-detection-action-recognition-0003\""
			return
			;;
		"14")
			eval "$1=\"person-detection-retail-0001\""
			return
			;;
		"15")
			eval "$1=\"person-detection-retail-0013\""
			return
			;;
		"16")
			eval "$1=\"person-reidentification-retail-0031\""
			return
			;;
		"17")
			eval "$1=\"person-reidentification-retail-0076\""
			return
			;;
		"18")
			eval "$1=\"person-reidentification-retail-0079\""
			return
			;;
		"19")
			eval "$1=\"person-vehicle-bike-detection-crossroad-0078\""
			return
			;;
		"20")
			eval "$1=\"road-segmentation-adas-0001\""
			return
			;;
		"21")
			eval "$1=\"semantic-segmentation-adas-0001\""
			return
			;;
		"22")
			eval "$1=\"vehicle-attributes-recognition-barrier-0039\""
			return
			;;
		"23")
			eval "$1=\"vehicle-detection-adas-0002\""
			return
			;;
		"24")
			eval "$1=\"vehicle-license-plate-detection-barrier-0106\""
			return
			;;		
		"25")
			eval "$1=\"facial-landmarks-35-adas-0001\""
			return
		;;		
		"26")
			eval "$1=\"human-pose-estimation-0001\""
			return
		;;		
		"27	")
			eval "$1=\"single-image-super-resolution-0034\""
			return
		;;		
		"0")
			echo "[WARNING] You do not choose any IR model! "
			eval "$1=\"0\""
			return
			;;	
		*)
			if [ -f $choose ]; then
				#echo "$choose"
				echo " * Comfirm! "
				eval "$1=\"${choose}\""
				return
			else 
				echo "File $choose does not exits. "
				exit 1
			fi
			;;
		esac
	exit 1
}
function modelFP_chooser()
{
	echo "The Moddel Type is FP...?"
	local STR
	read STR
	eval "$1=\"$STR\""
}
function device_chooser()
{
	echo "The Inference Device? CPU?(FP32 only)  GPU?(FP32/16)   MYRIAD?(FP16 only) ->"
	local STR
	read STR
	eval "$1=\"$STR\""
}
function source_chooser()
{
	echo "Please input the path of the source, or type \"cam\" when using camera, or use \"1\" as default"
	local STR
	read STR
	case $STR in 
		"1")
			echo "source set to default..."
			eval "$1=\"dafault\""
			return
			;;
		"cam")
			echo "source set to camera..."
			eval "$1=\"cam\""
			return
			;;
		*)
			echo "source set to $STR..."
			eval "$1=\"$STR\""
			;;
	esac
}

function security_barrier_camera_demo()
{
	echo "|=========================================|"
	echo "|        Intel OpenVINO Demostration      |"
	echo "|        Inference Engine Sample Demo     |"
	echo "|       security_barrier_camera_demo   	|"
	echo "|=========================================|"
	model_chooser_option_printer
	#local model_D
	local model_M_FP
	local model_M_DV
	local model_M_VA
	local model_M_VA_FP
	local model_M_VA_DV
	local model_M_LPR
	local model_M_LPR_FP
	local model_M_LPR_VA
	local model_LoadSTR
	echo " Choose the model -m or use default setting by \"0\"..."
	model_chooser model_M
	if [ "$model_M" != "0" ]; then
		echo "=>$model_M "
		modelFP_chooser model_M_FP
		device_chooser model_M_DV

		echo " Choose the model -m_va..."
		model_chooser model_M_VA
		echo "=>$model_M_VA "
		modelFP_chooser model_M_VA_FP
		device_chooser model_M_VA_DV

		echo " Choose the model -m_lpr..."
		model_chooser model_M_LPR
		echo "=>$model_M_LPR "
		modelFP_chooser model_M_LPR_FP
		device_chooser model_M_LPR_DV
	else
		model_M="vehicle-license-plate-detection-barrier-0106"
		model_M_FP="32"
		model_M_DV="CPU"
		model_M_VA="vehicle-attributes-recognition-barrier-0039"
		model_M_VA_FP="32"
		model_M_VA_DV="CPU"
		model_M_LPR="license-plate-recognition-barrier-0001"
		model_M_LPR_FP="32"
		model_M_LPR_DV="CPU"
	fi

	#echo $model_D
	if ! source $SETVAR ; then
		prontf "ERROR!"
		exit 1
	fi

	echo "[SYNNEX_DEBUG] model_va = $model_M_VA ; model_lpr = $model_M_LPR"

	if [ "${model_M_VA}" != "0" ]; then
		model_LoadSTR=${model_LoadSTR}" -m_va "${MODEL_LOC}/${model_M_VA}/FP${model_M_VA_FP}/${model_M_VA}".xml -d_va ${model_M_VA_DV} "
	fi
	if [ "${model_M_LPR}" != "0" ]; then
		model_LoadSTR=${model_LoadSTR}" -m_lpr "${MODEL_LOC}/${model_M_LPR}/FP${model_M_LPR_FP}/${model_M_LPR}".xml -d_lpr ${model_M_LPR_DV}"
	fi

	source $SETVAR	
	cd $SAMPLE_LOC
	printf "Run ./security_barrier_camera_demo -m $MODEL_LOC/$model_M/FP${model_M_FP}/$model_M.xml $model_LoadSTR -d CPU -i /opt/intel/computer_vision_sdk/deployment_tools/demo/car_1.bmp\n"
	./security_barrier_camera_demo -m $MODEL_LOC/$model_M/FP${model_M_FP}/$model_M.xml $model_LoadSTR -d $model_M_DV -i /opt/intel/computer_vision_sdk/deployment_tools/demo/car_1.bmp

}
function interactive_face_detection_demo()
{
	echo "|=========================================|"
	echo "|        Intel OpenVINO Demostration      |"
	echo "|        Inference Engine Sample Demo     |"
	echo "|     interactive_face_detection_demo   	|"
	echo "|=========================================|"
	model_chooser_option_printer
	local model_M_FP
	local model_M_DV
	local model_M_AG
	local model_M_AG_FP
	local model_M_AG_DV
	local model_M_HP
	local model_M_HP_FP
	local model_M_HP_DV
	local model_M_EM
	local model_M_EM_FP
	local model_M_EM_DV
	local model_M_LM
	local model_M_LM_FP
	local model_M_LM_DV

	local model_LoadSTR
	echo " Choose the model -m or use default setting by \"0\"..."
	model_chooser model_M
	echo "=>$model_M "
	if [ "$model_M" != "0" ]; then

		modelFP_chooser model_M_FP
		device_chooser model_M_DV
		echo " Choose the model -m_ag..."
		model_chooser model_M_AG
		echo "=>$model_M_AG "
		modelFP_chooser model_M_AG_FP
		device_chooser model_M_AG_DV
		echo " Choose the model -m_hp..."
		model_chooser model_M_HP
		echo "=>$model_M_HP "
		modelFP_chooser model_M_HP_FP
		device_chooser model_M_HP_DV
		echo " Choose the model -m_em..."
		model_chooser model_M_EM
		echo "=>$model_M_EM "
		modelFP_chooser model_M_EM_FP
		device_chooser model_M_EM_DV
		echo " Choose the model -m_lm..."
		model_chooser model_M_LM
		echo "=>$model_M_LM "
		modelFP_chooser model_M_LM_FP
		device_chooser model_M_LM_DV
	else
		model_M="face-detection-retail-0004"
		model_M_FP="32"
		model_M_DV="CPU"
		model_M_AG="age-gender-recognition-retail-0013"
		model_M_AG_FP="32"
		model_M_AG_DV="CPU"
		model_M_HP="head-pose-estimation-adas-0001"
		model_M_HP_FP="32"
		model_M_HP_DV="CPU"
		model_M_EM="emotions-recognition-retail-0003"
		model_M_EM_FP="32"
		model_M_EM_DV="CPU"
		model_M_LM="facial-landmarks-35-adas-0001"
		model_M_LM_FP="32"
		model_M_LM_DV="CPU"
	fi

	if ! source $SETVAR ; then
		prontf "ERROR!"
		exit 1
	fi

	if [ "${model_M_AG}" != "0" ]; then
		model_LoadSTR=${model_LoadSTR}" -m_ag "${MODEL_LOC}/${model_M_AG}/FP${model_M_AG_FP}/${model_M_AG}".xml -d_ag ${model_M_AG_DV}"
	fi
	if [ "${model_M_HP}" != "0" ]; then
		model_LoadSTR=${model_LoadSTR}" -m_hp "${MODEL_LOC}/${model_M_HP}/FP${model_M_HP_FP}/${model_M_HP}".xml -d_hp ${model_M_HP_DV}"
	fi
	if [ "${model_M_EM}" != "0" ]; then
		model_LoadSTR=${model_LoadSTR}" -m_em "${MODEL_LOC}/${model_M_EM}/FP${model_M_EM_FP}/${model_M_EM}".xml -d_em ${model_M_EM_DV}"
	fi
	if [ "${model_M_LM}" != "0" ]; then
		model_LoadSTR=${model_LoadSTR}" -m_lm "${MODEL_LOC}/${model_M_LM}/FP${model_M_LM_FP}/${model_M_LM}".xml -d_em ${model_M_EM_DV}"
	fi

	source $SETVAR	
	cd $SAMPLE_LOC
	printf "Run ./interactive_face_detection_demo -m $MODEL_LOC/$model_M/FP${model_M_FP}/$model_M.xml $model_LoadSTR -d ${model_M_DV} -i cam\n"
	./interactive_face_detection_demo -m $MODEL_LOC/$model_M/FP32/$model_M.xml $model_LoadSTR -d CPU -i cam
}

function classification_demo()
{
	echo "|=========================================|"
	echo "|        Intel OpenVINO Demostration      |"
	echo "|        Inference Engine Sample Demo     |"
	echo "|            classification_demo   		|"
	echo "|=========================================|"
	
	local model_M_FP
	local model_M_DV
	local Demo_Source
	local model_LoadSTR
	local model_M
	echo "Type the path of the model you want to use, \"0\" to default"
	model_chooser model_M
	if [ "$model_M" != "0" ]; then
		device_chooser model_M_DV
		source_chooser Demo_Source
	else
		model_M_FP=32
		model_M_DV=CPU
		model_M=/home/$(whoami)/openvino_models/ir/squeezenet1.1/FP32/squeezenet1.1.xml
		Demo_Source=/opt/intel/computer_vision_sdk/deployment_tools/demo/car.png
	fi
	source $SETVAR	
	cd $SAMPLE_LOC
	printf "Run ./classification_sample -m ${MODEL_M} -d ${model_M_DV} -i ${Demo_Source}\n"
	./classification_sample -m ${model_M} -d ${model_M_DV} -i ${Demo_Source}

}

function Human_Pose_Estimation_Demo()
{
	echo "|=========================================|"
	echo "|        Intel OpenVINO Demostration      |"
	echo "|        Inference Engine Sample Demo     |"
	echo "|       	Human_Pose_Estimation_Demo   	|"
	echo "|=========================================|"
	model_chooser_option_printer
	#local model_D
	local model_M
	local model_M_FP
	local model_M_DV
	local model_LoadSTR
	echo " Choose the model -m or use default setting by \"0\"..."
	model_chooser model_M
	if [ "$model_M" != "0" ]; then
		echo "=>$model_M "
		modelFP_chooser model_M_FP
		device_chooser model_M_DV
	else
		model_M="human-pose-estimation-0001"
		model_M_FP="32"
		model_M_DV="CPU"
	fi

	#echo $model_D
	if ! source $SETVAR ; then
		prontf "ERROR!"
		exit 1
	fi
	source $SETVAR	
	cd $SAMPLE_LOC
	printf "Run ./human_pose_estimation_demo -m $MODEL_LOC/$model_M/FP${model_M_FP}/$model_M.xml $model_LoadSTR -d CPU -i /opt/intel/computer_vision_sdk/deployment_tools/demo/car_1.bmp\n"
	./human_pose_estimation_demo -m $MODEL_LOC/$model_M/FP${model_M_FP}/$model_M.xml -d $model_M_DV -i "cam"
}

function feature_choose()
{
	echo " 1. Inference Engine Sample Demo."
	echo " 2. Model Optimizer Demo.(TBD)"
	local choose
	read choose
	case $choose in
		"1")
			Inference_Engine_Sample_List
		;;
		"2")
			echo "Sorry, The Model Optimizer Demo isn't ready..."
			;;
		*)
			echo "Please input a vailed number"
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
	echo "  1. security_barrier_camera_demo"
	echo "  2. interactive_face_detection_demo"
	echo "  3. classification_demo"
	echo "  4. Human Pose Estimation Demo."
	local choose
	read choose
	case $choose in
		"1")
			echo " You choose security_barrier_camera_demo ->"
			security_barrier_camera_demo
			;;
		"2")
			echo " You choose interactive_face_detection_demo"
			interactive_face_detection_demo
			;;
		"3")
			echo " You choose interactive_face_detection_demo"
			classification_demo
			;;
		"4")
			echo " You choose Human Pose Estimation Demo"
			Human_Pose_Estimation_Demo
			;;
		*)
			echo "Please input a vailed number"
			;;
	esac
}

function check_dir()
{
	local locchk
	local infp
	locchk="1"
	test -e ${SAMPLE_LOC} || echo "${SAMPLE_LOC} is not exist !!!(<R3)" || echo "Checking OpenVINO R2 version Location..." || locchk="0"
	if [ "${locchk}" = "0" ]; then
		export SAMPLE_LOC="/opt/intel/computer_vision_sdk/deployment_tools/inference_engine/samples/intel64/Release"
		test -e ${SAMPLE_LOC} || echo "${SAMPLE_LOC} is not exist !!!" && return 
		echo "We Can't find the inference Engine application path. Please Input the path by yourself."
		read infp
		test -e ${infp} || echo "${SAMPLE_LOC} is not exist !!!" && exit 1
	fi
}


echo
echo "|=========================================|"
echo "|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |"
echo "|                                         |"
echo "|        Intel OpenVINO Demostration      |"
echo "|=========================================|"
echo "  Ver. $VERSION | Support OpenVINO $VERSION_VINO"
echo ""
echo ""

check_dir
feature_choose

exit 0