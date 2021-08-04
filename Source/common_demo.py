# File: common_demo.py

import json
import os
import string 
import logging
import sys
from pathlib import Path
logging.basicConfig(format='[ %(levelname)s ] %(message)s',level=logging.DEBUG)
logging.disable(logging.DEBUG)

current_path = os.path.abspath(os.getcwd())
demo_info = current_path + '/Source/demo_info.json'
test_image_path = current_path + '/Source/testing_source/'
dump_modelinfo_path = '${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/info_dumper.py'
modelinfoJson_path = current_path + '/Source/model_info.json'
model_path = str(Path.home()) + '/openvino_models/models/SYNNEX_demo/'
ir_model_path = str(Path.home()) + '/openvino_models/ir/'
model_downloader_path="${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/"


Yes_strings=['Y','y','yes','YES']

def terminal_clean():
	os.system('clear')

def model_info_ckeck():
	if not os.path.isfile(modelinfoJson_path):
		logging.warning('Model Info Json File not Found. Creating...')
		os.system('python3 ' + dump_modelinfo_path + ' --all > ' + modelinfoJson_path )
	if os.path.isfile(modelinfoJson_path):
		return True
	else:
		return False

def banner(title,gap=4,updown_border_text='=',side_border_text='|'):
	updown_border = side_border_text
	side_border = side_border_text
	for x in range(len(title) + gap*2):
		updown_border += '='
	updown_border += side_border_text
	for x in range(gap):
		side_border += ' '
	side_border += title
	for x in range(gap):
		side_border += ' '
	side_border += side_border_text
	print(updown_border)
	print(side_border)
	print(updown_border)
	print(side_border_text + "  Support OpenVINO " + os.popen('echo $VERSION_VINO').read() + '\n')

def download_progress(downloaded,blocksize,remotesize):
	percent = 100.0*downloaded*blocksize/remotesize
	if percent > 100:
		percent = 100
	logging.info('\rDownloading %.2f %%',percent)

def openModelZoo_PathReporter(model_info,model,flag_default=False):
	precision = model_info['default']['precision']
	#logging.debug('in PathReporter [%s]',precision)
	if not flag_default:
		precision = precisions_selector(model[1],model[0],model_info['default']['precision'])
	#logging.debug('in PathReporter [%s]',model_path + model[2] + '/' + precision + '/' + model[0] + '.xml')
	if 'intel/' in model[2]:
		return model_path + model[2] + '/' + precision + '/' + model[0] + '.xml'
	elif 'public/' in model[2]:
		return ir_model_path + model[2] + '/' + precision + '/' + model[0] + '.xml'

def existCheck_downloader(Path, model_name=''):
	if not os.path.isfile(Path):
		if model_name == '':
			logging.error(' The Model File not found in %s, Please check your path and try again !',Path)
			return False
		else:
			logging.warning(' The Model File not found in %s, Do you want to try download %s from Open Model Zoo? [Y/n]',Path,model_name)
			key = input(' >>> ')
			for y in Yes_strings:
				if y == key:
					logging.info(' Try Download %s model.....',model_name)
					prerequests = ['requirements.in','requirements-caffe2.in','requirements-pytorch.in','requirements-tensorflow.in']
					downloader_command = 'python3 "' + model_downloader_path + 'downloader.py" --name ' + model_name + ' -o ' + model_path
					for prerequest in prerequests:
						prerequest_command = 'python3 -m pip install -r ' + model_downloader_path + '/' + prerequest
						logging.debug('excute > %s',prerequest_command)
						os.system(prerequest_command)
					logging.debug('excute > %s',downloader_command)
					os.system(downloader_command)
					if 'public/' in Path:
						converter_command = 'python3 "' + model_downloader_path + 'converter.py" -d ' + model_path + ' --name ' + model_name + ' -o ' + model_path + '../../ir -j8'
						logging.debug('excute > %s',converter_command)
						os.system(converter_command)
					return existCheck_downloader(Path)
			else:
				return False

	else:
		logging.debug('Model Check.... [OK]!')
		return True

