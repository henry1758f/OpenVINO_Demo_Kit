#!/bin/bash
# File: OpenVINO_demo_SYNNEX.sh
# 2019/04/22	henry1758f 0.0.1	First Create
export INTEL_OPENVINO_DIR=/opt/intel/openvino/
export SAMPLE_LOC="/home/$(whoami)/inference_engine_samples_build/intel64/Release"

function banner_show()
{
	echo "|=========================================|"
	echo "|        security_barrier_camera_demo     |"
	echo "|=========================================|"
}

clear
banner_show

echo "Select Vehicle / License plate detection model >>>"
