# File: super_resolution_demo.py
# 2020/02/12	henry1758f 3.0.0	First Create with python instead of script

import json
import os
import string 
import sys

current_path = os.path.abspath(os.getcwd())
dump_modelinfo_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = '~/openvino_models/models/SYNNEX_demo/'
ir_model_path = '~/openvino_models/ir/'

test_image_path = current_path + '/Source/testing_source/'

image_super_resolution_model = ['image-super-resolution']

default_source_download_link = [ \
'https://upload.wikimedia.org/wikipedia/commons/5/51/SanChungBus_Route306_620FG_wide.jpg', \
'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/20180402_091550_KKA-2591.jpg/640px-20180402_091550_KKA-2591.jpg'
]

default_source = test_image_path + 'SanChungBus_Route306_620FG_wide.jpg'
default_arg = ' -m ' + model_path + 'intel/single-image-super-resolution-1032/FP32/single-image-super-resolution-1032.xml' + \
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
	print("|          Super Resolution Demo          |")
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
		if 'single-image-super-resolution-1032' in arguments_string:
			default_source = test_image_path + 'SanChungBus_Route306_620FG_wide.jpg'
		elif 'single-image-super-resolution-1033' in arguments_string:
			default_source = test_image_path + '640px-20180402_091550_KKA-2591.jpg'
		elif 'text-image-super-resolution-0001' in arguments_string:
			default_source = test_image_path + '640px-20180402_091550_KKA-2591.jpg'
		else:
			print('[ WARNNING ] You have to asign an image due to chooing a model that out of intel dldt!')
		if os.path.isfile(default_source):
			print('[ INFO ] Input Source set to ' + default_source + '\n\n')
			return default_source
		else:
			print('[ ERROR ] No such file or the default images could not be downloaded!! Please check your internet connection or image path.\n\n')
			sys.exit(1)
	else:
		return source

def excuting():
	global arguments_string
	arguments_string = ''
	source = default_source
	arguments_string += model0_select(image_super_resolution_model,  ' [Select a image super resolution model.]', ' ')
	if arguments_string == '':
		print('[ INFO ] Load Default Configuration...')
		arguments_string = default_arg
	else:
		source = source_select()
		arguments_string += ' -i ' + source
	excute_string =  '$DEMO_LOC/super_resolution_demo' + arguments_string + ' -show'
	print('[ INFO ] Running > ' + excute_string)
	os.system('xdg-open ' + source)
	os.system(excute_string)


###########
terminal_clean()
banner()
excuting()