def model_selector(model_info,flag_default=False):
	if not model_info_ckeck():
		logging.error('No OMZ Models informations!!')
	if not flag_default:
		print('\n======= Model List =======')
	with open(modelinfoJson_path,'r') as omzModel_info_json:
		omzModel_ObjArray = json.load(omzModel_info_json)
		model_list = []
		i = 0
		for name in model_info['keywords']:
			logging.debug('[model_selector] extract "%s"',name)
			for item in omzModel_ObjArray:
				if name in item[model_info['keywordsType']]:
					i += 1
					precisions_string = ''
					for precisions in item['precisions']:
						precisions_string = precisions_string + '[' + precisions +']'
					if not flag_default:
						print(str(i) + '. ' + item['name'] + '\t\t' + precisions_string + '\n\t\t[' + item['framework'] + '] ' + item['description'] )
					add_list = [item['name'],item['precisions'],item['subdirectory']]
					model_list.append(add_list)
		if flag_default:
			select = ''
		else:
			select = input('\n\n [ Select a ' + model_info['usage'] + ', or press ENTER to run default setting] >>>')
		try:
			if select == '' and not flag_default:
				if model_info['required']:
					if model_info['directRun']:
						logging.info('Load Default Setting and Start running!')
						return 'default'
					else:
						logging.error('You must select a model! ')
						return model_selector(model_info)
				else:
					logging.warning(' You did not choose any model! This feature will not run! ')
					return ''
			elif select == '' and flag_default:
				for model in model_list:
					logging.debug('[Model_Selector][flag = %d] %s',flag_default,model[0])
					if model[0] == model_info['default']['name']:
						Path = openModelZoo_PathReporter(model_info,model,flag_default)
						existCheck_downloader(Path,model[0])
						return ' ' + model_info['argument'] + ' ' + Path 
				else:
					logging.error('Cannot find default model_info!')
			elif os.path.isfile(select):
				logging.info('Setting Custom model >> %s',select)
				return ' ' + model_info['argument'] + ' ' + select
			elif model_list[int(select)-1] != None:
				Path = openModelZoo_PathReporter(model_info,model_list[int(select)-1],flag_default)
				existCheck_downloader(Path,model_list[int(select)-1][0])
				return ' ' + model_info['argument'] + ' ' + Path
			else:
				logging.error('Your Input is invaild! Please check your input or path and try again!')
				return model_selector(model_info)
		except:
			logging.error('Your Input is invaild! Please check your input or path and try again! (%s - %s)',sys.exc_info()[0],sys.exc_info()[1])
			return model_selector(model_info)
	logging.error('Somthing Error in [model_selector] there might be something wrong in demo_info.json')
	exit(1)

def precisions_selector(precisions,model_name,default='FP32'):
	i = 0
	print('\n[ Available Precisions ]')
	for result in precisions:
		i += 1
		print(str(i) + '. [' + result + ']' )
	else:
		keyin = input('\n [Select precisions of the model "' + model_name + '"]  >>')
		i = 0
		for result in precisions:
			i += 1
			if str(i) == keyin or keyin == result:
				return str(result)
				break
		else:
			logging.error('Your Input is invaild! Please check your input or path and try again!')
			return precisions_selector(precisions, model_name, default)

def device_selector(head=' -d ',default='CPU',flag_default=False):
	if head == ' ':
		return ''
	if not flag_default:
		result = input('\n [Typein the target device for inference this model (CPU,GPU,MYRIAD,HDDL,etc.)]  >> ')
		if result == '':
			logging.warning('You did not specify a target device! Use %s as default.',default)
			return head + default
		return head	+ result
	else:
		logging.warning('You did not specify a target device! Use %s as default.',default)
		return head + default

