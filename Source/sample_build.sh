#!/bin/bash
# File: sample_build.sh
# 2019/04/16	henry1758f 0.0.1	First Create
# 2019/07/15	henry1758f 0.0.2	Bug Fixed
# 2019/07/15	henry1758f 0.1.0	Fix the sample cannot be compile while there's no sample app folder
# 2019/07/25	henry1758f 1.0.0	Fit OpenVINO 2019R2
# 2020/02/07	henry1758f 1.1.0	Fit OpenVINO 2020.1

source /opt/intel/openvino/bin/setupvars.sh
dashes="\n\n###################################################\n\n"
# Step 4. Build samples
printf "${dashes}"
printf "Build Inference Engine samples\n\n"

OS_PATH=$(uname -m)
NUM_THREADS="-j2"

if [ $OS_PATH == "x86_64" ]; then
  OS_PATH="intel64"
  NUM_THREADS="-j8"
fi

samples_path="${INTEL_OPENVINO_DIR}/deployment_tools/inference_engine/samples/cpp"
build_dir="$HOME/inference_engine_samples_build"
binaries_dir="${build_dir}/${OS_PATH}/Release"

if [ -e $build_dir/CMakeCache.txt ]; then
	rm -rf $build_dir/CMakeCache.txt
fi
mkdir -p $build_dir
cd $build_dir
cmake -DCMAKE_BUILD_TYPE=Release $samples_path

make $NUM_THREADS 


# Step 2. Build samples
printf "${dashes}"
printf "Build Inference Engine demos\n\n"

demos_path="${INTEL_OPENVINO_DIR}/deployment_tools/inference_engine/demos"

if ! command -v cmake &>/dev/null; then
    printf "\n\nCMAKE is not installed. It is required to build Inference Engine demos. Please install it. ${run_again}"
    exit 1
fi

OS_PATH=$(uname -m)
NUM_THREADS="-j2"

if [ $OS_PATH == "x86_64" ]; then
  OS_PATH="intel64"
  NUM_THREADS="-j8"
fi

build_dir="$HOME/inference_engine_demos_build"
if [ -e $build_dir/CMakeCache.txt ]; then
	rm -rf $build_dir/CMakeCache.txt
fi
mkdir -p $build_dir
cd $build_dir
cmake -DCMAKE_BUILD_TYPE=Release $demos_path
make $NUM_THREADS 


# Step 1. Build speech_recognition samples
printf "${dashes}"
printf "Build speech_recognition Demos\n\n"

demos_path="${INTEL_OPENVINO_DIR}/data_processing/audio/speech_recognition"

if ! command -v cmake &>/dev/null; then
    printf "\n\nCMAKE is not installed. It is required to build Inference Engine demos. Please install it. ${run_again}"
    exit 1
fi

OS_PATH=$(uname -m)
NUM_THREADS="-j2"

if [ $OS_PATH == "x86_64" ]; then
  OS_PATH="intel64"
  ARCH="x64"
  NUM_THREADS="-j8"
fi

build_dir="$HOME/data_processing_demos_build/audio/speech_recognition"
if [ -e $build_dir/CMakeCache.txt ]; then
    rm -rf $build_dir/CMakeCache.txt
fi
mkdir -p $build_dir
cd $build_dir
cmake -DCMAKE_BUILD_TYPE=Release $demos_path
make $NUM_THREADS