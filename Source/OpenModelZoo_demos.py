# File: OpenModelZoo_demos.py
from common_demo import banner,excute_string_composer,terminal_clean,model_selector,input_selector,Yes_strings
import os
import json
import logging
import time
from pathlib import Path
logging.basicConfig(format='[ %(levelname)s ] %(message)s',level=logging.DEBUG)

current_path = os.path.abspath(os.getcwd())
demo_info = current_path + '/Source/demo_info.json'
model_path = str(Path.home()) + '/openvino_models/models/SYNNEX_demo/'


def special_arg_check(demoinfo_jsonObj,excute_string):
	# BERT Named Entity Recognition Demo
	if demoinfo_jsonObj['name'] == 'BERT Named Entity Recognition Demo':
		if 'public/bert-base-ner/' in excute_string:
			return excute_string + ' -v ' + model_path + demoinfo_jsonObj['vocab']
	
	# Classification Demo
	if demoinfo_jsonObj['name'] == 'Classification Demo':
		default_label_path = ''
		for label in demoinfo_jsonObj['labels']:
			if label['default']:
				default_label_path = label['path']
			if label['name'] == 'imagenet_2015.txt':
				for applyName in label['applyModels']:
					if applyName in excute_string:
						return excute_string + ' -labels ' + label['path']
		else:
			if 'openvino_models/ir/public' in excute_string:				
				return excute_string +  ' -labels ' + default_label_path
			else:
				key = input('\n [Specify a label file for classification] ')
				return excute_string + ' -labels ' + key

	# Object Detection Demo
	if demoinfo_jsonObj['name'] == 'Object Detection Demo':
		default_label_path = ''
		for label in demoinfo_jsonObj['labels']:
			if label['default']:
				default_label_path = label['path']
			for applyName in label['applyModels']:
				if applyName in excute_string:
					excute_string += ' -labels ' + label['path']
					break
			if ' -labels ' in excute_string:
				break
		else:
			if 'openvino_models/ir/public' in excute_string:				
				excute_string +=  ' -labels ' + default_label_path
			else:
				key = input('\n [Specify a label file for Object Detection] ')
				excute_string += ' -labels ' + key

		for task_type in demoinfo_jsonObj['archType']:
			for model in task_type['models']:
				if model in excute_string:
					return excute_string + ' -at ' + task_type['argument']
		else:
			key = input('\n [Type of the network, Architecture type: centernet, faceboxes, retinaface, ssd or yolo] ')
			return excute_string + ' -at ' + key

	# Human Pose Estimation Demo. (2D)
	if demoinfo_jsonObj['name'] == 'Human Pose Estimation Demo. (2D)':
		for task_type in demoinfo_jsonObj['archType']:
			for model in task_type['models']:
				if model in excute_string:
					return excute_string + ' -at ' + task_type['argument']
		else:
			key = input('\n [Type of the network, either "ae" for Associative Embedding, "higherhrnet" for HigherHRNet models based on ae or "openpose" for OpenPose.] ')
			return excute_string + ' -at ' + key
	# Human Pose Estimation Demo. (3D)
	if demoinfo_jsonObj['name'] == 'Human Pose Estimation Demo. (3D)':
		return 'export PYTHONPATH="$PYTHONPATH:$HOME/omz_demos_build/intel64/Release/lib" && python3 ' + excute_string

	# Image Processing Demo
	if demoinfo_jsonObj['name'] == 'Image Processing Demo':
		for task_type in demoinfo_jsonObj['archType']:
			for model in task_type['models']:
				if model in excute_string:
					return excute_string + ' -at ' + task_type['argument']
		else:
			key = input('\n [Type of the network, either "sr" for Super Resolution task or "deblur" for Deblurring] ')
			return excute_string + ' -at ' + key

	# Instance Segmentation Demo
	if demoinfo_jsonObj['name'] == 'Instance Segmentation Demo':
		default_label_path = ''
		for label in demoinfo_jsonObj['labels']:
			if label['default']:
				default_label_path = label['path']
			for applyName in label['applyModels']:
				if applyName in excute_string:
					excute_string += ' --labels ' + label['path']
					break
			if ' --labels ' in excute_string:
				break
		else:
			if 'openvino_models/ir/public' in excute_string:				
				excute_string +=  ' --labels ' + default_label_path
			else:
				key = input('\n [Specify a label file for Object Detection] ')
				if key == '':
					excute_string += ' --labels ' + default_label_path
				else:
					excute_string += ' --labels ' + key

	# Text Detection Demo
	if demoinfo_jsonObj['name'] == 'Text Detection Demo':
		for task_type in demoinfo_jsonObj['archType']:
			for model in task_type['models']:
				if model in excute_string:
					return excute_string + ' -dt ' + task_type['argument']
		else:
			key = input('\n [Type of the decoder, either "simple" for SimpleDecoder or "ctc" for CTC greedy and CTC beam search decoders. Default is "ctc"] ')
			if key == '':
				return excute_string
			else:
				return excute_string + ' -at ' + key
	
	# Action Recognition Demo
	if demoinfo_jsonObj['name'] == 'Action Recognition Demo':
		default_label_path = ''
		for label in demoinfo_jsonObj['labels']:
			if label['default']:
				default_label_path = label['path']
			for applyName in label['applyModels']:
				if applyName in excute_string:
					excute_string += ' --labels ' + label['path']
					break
			if ' -labels ' in excute_string:
				break
		else:
			if 'driver-action-recognition' in excute_string:				
				excute_string +=  ' --labels ' + default_label_path
			else:
				key = input('\n [Specify a label file for Actions] ')
				if key == '':
					excute_string += ' --labels ' + default_label_path
				else:
					excute_string += ' --labels ' + key

		for task_type in demoinfo_jsonObj['archType']:
			for model in task_type['models']:
				if model in excute_string:
					return excute_string + ' -at ' + task_type['argument']
		else:
			key = input('\n [Type of the network, architecture_type {en-de,en-mean,i3d-rgb}] ')
			return excute_string + ' -at ' + key

	# Gesture Recognition Demo
	if demoinfo_jsonObj['name'] == 'Gesture Recognition Demo':
		default_label_path = ''
		for label in demoinfo_jsonObj['labels']:
			if label['default']:
				default_label_path = label['path']
			for applyName in label['applyModels']:
				if applyName in excute_string:
					return excute_string + ' -c ' + label['path']
		else:
			if 'openvino_models/' in excute_string:				
				return excute_string +  ' -c ' + default_label_path
			else:
				key = input('\n [Specify a Gesture Classes File] ')
				return excute_string + ' -c ' + key

	# Face Recognition Demo
	if demoinfo_jsonObj['name'] == 'Face Recognition Demo':
		default_fg_path = ''
		key = input('Input a path for the face gallery data. Default is %s' % (str(Path.home())+ '/Pictures/face_gallery') )
		if key == '':
			excute_string += ' -fg ' + str(Path.home()) + demoinfo_jsonObj['faceGallery']
		elif key != '' and not os.path.exists(key):
			logging.warning('Face Gallery %s is not exist, creating the folder...')
			os.system('mkdir -p ' + key)
			if not os.path.exists(key):
				logging.error('Cannot find or create %s',key)
			else:
				excute_string += ' -fg ' + key
		allowgrow = input('allow growing the face database? [Y/n]')
		for y in Yes_strings:
			if y == allowgrow:
				return excute_string + ' --run_detector --allow_grow '
			else:
				return excute_string

	# Whiteboard Inpainting Demo
	if demoinfo_jsonObj['name'] == 'Whiteboard Inpainting Demo':
		if 'instance-segmentation' in excute_string:
			return excute_string.replace('-m_TODO','-m_i')
		else:
			return excute_string.replace('-m_TODO','-m_s')

	# MonoDepth Demo
	if demoinfo_jsonObj['name'] == 'MonoDepth Demo':
		return excute_string + ' && xdg-open ./disp.png'
	### 
	return excute_string

