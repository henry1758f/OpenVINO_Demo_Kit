# File: gesture_recognition_demo.py

import json
import os
import string 
import sys
from pathlib import Path

current_path = os.path.abspath(os.getcwd())
dump_modelinfo_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = str(Path.home()) + '/openvino_models/models/SYNNEX_demo/'
ir_model_path = str(Path.home()) + '/openvino_models/ir/'
python_demo_path = '${INTEL_OPENVINO_DIR}/inference_engine/demos/gesture_recognition_demo/python/'

test_image_path = current_path + '/Source/testing_source/'

asl_recognition_model = ['asl-recognition']
person_detection_model = ['person-detection-asl']

default_source = '0'
default_classmap= '${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/data/dataset_classes/msasl100.json'
default_arg = ' -m_a ' + model_path + 'intel/asl-recognition-0004/FP32/asl-recognition-0004.xml' + \
' -m_d ' + model_path + 'intel/person-detection-asl-0001/FP32/person-detection-asl-0001.xml' + \
' -c ' +  default_classmap +\
' -i ' + default_source + \
' -d CPU '

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
	print("|        Gesture Recognition Demo         |")
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
						if 'intel/' in item['subdirectory']:
							Path = model_path + item['subdirectory'] + '/' + str(precisions) + '/' + item['name'] + '.xml'
						elif 'public/' in item['subdirectory']:
							Path = ir_model_path + item['subdirectory'] + '/' + str(precisions) + '/' + item['name'] + '.xml'
						print('[ INFO ] [ ' + item['name'] + ' ][' + str(precisions) + '] been selected')
						print('> Path: ' + Path)
						return ' -m' + arg_tag + Path 
					elif select == '' :
						return ''

def source_select():
	source = input(' \n\n[ For using default Source, just press ENTER, \n\tor typein the path to the source you want.]\n  >> ')
	if source == '':
		return default_source
	else:
		return source



def excuting():
	global arguments_string
	arguments_string = ''
	source = default_source
	arguments_string += model0_select(asl_recognition_model,  ' [Select a America Sign Language(ASL) recognition model.]', '_a ')
	if arguments_string == '':
		print('[ INFO ] Load Default Configuration...')
		arguments_string = default_arg
	else:
		arguments_string += model0_select(person_detection_model,  ' [Select a Person Detection model.]', '_d ')
		select = input('Input the Path to a file with gesture classes. Or press ENTER for default  >> ')
		if select == '':
			arguments_string += ' -c ' + default_classmap
		else:
			arguments_string += ' -c ' + select
		arguments_string += ' -d ' + target_device_select()
		source = source_select()
		arguments_string += ' -i ' + source
	excute_string =  'python3 ' + python_demo_path + 'gesture_recognition_demo.py ' + arguments_string
	print('[ INFO ] Running > ' + excute_string)
	os.system(excute_string)


###########
terminal_clean()
banner()
excuting()
