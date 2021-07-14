# File: image_processing_demo.py
import json
import os
import string 
import sys
import logging
from pathlib import Path
logging.basicConfig(format='[ %(levelname)s ] %(message)s',level=logging.DEBUG)

current_path = os.path.abspath(os.getcwd())
dump_modelinfo_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = str(Path.home()) + '/openvino_models/models/SYNNEX_demo/'
ir_model_path = str(Path.home()) + '/openvino_models/ir/'

test_image_path = current_path + '/Source/testing_source/'

image_super_resolution_model = ['image-super-resolution']
image_deblurring_model = ['deblurgan']

default_source_download_link = [ \
'https://upload.wikimedia.org/wikipedia/commons/5/51/SanChungBus_Route306_620FG_wide.jpg', \
'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/20180402_091550_KKA-2591.jpg/640px-20180402_091550_KKA-2591.jpg'
]

default_source = test_image_path + 'SanChungBus_Route306_620FG_wide.jpg'
default_source_blur = test_image_path + '20210708_102027.jpg'
default_arg_sr = ' -m ' + model_path + 'intel/single-image-super-resolution-1033/FP32/single-image-super-resolution-1033.xml' + \
' -i ' + default_source + \
' -d CPU -at sr'
default_arg_deblur = ' -m ' + ir_model_path + 'public/deblurgan-v2/FP32/deblurgan-v2.xml' + \
' -i ' + default_source_blur + \
' -d CPU -at deblur'

if os.path.isfile(jsontemp_path):
	os.system('rm -r ' + jsontemp_path)
os.system(dump_modelinfo_path + " --all >> " + jsontemp_path)

def check_jsontemp_exist():
	if not os.path.isfile(jsontemp_path):
		logging.error('%s is not exist! ',jsontemp_path)
		return False
	else:
		return True

def terminal_clean():
	os.system('clear')

def banner():
	print("|=========================================|")
	print("|          Image Processing Demo          |")
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
			logging.error('Invailed Input! ')
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
	if select == '':
		return ''
	elif check_jsontemp_exist() :
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
						logging.info(' [ %s ][%s] been selected',item['name'],str(precisions))
						logging.info('> Path: %s', Path)
						return ' -m' + arg_tag + Path + ' -d' + arg_tag + device
					elif select == '' :
						return ''
	else:
		logging.error(' It might cause by missing %s ',jsontemp_path)
		sys.exit(1)

def source_select():
	source = input(' \n\n[ For using default Source, just press ENTER, \n\tor typein the path to the source you want.]\n  >> ')
	if source == '':
		if 'single-image-super-resolution-1032' in arguments_string:
			default_source = test_image_path + 'SanChungBus_Route306_620FG_wide.jpg'
		elif 'single-image-super-resolution-1033' in arguments_string:
			default_source = test_image_path + '640px-20180402_091550_KKA-2591.jpg'
		elif 'text-image-super-resolution-0001' in arguments_string:
			default_source = test_image_path + '640px-20180402_091550_KKA-2591.jpg'
		elif 'deblurgan-v2' in arguments_string:
			default_source = default_source_blur
		else:
			logging.warning(' You have to assign an image due to chooing a model that out of intel dldt!')
		if os.path.isfile(default_source):
			logging.info(' Input Source set to %s \n\n' , default_source )
			return default_source
		else:
			logging.error(' No such file or the default images could not be downloaded!! Please check your internet connection or image path.\n\n')
			sys.exit(1)
	else:
		return source

def feature_select():
	select = input(' [Choose the image processing type.]\n 1. Super Resolution. \n 2. Deblurring. \n >>> ')
	if select == '1' or select == 'Super Resolution':
		logging.info('Super Resolution')
		return 'sr'
	elif select == '2' or select == 'Deblurring':
		logging.info('Deblurring')
		return 'deblur'
	else: 
		logging.warning(' You have to assign a type!')
		return feature_select()

def excuting():
	global arguments_string
	arguments_string = ''
	feature = feature_select()
	arguments_string += ' -at ' + feature
	if feature == 'deblur':
		source = default_source_blur
		arguments_string += model0_select(image_deblurring_model,  ' [Select a image deblurring model.]', ' ')
	else:
		source = default_source
		arguments_string += model0_select(image_super_resolution_model,  ' [Select a image super resolution model.]', ' ')

	if arguments_string == ' -at deblur':
		logging.info(' Load Default deblurring Configuration...')
		arguments_string = default_arg_deblur
	elif arguments_string == ' -at sr':
		logging.info(' Load Default super resolution Configuration...')
		arguments_string = default_arg_sr
	else:
		source = source_select()
		arguments_string += ' -i ' + source
	excute_string =  '$DEMO_LOC/image_processing_demo' + arguments_string + ' -output_resolution 1920x1080'
	logging.info(' Running > %s' , excute_string)
	os.system(excute_string)


###########
terminal_clean()
banner()
excuting()