def input_selector(demoinfo_jsonObj,mask=True,flag_default=False):
	if mask and not flag_default:
		print('[ %s ]' % demoinfo_jsonObj['InputHints'])
		key = input(' >>> ')
		if key == '':
			logging.info('Set "%s" as input',demoinfo_jsonObj['defaultInputs'][0]['path'])
			return demoinfo_jsonObj['InputArguments'] + ' ' + demoinfo_jsonObj['defaultInputs'][0]['path']
		else:
			logging.info('Set "%s" as input',key)
		return demoinfo_jsonObj['InputArguments'] + ' ' + key
	if flag_default:
		for defaultInput in demoinfo_jsonObj['defaultInputs']:
			if defaultInput['default']:
				if '<DOWNLOAD>' in defaultInput['path']:
					if not os.path.isfile(test_image_path + defaultInput['fileName']):
						key = input('No default images found, do you want to download "' + defaultInput['name'] + '" from Internet? [Y/n]')
						for y in Yes_strings:
							if y == key:
								logging.warning(' Downloading "%s" from %s.\n\n',defaultInput['name'],defaultInput['source'])
								string = 'curl -o ' + test_image_path + defaultInput['fileName'] + ' ' + defaultInput['source']
								os.system(string)
								break
						else:
							logging.warning('Abort ! No input source for inference.')
							exit(1)

						if not os.path.isfile(test_image_path + defaultInput['fileName']):
							logging.error('No default images and could not be downloaded!! Please check your internet connection or image path.\n\n')
							exit(1)
					return demoinfo_jsonObj['InputArguments'] + ' ' + test_image_path + defaultInput['fileName']
				else:
					return demoinfo_jsonObj['InputArguments'] + ' ' + defaultInput['path']
	else:
		print('[ %s ]' % demoinfo_jsonObj['InputHints'])
		i = 0
		input_List=[]
		for defaultInput in demoinfo_jsonObj['defaultInputs']:
			i += 1
			print('%2d. %s' % (i,defaultInput['fileName']))
		key = input(' >>> ')
		try:
			if key == '':
				for defaultInput in demoinfo_jsonObj['defaultInputs']:
					if defaultInput['default']:
						return demoinfo_jsonObj['InputArguments'] + ' ' + defaultInput['path']
				else:
					logging.error('No default input defined in json file! Please check or raise as a bug.')
			elif os.path.isfile(key):
				logging.info('Setting Custom input >> %s',key)
				return demoinfo_jsonObj['InputArguments'] + ' ' + key
			elif int(key)>0:
				i = 0
				for defaultInput in demoinfo_jsonObj['defaultInputs']:
					i += 1
					if i == int(key):
						return demoinfo_jsonObj['InputArguments'] + ' ' + defaultInput['path']
				else:
					logging.error('Your Input is invaild! Please check your input or path and try again!')
					return input_selector(demoinfo_jsonObj,True)
			else:
				logging.error('Your Input is invaild! Please check your input or path and try again!')
				return input_selector(demoinfo_jsonObj,True)
		except:
			logging.warning('Your Input is not a exist file.')
			return demoinfo_jsonObj['InputArguments'] + ' ' + key

def excute_string_composer(demoinfo_jsonObj):
	arguments_string = ''
	default_flag = False
	for model in demoinfo_jsonObj['models']:
		if model['directRun']:
			result = model_selector(model,default_flag)
			if result == 'default':
				default_flag = True
				arguments_string += model_selector(model,default_flag)
			else:
				arguments_string +=result
			if result != '':
				arguments_string += ' ' + device_selector(model['devicearguments'] + ' ', model['default']['device'],default_flag)
		else:
			#if model['required']:
			result = model_selector(model,default_flag)
			if result == 'default':
				arguments_string +=model_selector(model,True)
			else:
				arguments_string +=result
			if result != '':
				arguments_string += ' ' + device_selector(model['devicearguments'] + ' ', model['default']['device'],default_flag)
	arguments_string += ' ' + input_selector(demoinfo_jsonObj,True,default_flag) + ' ' + demoinfo_jsonObj['addArguments']


	return demoinfo_jsonObj['path'] + demoinfo_jsonObj['fileName'] + ' ' + arguments_string
