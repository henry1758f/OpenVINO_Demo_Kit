#!/bin/bash
# File: sample_build.sh
# 2019/04/16	henry1758f 0.0.1	First Create
# 2019/07/15	henry1758f 0.0.2	Bug Fixed
# 2019/07/15	henry1758f 0.1.0	Fix the sample cannot be compile while there's no sample app folder

export SAMPLECODE_LOC="$HOME/inference_engine_samples_build"
printf "Run sudo -E apt -y install build-essential python3-pip virtualenv cmake libcairo2-dev libpango1.0-dev libglib2.0-dev libgtk2.0-dev libswscale-dev libavcodec-dev libavformat-dev libgstreamer1.0-0 gstreamer1.0-plugins-base\n"
    sudo -E apt update
    sudo -E apt -y install build-essential python3-pip virtualenv cmake libcairo2-dev libpango1.0-dev libglib2.0-dev libgtk2.0-dev libswscale-dev libavcodec-dev libavformat-dev libgstreamer1.0-0 gstreamer1.0-plugins-base
system_ver=`cat /etc/lsb-release | grep -i "DISTRIB_RELEASE" | cut -d "=" -f2`
printf "\nYou're running Ubuntu ${system_ver} >>>>>>>\n"
    if [ $system_ver = "18.04" ]; then
	printf "\n>>>>>>> install -y libpng-dev \n"
        sudo -E apt-get install -y libpng-dev
    else
	printf "\n>>>>>>> install -y libpng12-dev \n"
        sudo -E apt-get install -y libpng12-dev
    fi

printf "\nSTART BUILDING >>>>>>>\n"
test -e ${SAMPLE_LOC} && echo " Build location found" || /opt/intel/openvino/deployment_tools/demo/demo_squeezenet_download_convert_run.sh


cd $SAMPLECODE_LOC
echo $SAMPLECODE_LOC
make -j8
