# File: crossroad_camera_demo.py

import json
import os
import string 
from pathlib import Path

current_path = os.path.abspath(os.getcwd())
dump_modelinfo_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = str(Path.home()) + '/openvino_models/models/SYNNEX_demo/'
ir_model_path = str(Path.home()) + '/openvino_models/ir/'

person_vehicle_bike_detection_model = ['person-vehicle-bike-detection-crossroad']
person_attributes_recognition_model = ['person-attributes-recognition-crossroad']
person_reidentification_model = ['person-reidentification-retail']

default_source = '0'
default_arg = ' -m ' + model_path + 'intel/person-vehicle-bike-detection-crossroad-0078/FP32/person-vehicle-bike-detection-crossroad-0078.xml' + \
' -m_pa ' + model_path + '/intel/person-attributes-recognition-crossroad-0230/FP32/person-attributes-recognition-crossroad-0230.xml' + \
' -m_reid ' + model_path + '/intel/person-reidentification-retail-0287/FP32/person-reidentification-retail-0287.xml' + \
' -i ' + default_source + \
' -d CPU -d_pa CPU -d_reid CPU '

if os.path.isfile(jsontemp_path):
	os.system('rm -r ' + jsontemp_path)
os.system(dump_modelinfo_path + " --all >> " + jsontemp_path)

def check_jsontemp_exist():
	if not os.path.isfile(jsontemp_path):
		print('[ERROR] ' + jsontemp_path + ' is not exist! ')
		return False
	else:
		return True

def terminal_clean():
	os.system('clear')

def banner():
	print("|=========================================|")
	print("|          crossroad_camera_demo          |")
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
			print('[ERROR] ')
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
						print('[INFO] [ ' + item['name'] + ' ][' + str(precisions) + '] been selected')
						print('> Path: ' + Path)
						person_label = ''
						if "person-vehicle-bike-detection-crossroad-1016" in item['name']:
							person_label = ' -person_label 2'
						return ' -m' + arg_tag + Path + ' -d' + arg_tag + device + person_label
					elif select == '' :
						return ''

def source_select():
	source = input(' \n\n[ input camera number as inference source, \n\tfor using default Source, just press ENTER, \n\tor typein the path to the source you want. \nSupport multiple source by "<source1> <source2> <source3>... ]\n  >> ')
	if source == '':
		return default_source
	else:
		return source

def excuting():
	global arguments_string
	arguments_string = ''
	arguments_string += model0_select(person_vehicle_bike_detection_model,  ' [Select a Person,Vehicle and Bike detection model.]', ' ')
	if arguments_string == '':
		print('[INFO] Load Default Configuration...')
		arguments_string = default_arg
	else:
		arguments_string += model0_select(person_attributes_recognition_model,  ' [Select a Person Attributes recognition model.]', '_pa ')
		arguments_string += model0_select(person_reidentification_model,  ' [Select a Person Reidentification model.]', '_reid ')
		arguments_string += ' -i ' + source_select()
	excute_string =  '$DEMO_LOC/crossroad_camera_demo' + arguments_string
	print('[INFO] Running > ' + excute_string)
	os.system(excute_string)

###########
terminal_clean()
banner()
excuting()
