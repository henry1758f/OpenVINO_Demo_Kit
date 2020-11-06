# File: text_detection_demo.py
# 2020/02/12	henry1758f 1.0.0	First Create with python instead of script

import json
import os
import string 
import sys

current_path = os.path.abspath(os.getcwd())
dump_modelinfo_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = '~/openvino_models/models/SYNNEX_demo/'
ir_model_path = '~/openvino_models/ir/'

text_detection_model = ['text-detection']
text_recognition_model = ['text-recognition']

default_source = '0'
default_arg = ' -m_td ' + model_path + 'intel/text-detection-0003/FP32/text-detection-0003.xml' + \
' -m_tr ' + model_path + 'intel/text-recognition-0012/FP32/text-recognition-0012.xml' + \
' -i ' + default_source + \
' -d_td CPU -d_tr CPU '

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
	print("|           Text Detection Demo           |")
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
	source = input(' \n\n[ input "cam" for using camera as inference source, \n\tfor using default Source, just press ENTER, \n\tor typein the path to the source you want. \nSupport multiple source by "<source1> <source2> <source3>... ]\n  >> ')
	if source == '':
		return default_source
	else:
		return source

def excuting():
	global arguments_string
	arguments_string = ''
	arguments_string += model0_select(text_detection_model,  ' [Select a Text Detection model.]', '_td ')
	if arguments_string == '':
		print('[ INFO ] Load Default Configuration...')
		arguments_string = default_arg
	else:
		select_str = ''
		select_str = model0_select(text_recognition_model,  ' [Select a Text Recognition model.]', '_tr ')
		if select_str == '':
			select_str = ' -m_tr ' + model_path + 'intel/text-recognition-0012/FP32/text-recognition-0012.xml'
		arguments_string += select_str
		arguments_string += ' -i ' + source_select()
	excute_string =  '$DEMO_LOC/text_detection_demo' + arguments_string
	print('[ INFO ] Running > ' + excute_string)
	os.system(excute_string)

###########
terminal_clean()
banner()
excuting()
