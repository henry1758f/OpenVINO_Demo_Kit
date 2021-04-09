#!/bin/bash
# File: sample_build.sh

dashes="\n\n###################################################\n\n"
# Build Inference Engine samples
C_SAMPLE_DIR=${InferenceEngine_DIR}/../samples/c
CPP_SAMPLE_DIR=${InferenceEngine_DIR}/../samples/cpp
DEMO_DIR=${InferenceEngine_DIR}/../demos
printf "${dashes}"
printf "Build Inference Engine samples (C)"
printf "${dashes}"
${C_SAMPLE_DIR}/build_samples.sh
printf "${dashes}"
printf "Build Inference Engine samples (C++)"
printf "${dashes}"
${CPP_SAMPLE_DIR}//build_samples.sh
printf "${dashes}"
printf "Build Inference Engine Demos "
printf "${dashes}"
${DEMO_DIR}/build_demos.sh
