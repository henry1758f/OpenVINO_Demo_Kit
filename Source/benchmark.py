# File: benchmark.py
import json
import os
import string 
import logging
import sys
import csv
from pathlib import Path
logging.basicConfig(format='[ %(levelname)s ] %(message)s',level=logging.DEBUG)
from common_demo import banner,terminal_clean,existCheck_downloader,model_info_ckeck
logging.disable(logging.DEBUG)

current_path = os.path.abspath(os.getcwd())

jsontemp_path = current_path + '/Source/model_info.json'
model_path = str(Path.home()) + '/openvino_models/models/SYNNEX_demo/'
ir_model_path = str(Path.home()) + '/openvino_models/ir/'
model_downloader_path="${INTEL_OPENVINO_DIR}/deployment_tools/tools/model_downloader/"

reportCSV_flag = True

model_test_limit_list = []
model_test_ban_list = []

def device_selector():
	return input('\n [Input your target device. (CPU,GPU,MYRIAD,HDDL,MULTI,HETERO,etc.)]\n >>> ')

def extend_arguments():
	return input('\n [Input if you need to run any specific arguments, or press ENTER to skip it.]\n >>> ')

def test_index():
	key = input('\n [Input the Index to skip some models during "ALL" test, or press ENTER to skip it.]\n >>> ')
	if key.isnumeric():
		return int( key)
	else:
		return 0

def excute_string_composer(model_path,device,arg=''):
	return '$SAMPLE_LOC/benchmark_app -m ' + model_path + ' -d ' + device + arg + ' | egrep "Count|Duration|Latency|Throughput" '

def OMZPathReporter(json_model_info,precision='FP32'):
	if 'intel/' in json_model_info['subdirectory']:
		return model_path + json_model_info['subdirectory'] + '/' + precision + '/' + json_model_info['name'] + '.xml'
	elif 'public/' in json_model_info['subdirectory']:
		return ir_model_path + json_model_info['subdirectory'] + '/' + precision + '/' + json_model_info['name'] + '.xml'
	else:
		logging.warning('[OMZPathReporter]: Cannot find path to %s ',json_model_info['name'],'(' + json_model_info['subdirectory'] + ')')
		return 'ERROR'

def model_selector():
	print('\n======= Model List =======')
	with open(jsontemp_path,'r') as omzModel_info_json:
		omzModel_Objs = json.load(omzModel_info_json)
		model_list = []
		i = 0
		for omzModel in omzModel_Objs:
			i += 1
			precisions_string = ''
			for precisions in omzModel['precisions']:
				precisions_string = precisions_string + '[' + precisions +']'
			if not 'FP16-INT8' in precisions_string:
				Path = OMZPathReporter(omzModel,'FP16-INT8')
				if os.path.isfile(Path):
					precisions_string = precisions_string + '[FP16-INT8*]'
			print(str(i) + '. [' + omzModel['framework'] + '] \t' + omzModel['name'] + '\t\t' + precisions_string )
		key = input(' Input the name or number of the Model for benchmarking, or Input "all" to test all models >>> ')
		try:
			if key.isnumeric():
				i = 0
				for omzModel in omzModel_Objs:
					i +=1
					if int(key) == i:
						return omzModel['name']
				else:
					logging.error('Your Input number is invaild! Please check and try again.')
					return 'ERROR'
			elif key == 'all' or key == 'ALL':
				return 'ALL'
			else:
				for omzModel in omzModel_Objs:
					if key == omzModel['name']:
						return omzModel['name']
				else:
					if os.path.isfile(key):
						return key
					else:
						logging.error('Your input cannot be found, nither a name in OMZ nor a path.')
						return 'ERROR'
		except Exception as e:
			logging.error('%s',e)

