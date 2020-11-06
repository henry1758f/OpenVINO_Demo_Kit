# File: classification_demo.py
# 2020/02/13	henry1758f 3.0.0	First Create with python instead of script

import json
import os
import string 
import sys
from pathlib import Path

current_path = os.path.abspath(os.getcwd())
home_path = str(Path.home())
dump_modelinfo_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = home_path + '/openvino_models/models/SYNNEX_demo/'
ir_model_path = home_path + '/openvino_models/ir/'
MO_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/converter.py'

label_path='$HOME/SYNNEX_work/Source/labels'
converter_path='${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/converter.py'

model_type = ['classification']

default_source = '${INTEL_OPENVINO_DIR}/deployment_tools/demo/car.png'
default_arg = ' -m ' + ir_model_path + 'public/squeezenet1.1/FP32/squeezenet1.1.xml' + \
' -i ' + default_source + \
' -d CPU  '

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
	print("|        Image Classification Demo        |")
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
		for task_type in dldt_search_str:
			for item in jsonObj_Array:
				if task_type in item['task_type']:
					i += 1
					precisions_string = ''
					for precisions in item['precisions']:
						precisions_string = precisions_string + '[' + precisions +']'
					print(str(i) + '. ' + item['name'] + '\t\t' + precisions_string + '\t\t[' + item['framework'] + '] '  )
	select = input('Select a number Or input a path to your model  >> ')
	if check_jsontemp_exist() :
		i = 0
		for task_type in dldt_search_str:
			for item in jsonObj_Array:
				if task_type in item['task_type']:
					i += 1
					if str(i) == select or select == item['name']:
						precisions = precisions_select(item['precisions'],item['name'])
						device = target_device_select()
						Path_str_noSub = ''
						Path_str = ''
						if 'intel/' in item['subdirectory']:
							Path_str_noSub = model_path + item['subdirectory'] + '/' + str(precisions) + '/' + item['name']
							Path_str = Path_str_noSub + '.xml'
						elif 'public/' in item['subdirectory']:
							Path_str_noSub = ir_model_path + item['subdirectory'] + '/' + str(precisions) + '/' + item['name']
							Path_str = Path_str_noSub + '.xml'
						print('[ INFO ] [ ' + item['name'] + ' ][' + str(precisions) + '] been selected , ' + item['description'])
						if os.path.isfile(Path_str):
							print('> Path: ' + Path_str)
						else:
							print('[ WARNING ] ' + Path_str + ' not exist!')
							print('[ WARNING ] The model has not optimized to IR file!')
							os.system('python3 ' + MO_path + ' --name ' + item['name'] + ' --download_dir ' + model_path + ' --output_dir ' + ir_model_path + ' --precisions=' + precisions)
							if not os.path.isfile(Path_str):
								print('[ ERROR ] The model has not optimized to IR file and FAILED to run model optimizer, Please check that you have already downloaded the model.')
								sys.exit(1)

						if 'coco' in item['name']:
							 os.system('cp -r ' + label_path + '/Coco/coco.labels ' + Path_str_noSub + '.labels')
						else:
							os.system('cp -r ' + label_path + '/ImageNet/ImageNet.labels ' + Path_str_noSub + '.labels')
						return ' -m' + arg_tag + Path_str + ' -d' + arg_tag + device
					elif select == '' :
						return ''
					
		else:
			if os.path.isfile(select):
				device = target_device_select()
				return ' -m' + arg_tag + select + ' -d' + arg_tag + device
			else:
				print('\n[ ERROR ] No such file at ' + select + ' ! Please check your input.')
				sys.exit(1)

def source_select():
	source = input(' \n\n[ For using default Source, just press ENTER, \n\tor typein the path to the source you want. ]\n  >> ')
	if source == '':
		return default_source
	else:
		return source

def excuting():
	global arguments_string
	arguments_string = ''
	arguments_string += model0_select( model_type ,  ' [Select a Classification model.]', ' ')
	if arguments_string == '':
		print('[ INFO ] Load Default Configuration...')
		arguments_string = default_arg
	else:
		arguments_string += ' -i ' + source_select()

	excute_string =  '$SAMPLE_LOC/classification_sample_async' + arguments_string
	print('[ INFO ] Running > ' + excute_string)
	os.system(excute_string)

###########
terminal_clean()
banner()
excuting()
