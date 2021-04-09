# File: colorization_demo.py

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
python_demo_path = '${INTEL_OPENVINO_DIR}/inference_engine/demos/colorization_demo/python/'

test_image_path = current_path + '/Source/testing_source/'

colorization_model = ['colorization']

default_source_download_link = 'https://synnexopenvinodemo.blob.core.windows.net/synnexopenvinodemo/img1450.jpg '
default_source_file_name = '1960s_Taiwan_Taichung.jpg'
default_source = test_image_path + default_source_file_name
default_arg = ' -m ' + ir_model_path + 'public/colorization-siggraph/FP32/colorization-siggraph.xml' + \
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
	print("|            Colorization Demo            |")
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
	source = input(' \n\n[ For using default Source, just press ENTER, \n\tor typein the path to the source you want.]\n  >> ')
	if source == '':
		default_source_check()
		return default_source
	else:
		return source

def default_source_check():
	if os.path.isfile(default_source):
			print('[ INFO ] Input Source set to ' + default_source + '\n\n')
	else:
		print('[ WARNING ] Default Input Source not found. Trying to download.....\n\n')
		os.system('wget -O ' + default_source + ' ' + default_source_download_link  ) 
		if not os.path.isfile(default_source):
			print('[ ERROR ] No such file or the default images could not be downloaded!! Please check your internet connection or image path.\n\n')
			sys.exit(1)

def excuting():
	global arguments_string
	arguments_string = ''
	source = default_source
	arguments_string += model0_select(colorization_model,  ' [Select a colorization model.]', ' ')
	if arguments_string == '':
		default_source_check()
		print('[ INFO ] Load Default Configuration...')
		arguments_string = default_arg

	else:
		source = source_select()
		arguments_string += ' -i ' + source
	excute_string =  'python3 ' + python_demo_path + 'colorization_demo.py ' + arguments_string + ' --loop'
	print('[ INFO ] Running > ' + excute_string)
	os.system(excute_string)


###########
terminal_clean()
banner()
excuting()
