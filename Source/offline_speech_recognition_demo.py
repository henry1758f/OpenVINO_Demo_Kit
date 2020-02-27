# File: offline_speech_recognition_demo.py
# 2020/02/15	henry1758f 1.0.0	First Create

import json
import os
import string 
import sys

current_path = os.path.abspath(os.getcwd())
yml_modelinfo_path = os.path.expandvars('${INTEL_OPENVINO_DIR}/data_processing/audio/speech_recognition/models/lspeech_s5_ext/lspeech_s5_ext.yml')
model_path = os.path.expanduser('~/openvino_models/models/SYNNEX_demo/')
ir_model_path = os.path.expanduser('~/openvino_models/ir/')
modeldownloader_path = os.path.expandvars('${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/downloader.py')
demo_code_path = os.path.expandvars('${INTEL_OPENVINO_DIR}/data_processing/audio/speech_recognition/')
build_path = os.path.expanduser('~/inference_engine_demos_build/data_processing_demos_build/audio/speech_recognition/')
demo_path = build_path + 'intel64/Release/offline_speech_recognition_app'

model_name = 'lspeech_s5_ext'
test_audio_path = current_path + '/Source/testing_source/'
config_path = ir_model_path + 'intel/lspeech_s5_ext/FP32/speech_lib.cfg'
config_template_path = ir_model_path + 'intel/lspeech_s5_ext/FP32/speech_recognition_config.template'

default_source = os.path.expandvars('${INTEL_OPENVINO_DIR}/deployment_tools/demo/how_are_you_doing.wav')
default_arg = ' -wave=' + default_source #+ \
#' -c=' + config_path #+ \
#' -d CPU '

if not os.path.isfile(demo_path):	
	print('[ WARNING ] No offline_speech_recognition_app ! Try to compile... \n')
	os.system("mkdir -p " + build_path + ' && cd ' +  build_path + ' && cmake -DCMAKE_BUILD_TYPE=Release ' + demo_code_path + ' && make -j2')
	if not os.path.isfile(demo_path):
		print('[ ERROR ] offline_speech_recognition_app compile error! Cannot run Demo.')
		sys.exit(1)

if not os.path.isfile(config_path):
	print('[ WARNING ] No speech_lib.cfg ! Try to download... \n')
	os.system('python3 ' + modeldownloader_path + ' --name ' + lspeech_s5_ext + ' --output_dir ' + ir_model_path + ' --config ' + yml_modelinfo_path )
	makeconfig_str = ['echo "#Speech recognition configuration file" > ' + config_template_path ,\
	'sed "s|__MODELS_ROOT__|' + os.path.dirname(config_path) + '\\/|g"' + config_template_path + ' >> ' + config_path ,\
	'sed -i \'s/\\\\/\\//g\'' +  config_path]
	for makeconfig in makeconfig_str:
		print('>| ' + makeconfig)
		os.system(makeconfig)	
	if not os.path.isfile(config_path):
		print('[ ERROR ] lspeech_s5_ext model and config download failed! Please check your network connection or disk space.')
		sys.exit(1)

def terminal_clean():
	os.system('clear')

def banner():
	print("|=========================================|")
	print("|     Offline Speech Recognition Demo     |")
	print("|=========================================|")
	print("|  Support OpenVINO " + os.popen('echo $VERSION_VINO').read() )
	print("")

def source_select():
	source = input(' \n\n[ For using default Source, just press ENTER, \n\tor typein the path to the source you want.]\n  >> ')
	return source

def excuting():
	arguments_string = ''
	excute_string = ''
	tmp_str = source_select()
	if tmp_str == '':
		print('[ INFO ] Using Default audio source: ' + default_source)
		arguments_string += default_arg
		tmp_str = default_source
	else:
		arguments_string += ' -wave=' + tmp_str
	excute_string =  demo_path + arguments_string + ' -c=' + config_path
	print('[ INFO ] Running > ' + excute_string)
	os.system(excute_string)
	print('[ INFO ] Now Playing :' + tmp_str)
	os.system('ffplay ' + tmp_str)

###########
terminal_clean()
banner()
excuting()