def excutor(model_path,reportCSV,device='CPU',add_arg=''):
	throughput = 0.0
	latency = 0.0
	count = 0
	duration = 0.0
	benchmark = [ throughput,latency,count,duration ]
	if os.path.isfile(model_path):
		#logging.debug( excute_string_composer(model_path,device,add_arg) )
		Totalresult_string = os.popen( excute_string_composer(model_path,device,add_arg) ).read()
		results_string = Totalresult_string.split('\n')
		#logging.debug('[excutor] Totalresult_string:%s',Totalresult_string)
		for result_string in results_string:
			if 'Count' in result_string:
				count = result_string[len('Count:'):-len('iterations ')].strip()
			elif 'Duration' in result_string:
				duration = result_string[len('Duration:'):-len('ms ')].strip()
			elif 'Latency' in result_string:
				latency = result_string[len('Latency:'):-len('ms ')].strip()
			elif 'Throughput' in result_string:
				throughput = result_string[len('Throughput:'):-len('FPS ')].strip()
		benchmark = [ throughput,latency,count,duration ]
		return benchmark
	else:
		logging.error('%s no such file! Please check and try again.',model_path)
		return benchmark

def OMZmodel_excutor(json_model_info,reportCSV,device='CPU',add_arg='',precision=''):
	benchmark = [0,0,0,0]
	if precision == '':
		for precision in json_model_info['precisions']:
			Path = OMZPathReporter(json_model_info,precision)
			existCheck_downloader(Path,json_model_info['name'])
			logging.info( ' [%s][%s] >>> Time Stamp: [%s]',json_model_info['name'], precision, os.popen('echo $(date +\'%Y/%m/%d_%H:%M:%S\')').read().split()[0])
			benchmark = excutor(Path,reportCSV,device,add_arg)
			logging.info(' > Result:\n Throughput: %s \t| Latency: %s \t| Count: %s \t| Duration: %s \t|\n',benchmark[0],benchmark[1],benchmark[2],benchmark[3])
			reportCSV_writeReport(reportCSV, json_model_info, precision, benchmark[0],benchmark[1],benchmark[2],benchmark[3],Path)
		else:
			Path = OMZPathReporter(json_model_info,'FP16-INT8')
			if  Path != 'ERROR' and os.path.isfile(Path) :
				Path = OMZPathReporter(json_model_info,'FP16-INT8')
				benchmark = excutor(Path,reportCSV,device,add_arg)
				reportCSV_writeReport(reportCSV, json_model_info, 'FP16-INT8', benchmark[0],benchmark[1],benchmark[2],benchmark[3],Path)
			pass
	else:
		Path = OMZPathReporter(json_model_info,precision)
		logging.info( ' [%s][%s] >>> Time Stamp: [%s] ', json_model_info['name'],precision, os.popen('echo $(date +\'%Y/%m/%d_%H:%M:%S\')').read().split()[0] )
		benchmark = excutor(Path,reportCSV,device,add_arg)
		logging.info(' > Result:\n Throughput: %s \t| Latency: %s \t| Count: %s \t| Duration: %s \t|\n',benchmark[0],benchmark[1],benchmark[2],benchmark[3])
		reportCSV_writeReport(reportCSV, json_model_info, precision, benchmark[0],benchmark[1],benchmark[2],benchmark[3],Path)
	pass

def specificModel_excutor(Path,reportCSV,device='CPU',add_arg=''):
	benchmark = [0,0,0,0]
	logging.info( ' >>> Time Stamp: [%s] ',os.popen('echo $(date +\'%Y/%m/%d_%H:%M:%S\')').read() )
	benchmark = excutor(Path,reportCSV,device,add_arg)
	logging.info(' > Result:\n Throughput: %s \t| Latency: %s \t| Count: %s \t| Duration: %s \t|\n',benchmark[0],benchmark[1],benchmark[2],benchmark[3])
	reportCSV_writeSpecificReport(reportCSV, benchmark[0],benchmark[1],benchmark[2],benchmark[3],Path)

def reportCSV_writeInitial(reportCSV,Target_Device,add_arg):
	try:
		csvWriter = csv.writer(reportCSV)
		csvWriter.writerow(['Device_Info', os.popen('lscpu |grep "Model name:" ').read()[20:-1]])
		csvWriter.writerow(['Target_Device',Target_Device,'Additional Arguments',add_arg])
		csvWriter.writerow(['Model_Task_Type','Model_framework','Model_Name','Precisions','Throughput','Latency','Count','Duration','Model_Description','Model_Path'])
		reportCSV.flush()
	except Exception as e:
		logging.error('Error while Initializing the report file [%s]',e)

