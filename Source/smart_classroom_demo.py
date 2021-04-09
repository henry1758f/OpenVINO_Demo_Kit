# File: interactive_face_detection_demo.py

import json
import os
import string 
from pathlib import Path

current_path = os.path.abspath(os.getcwd())
dump_modelinfo_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = str(Path.home()) + '/openvino_models/models/SYNNEX_demo/'
ir_model_path = str(Path.home()) + '/openvino_models/ir/'

test_image_path = current_path + '/Source/testing_source/'
default_source_download_link = 'https://github.com/vadimadr/sample-videos.git -b va/add_action_recognition_sample'

face_detection_model = ['face-detection-adas','face-detection-retail']
landmarks_regression_retail_model = ['landmarks-regression-retail']
face_reidentification_retail_model = ['face-reidentification-retail']
action_recognition_model = ['person-detection-action-recognition','person-detection-raisinghand-recognition']

default_source = test_image_path + 'sample-videos/classroom.mp4'
default_arg = ' -m_fd ' + model_path + 'intel/face-detection-adas-0001/FP32/face-detection-adas-0001.xml' + \
' -m_lm ' + model_path + '/intel/landmarks-regression-retail-0009/FP32/landmarks-regression-retail-0009.xml' + \
' -m_act ' + model_path + '/intel/person-detection-action-recognition-0005/FP32/person-detection-action-recognition-0005.xml' + \
' -i ' + default_source + \
' -d_fd CPU -d_lm CPU -d_act CPU -t_ad 0.5 -t_ar 0.1 -t_fd 0.1'

if os.path.isfile(jsontemp_path):
	os.system('rm -r ' + jsontemp_path)
os.system(dump_modelinfo_path + " --all >> " + jsontemp_path)

def check_jsontemp_exist():
	if not os.path.isfile(jsontemp_path):
		print('[ ERROR ] ' + jsontemp_path + ' is not exist! ')
		return False
	else:
		return True

def terminal_clean():
	os.system('clear')

def banner():
	print("|=========================================|")
	print("|           smart_classroom_demo          |")
	print("|=========================================|")
	print("|  Support OpenVINO " + os.popen('echo $VERSION_VINO').read() )
	print("")

def target_device_select():
	return input('\n [Typein the target device for inference this model (CPU,GPU,MYRIAD,HDDL,etc.)]  >> ')

def precisions_select(precisions_item,name):
	i = 0
	for result in precisions_item:
		i += 1
		print(str(i) + '. [' + result + ']' )
	else:
		keyin = input('\n [Select precisions of the model "' + name + '"]  >>')
		i = 0
		for result in precisions_item:
			i += 1
			if str(i) == keyin or keyin == result:
				return result
				break
		else:
			print('[ ERROR ] ')
			return


def model0_select(dldt_search_str, welcome_str, arg_tag):
	print(welcome_str)
	if check_jsontemp_exist() :
		global jsonObj_Array
		with open(jsontemp_path,'r') as input_file:
			jsonObj_Array = json.load(input_file)
		i = 0
		print('\n===== Model List =====')
		for name in dldt_search_str:
			for item in jsonObj_Array:
				if name in item['name']:
					i += 1
					precisions_string = ''
					for precisions in item['precisions']:
						precisions_string = precisions_string + '[' + precisions +']'
					print(str(i) + '. ' + item['name'] + '\t\t' + precisions_string + '\n\t\t[' + item['framework'] + '] ' + item['description'] )
	select = input('Select a number Or input a path to your model  >> ')
	if check_jsontemp_exist() :
		i = 0
		for name in dldt_search_str:
			for item in jsonObj_Array:
				if name in item['name']:
					i += 1
					if str(i) == select:
						precisions = precisions_select(item['precisions'],item['name'])
						device = target_device_select()
						if 'intel/' in item['subdirectory']:
							Path = model_path + item['subdirectory'] + '/' + str(precisions) + '/' + item['name'] + '.xml'
						elif 'public/' in item['subdirectory']:
							Path = ir_model_path + item['subdirectory'] + '/' + str(precisions) + '/' + item['name'] + '.xml'
						print('[ INFO ] [ ' + item['name'] + ' ][' + str(precisions) + '] been selected')
						print('> Path: ' + Path)
						return ' -m' + arg_tag + Path + ' -d' + arg_tag + device
					elif select == '' :
						return ''

def source_select(default_trig):
	source = ''
	if not default_trig:
		source = input(' \n\n[ input "cam" for using camera as inference source, \n\tfor using default Source, just press ENTER, \n\tor typein the path to the video source you want. ]\n  >> ')
	if source == '':
		if os.path.isfile(default_source):	
			return default_source
		else:
			choose = input(' [The default video source is from "vadimadr/sample-videos" on Github, do you want to clone the repository (about 378MB) now? (y/n) ]\n  >> ')
			if choose == 'n' or choose == 'N' or choose == 'No' or choose == 'NO':
				print('[INFO] There is no available default video! Please input a video path. ')
				if default_trig:
					sys.exit(1)
				source_select(False)
				return
			else:
				os.system('git clone ' + default_source_download_link + ' ' + test_image_path + '/sample-videos' )
				if os.path.isfile(default_source):	
					return default_source
				else:
					print('[ ERROR ] Download Failed ! Please check the internet connection and try again! \n')
					sys.exit(1)
	else:
		return source

def excuting():
	global arguments_string
	arguments_string = ''
	arguments_string += model0_select(face_detection_model,  ' [Select a Face Detection model.]', '_fd ')
	if arguments_string == '':
		print('[ INFO ] Load Default Configuration...')
		arguments_string = default_arg
		source_select(True)
	else:
		select_str = ''
		select_str == model0_select(landmarks_regression_retail_model,  ' [Select a Facial Landmarks Regression model.]', '_lm ')
		if select_str == '':
			select_str = ' -m_lm ' + model_path + '/intel/landmarks-regression-retail-0009/FP32/landmarks-regression-retail-0009.xml'
		arguments_string += select_str
#		select_str == model0_select(face_reidentification_retail_model,  ' [Select a Face Reidentification model.]', '_reid ')
#		if select_str == '':
#			select_str = ' -m_reid ' + model_path + '/intel/face-reidentification-retail-0095/FP32/face-reidentification-retail-0095.xml'
#		arguments_string += select_str
		select_str == model0_select(action_recognition_model,  ' [Select a Action Recognition model.]', '_act ')
		if select_str == '':
			select_str = ' -m_act ' + model_path + '/intel/person-detection-action-recognition-0005/FP32/person-detection-action-recognition-0005.xml'
		arguments_string += select_str
		arguments_string += ' -i ' + source_select(False)
	excute_string =  '$DEMO_LOC/smart_classroom_demo' + arguments_string
	print('[ INFO ] Running > ' + excute_string)
	os.system(excute_string)

###########
terminal_clean()
banner()
excuting()
