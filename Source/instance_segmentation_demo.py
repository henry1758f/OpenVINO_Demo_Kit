# File: instance_segmentation_demo.py
# 2020/02/12	henry1758f 1.0.0	First Create with python instead of script

import json
import os
import string 

current_path = os.path.abspath(os.getcwd())
dump_modelinfo_path = '/opt/intel/openvino/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = '~/openvino_models/models/SYNNEX_demo/'
ir_model_path = '~/openvino_models/ir/'

test_image_path = current_path + '/Source/testing_source/'
python_demo_path = '~/inference_engine_demos_build/intel64/Release/python_demos/instance_segmentation_demo/instance_segmentation_demo.py'
default_labels_path='/opt/intel/openvino/inference_engine/demos/python_demos/instance_segmentation_demo/coco_labels.txt'

instance_segmentation_model = ['instance-segmentation']

default_source = '0'
default_arg = ' -m ' + model_path + 'intel/instance-segmentation-security-0083/FP32/instance-segmentation-security-0083.xml' + \
' -i ' + default_source + \
' -d CPU ' + \
' --label ' + default_labels_path

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
	print("|       Instance Segmentation Demo        |")
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

def source_select():
	source = input(' \n\n[ For using default Source, just press ENTER, \n\tor typein the path to the source you want. \n]\n  >> ')
	if source == '':
		return default_source
	else:
		return source

def label_select():
	label = input('\n\n[ Please input the label path , for using coco_labels.txt,press ENTER(Default) ]\n  >> ')
	if label == '':
		return ' --label ' + default_labels_path
	else:
		return ' --label ' + label

def excuting():
	global arguments_string
	arguments_string = ''
	source = default_source
	label = default_labels_path
	arguments_string += model0_select(instance_segmentation_model,  ' [Select a Instance Segmentation model.]', ' ')
	if arguments_string == '':
		print('[ INFO ] Load Default Configuration...')
		arguments_string = default_arg
	else:
		label = label_select()
		source = source_select()
		arguments_string += ' -i ' + source + label
	excute_string =  'python3 ' + python_demo_path + arguments_string
	if not os.path.isfile(python_demo_path):
		os.system('cp -r /opt/intel/openvino/inference_engine/demos/python_demos $DEMO_LOC')
	print('[ INFO ] Running > ' + excute_string)
	os.system(excute_string)


###########
terminal_clean()
banner()
excuting()
