# File: object_detection_demo_ssd_async.py
# TODO: Labels 

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

label_path= current_path + '/Source/labels'
converter_path='${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/converter.py'
python_demo_path = home_path + '/inference_engine_demos_build/intel64/Release/python_demos/object_detection_demo_centernet/object_detection_demo_centernet.py '

model_type = ['detection']
invaild_model_name = ['face','pedestrian','person','product','text','vehicle','mtcnn','faster_rcnn_inception','faster_rcnn_resnet']
centernet_model_name = ['ctdet']
faster_rcnn_model_name = ['faster_rcnn']
yolo_model_name = ['yolo']

default_source = 'cam'
default_arg = ' -m ' + ir_model_path + 'public/ssd_mobilenet_v2_coco/FP32/ssd_mobilenet_v2_coco.xml' + \
' -i ' + default_source + \
' -d CPU ' + '-labels ' + label_path + '/Coco/coco.labels '

if os.path.isfile(jsontemp_path):
	os.system('rm -r ' + jsontemp_path)
os.system("python3 " + dump_modelinfo_path + " --all >> " + jsontemp_path)

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
	print("|   Object Detection and ASYNC API Demo   |")
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

def isbanned_check(name,banList):
	flag_rtn = False
	for ban in banList:
		#print('[ DEBUG ] check "' + name + ' with ' + ban)
		if ban in name:
			flag_rtn = flag_rtn or True
		else:
			flag_rtn = flag_rtn or False
	else:
		#print('[DEBUG] flag_rtn= ' + str(flag_rtn))
		return flag_rtn


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
				if task_type in item['task_type'] and not isbanned_check(item['name'],invaild_model_name):
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
				if task_type in item['task_type'] and not isbanned_check(item['name'],invaild_model_name):
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
						if not item['framework'] == 'dldt':
							if 'coco' in item['name'] or item['name'] == 'ssdlite_mobilenet_v2':
								 os.system('cp -r ' + label_path + '/Coco/coco.labels ' + Path_str_noSub + '.labels')
							else:
								os.system('cp -r ' + label_path + '/PASCAL_VOC/PASCAL_VOC.labels ' + Path_str_noSub + '.labels')
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
	arguments_string += model0_select( model_type ,  ' [Select a Object Detection model.]', ' ')
	if arguments_string == '':
		print('[ INFO ] Load Default Configuration...')
		arguments_string = default_arg
	else:
		arguments_string += ' -i ' + source_select()

	excute_string =  '$DEMO_LOC/object_detection_demo_ssd_async' + arguments_string
	for centernet_str in centernet_model_name:
		if centernet_str in arguments_string:
			excute_string =  'python3 ' + python_demo_path + arguments_string + ' --labels ' + label_path + '/Coco/coco_nobackground.labels '
			break
		for faster_rcnn_str in faster_rcnn_model_name:
			if faster_rcnn_str in arguments_string:
				excute_string =  '$DEMO_LOC/object_detection_demo_faster_rcnn' + arguments_string
				break
	else:
		for yolo_str in yolo_model_name:
			if yolo_str in arguments_string:
				excute_string =  '$DEMO_LOC/object_detection_demo_yolov3_async' + arguments_string
	print('[ INFO ] Running > ' + excute_string)
	os.system(excute_string)

###########
terminal_clean()
banner()
excuting()