def reportCSV_writeReport(reportCSV,json_model_info,currentPrecision,throughput,latency,count,duration,path):
	csvWriter = csv.writer(reportCSV)
	csvWriter.writerow([json_model_info['task_type'],json_model_info['framework'],json_model_info['name'],currentPrecision,throughput,latency,count,duration,json_model_info['description'],path])
	reportCSV.flush()
	pass

def reportCSV_writeSpecificReport(reportCSV,throughput,latency,count,duration,path):
	csvWriter = csv.writer(reportCSV)
	pathsplit = path.split('\\')
	name = pathsplit[len(pathsplit-1)]
	csvWriter.writerow(['N/A','N/A',name,'N/A',throughput,latency,count,duration,'Customize Model',path])
	reportCSV.flush()
	pass

###########
def main():
	if not model_info_ckeck():
		logging.error('No OMZ Models informations!!')
	terminal_clean()
	banner('Benchmark Tool')
	cap_time = os.popen('echo $(date +\'%Y%m%d_%H%M%S\')').read().split()[0]
	reportFileName = current_path + '/OpenVINO_Benchmark_Report_' + cap_time[:-1] + '.csv'
	device = device_selector()
	model = model_selector()
	shift = 0
	add_arg = extend_arguments()
	with open(reportFileName,'w') as csvReport:
		reportCSV_writeInitial(csvReport,device,add_arg)
		with open(jsontemp_path,'r') as omzModel_info_json:
			omzModel_Objs = json.load(omzModel_info_json)
			if model == 'ERROR':
				logging.error('during model selection. Abort!')
				exit(1)
			elif model == 'ALL':
				shift = test_index()
				TotalmodelCounter = 0
				TotalOMZmodelCounter = 0
				for omzModel in omzModel_Objs:
					notbanned = True
					if TotalOMZmodelCounter >= shift:
						for banModel in model_test_ban_list:
							if omzModel['name'] == banModel:
								notbanned = False
						else:
							pass
					else:
						notbanned = False
					TotalmodelCounter +=  1 * notbanned
					TotalOMZmodelCounter +=1
				else:
					str1 = 'You are going to test ' + str(TotalmodelCounter) + ' of the Open Model Zoo''s models! It might take a LONG TIME!!'
					if shift:
						str1 += '(skip ' + str(shift) + ' models)'
					if len(model_test_ban_list):
						str1 += ' (' + len(model_test_ban_list) + ' model(s) will be banned.)'
					logging.warning('%s',str1)
				counter =0
				counter_shift = 0
				for omzModel in omzModel_Objs:
					notbanned = True
					counter_shift += 1
					if counter_shift >= shift:
						for banModel in model_test_ban_list:
							if omzModel['name'] == banModel:
								notbanned = False
						else:
							if notbanned:
								counter += 1
								print( '\n[{count}/{total} - {persent}]===== Benchmarking OMZ Model [{modelName}] on {target} ====='.format(count = counter, total=TotalmodelCounter,persent='%.1f %%' % (counter/TotalmodelCounter*100), modelName=omzModel['name'], target=device) )
								OMZmodel_excutor(omzModel,csvReport,device,add_arg)
							else:
								logging.info('Skip banned model [%s] at %s',omzModel['name'],os.popen('echo $(date +\'%Y/%m/%d_%H:%M:%S\')').read())
					else:
						notbanned = False

			else:
				if os.path.isfile(model):
					print( '\n>>>>>>> Benchmarking [%s] on %s >>>>>>>', model,device)
					specificModel_excutor(model,csvReport,device,add_arg)
				else:
					for omzModel in omzModel_Objs:
						if model == omzModel['name']:
							print( '\n===== Benchmarking OMZ Model [{modelName}] on {target} ====='.format(modelName=omzModel['name'], target=device) )
							OMZmodel_excutor(omzModel,csvReport,device,add_arg)
							logging.debug('[main] specific OMZ model test done!')
							break
					else:
						logging.error('The %s is neither a vailed path nor a model in Open Model Zoo!!')
						exit(1)

main()