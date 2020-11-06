#!/bin/bash
# File: sample_build.sh

source /opt/intel/openvino/bin/setupvars.sh
dashes="\n\n###################################################\n\n"
# Build Inference Engine samples
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


# Build Inference Engine demos
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
