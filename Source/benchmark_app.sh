# File: benchmark_app.sh
# 2019/07/26	henry1758f 0.0.1	First Create

export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="$HOME/inference_engine_samples_build/intel64/Release"
export MODEL_LOC=$HOME/openvino_models/models/SYNNEX_demo
select_inf=" >> CPU,GPU,MYRIAD(FP16),HDDL(FP16),HETERO...Please choose your target device."

function banner_show()
{
	echo "|=========================================|"
	echo "|              Benchmark App              |"
	echo "|=========================================|"
	echo "|  Support OpenVINO $VERSION_VINO"
	echo ""
}

clear
banner_show