# Multi Camera Multi Target Demo
def excute_string_composer_multicamtarget(demoinfo_jsonObj):
	arguments_string = ''
	default_flag = False
	i = 0
	print('Select a type of object tracking.')
	for trackType in demoinfo_jsonObj['archType']:
		i += 1
		print('%2d. %s' % (i,trackType['name']))
	key = input('>>> ')
	i = 0
	for trackType in demoinfo_jsonObj['archType']:
		i +=1
		if key == str(i) or key == '':
			for model in demoinfo_jsonObj['models']:
				if model['argument'] == trackType['argument']:
					result =  model_selector(model)
					if result == 'default':
						default_flag = True
						arguments_string = model_selector(model,default_flag)
					else:
						arguments_string = result
			break
	else:
		logging.error('Invailed Input!')
		exit(1)
	for model in demoinfo_jsonObj['models']:
		if model['argument'] == '--m_reid':
			arguments_string += model_selector(model,default_flag)
	arguments_string += input_selector(demoinfo_jsonObj,True,default_flag)
	if 'vehicle' in arguments_string:
		arguments_string += ' --config ' + demoinfo_jsonObj['path'] + 'configs/vehicle.py '
	elif 'person' in arguments_string:
		arguments_string += ' --config ' + demoinfo_jsonObj['path'] + 'configs/person.py '
	else:
		key = input('Input the path of your config file >>>')
		arguments_string += ' --config ' + key
	return ' ' + demoinfo_jsonObj['path'] + demoinfo_jsonObj['fileName'] + ' ' + arguments_string

def run_demo(demoinfo_jsonObj):
	banner(demoinfo_jsonObj['name'])
	if demoinfo_jsonObj['name'] == 'Multi Camera Multi Target Demo':
		excute_string = excute_string_composer_multicamtarget(demoinfo_jsonObj)
	elif demoinfo_jsonObj['name'] == 'Real Time Speech Recognition Demo':
		excute_string = demoinfo_jsonObj['path'] + demoinfo_jsonObj['fileName']
	else:
		excute_string = excute_string_composer(demoinfo_jsonObj)
	excute_string = special_arg_check(demoinfo_jsonObj,excute_string)

	logging.info('Running : %s',excute_string)
	os.system(excute_string)

###########
def main():
	terminal_clean()
	banner('Select an Intel OpenVINO Demostration')
	with open(demo_info,'r') as demo_info_json:
		demoinfo_jsonObj_root = json.load(demo_info_json)
		i = 0
		for demoinfo_jsonObj in demoinfo_jsonObj_root['demos']:
			i +=1
			print('%2d. %s' % (i,demoinfo_jsonObj['name']))
	#	demo_name = 'BERT Named Entity Recognition Demo'
	#	banner(demo_name)
	#	excute_string_composer(demoinfo_jsonObj_root,demo_name)
		
		key = input(' >>> ')
		i = 0
		for demoinfo_jsonObj in demoinfo_jsonObj_root['demos']:
			i +=1
			if (key == str(i)):
				run_demo(demoinfo_jsonObj)
				break
		else:
			logging.error('Invailed Input! Please check and try again.')
			time.sleep(3)
			main()

main()