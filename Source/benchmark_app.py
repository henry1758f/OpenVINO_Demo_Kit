# File: benchmark_app.py
# 2020/02/11	henry1758f 4.0.0	First Create with python instead of script

import json
import os
import string 
import csv

current_path = os.path.abspath(os.getcwd())
dump_modelinfo_path = '/opt/intel/openvino/deployment_tools/tools/model_downloader/info_dumper.py'
jsontemp_path = current_path + '/Source/model_info.json'
model_path = '~/openvino_models/models/SYNNEX_demo/'
ir_model_path = '~/openvino_models/ir/'
#print(jsontemp_path)
if os.path.isfile(jsontemp_path):
	os.system('rm -r ' + jsontemp_path)
os.system(dump_modelinfo_path + " --all >> " + jsontemp_path)


def check_jsontemp_exist():
	if not os.path.isfile(jsontemp_path):
		print('[ERROR] ' + jsontemp_path + ' is not exist! ')
		return False
	else:
		return True



def terminal_clean():
	os.system('clear')

def banner():
	print("|=========================================|")
	print("|              Benchmark App              |")
	print("|=========================================|")
	print("|  Support OpenVINO " + os.popen('echo $VERSION_VINO').read() )
	print("")

def target_device_select():
	global Target_Device 
	Target_Device = input('> Input your target device. (CPU,GPU,MYRIAD,HDDL,etc.) ')

def model_list_show_select():
	if check_jsontemp_exist() :
		global jsonObj_Array
		input_file = open(jsontemp_path,'r')
		jsonObj_Array = json.load(input_file)
		i = 0
		print('\n===== Model List =====')
		for item in jsonObj_Array:
			i+=1
			print(str(i) +'. ' + item['name'] + '\t\t([' + item['framework'] + '] a/an ' + item['task_type'] + ' model. )')
		
		global selected 
		selected = input('\n> Please input a number/name/path of the model which you are gonna test, or input "all" for a whole testing.\t >> ')
		if selected == 'all' or selected == 'ALL' or selected == 'All':
			print('[INFO] All ' + str(i) + ' models will be test!! ')
		else:
			i = 0
			for item in jsonObj_Array:
				i+=1
				if str(i) == str(selected) or item['name'] == str(selected) :
					print('[INFO] ' + str(i) +'. ' + item['name'] + ' been selected.')
					break;
			else:
				if os.path.isfile(selected):
					print('[INFO] ' + selected + ' been selected.')
				else:
					print('[ERROR] Invaild Input " ' + selected + ' "!!')
					print('[DEBUG] i=' + str(i) + ', selected=' + str(selected) )
		input_file.close()

def model_testing_times_input():
	global model_testing_times
	model_testing_times = input('\n> How many times you want to test per model\t >> ')

def any_other_arguments_input():
	global other_arguments
	other_arguments = input('\n> If you have any other arguments that needed, input here, or skip it by just press "ENTER" \t >> ')

def excuting():
	cap_time = os.popen('echo $(date +\'%Y%m%d_%H%M%S\')').read()
	reportFileName = current_path + '/OpenVINO_Performance_Test_Report_' + cap_time[:-1] + '.csv'
	print('[INFO] Current Time : ' + cap_time )
	if selected == 'all' or selected == 'ALL' or selected == 'All':
		with open(reportFileName,'w') as csvReport:
			print(reportFileName)
			csvWriter = csv.writer(csvReport)
			csvWriter.writerow(['Device_Info', os.popen('lscpu |grep "Model name:" ').read()[20:-1]])
			csvWriter.writerow(['Target_Device',Target_Device])
			csvWriter.writerow(['Model_Name','Precisions','Performance','Model_framework','Model_Task_Type','Model_Description'])
			csvReport.flush()
			os.system('test -e $SAMPLE_LOC/hello_query_device || $Source_Sample_Build')
			print(os.popen('$SAMPLE_LOC/hello_query_device | grep -e \'Device\' -a -e \'FULL_DEVICE_NAME\' -a -e \'RANGE_FOR_ASYNC_INFER_REQUESTS\' -a -e \'RANGE_FOR_STREAMS\'').read())
			for item in jsonObj_Array:

				for precisions in item['precisions']:
					if 'intel/' in item['subdirectory']:
						Path = model_path + item['subdirectory'] + '/' + precisions + '/' + item['name'] + '.xml'
					elif 'public/' in item['subdirectory']:
						Path = ir_model_path + item['subdirectory'] + '/' + precisions + '/' + item['name'] + '.xml'
					print('===== Testing [ ' + item['name'] + ' ][' + precisions + '] =====')
					print('> Path: ' + Path)

					result_string = '=AVERAGE('
					for times in range(int(model_testing_times)):
						result_raw = os.popen('$SAMPLE_LOC/benchmark_app' + ' -m ' + Path + ' -d ' + Target_Device + ' ' + other_arguments + ' |grep "Throughput" ').read()
						#result_raw = os.popen('$SAMPLE_LOC/benchmark_app' + ' -m ' + Path + ' -d ' + Target_Device + ' ' + other_arguments ).read()
						result = result_raw[len('Throughput:'):-len('FPS ')]
						print('> [' + str(times+1) + '] ' + str(result) + ' FPS ')
						result_string += result
						result_string += ','
					else:
						result_string = result_string[:-1]
						result_string += ')'
						#print(result_string)
						csvWriter.writerow([item['name'],precisions,result_string,item['framework'],item['task_type'],item['description']])
						csvReport.flush()
	else:
		for item in jsonObj_Array:
			if selected == item['name']:
				with open(reportFileName,'w') as csvReport:
					print(reportFileName)
					csvWriter = csv.writer(csvReport)
					csvWriter.writerow(['Device_Info', os.popen('lscpu |grep "Model name:" ').read()[20:-1]])
					csvWriter.writerow(['Target_Device',Target_Device])
					csvWriter.writerow(['Model_Name','Precisions','Performance','Model_framework','Model_Task_Type','Model_Description'])
					csvReport.flush()
					for precisions in item['precisions']:
						if 'intel/' in item['subdirectory']:
							Path = model_path + item['subdirectory'] + '/' + precisions + '/' + item['name'] + '.xml'
						elif 'public/' in item['subdirectory']:
							Path = ir_model_path + item['subdirectory'] + '/' + precisions + '/' + item['name'] + '.xml'
						print('===== Testing [ ' + item['name'] + ' ][' + precisions + '] =====')
						print('> Path: ' + Path)

						result_string = '=AVERAGE('
						for times in range(int(model_testing_times)):
							result_raw = os.popen('$SAMPLE_LOC/benchmark_app' + ' -m ' + Path + ' -d ' + Target_Device + ' ' + other_arguments + ' |grep "Throughput" ').read()
							#result_raw = os.popen('$SAMPLE_LOC/benchmark_app' + ' -m ' + Path + ' -d ' + Target_Device + ' ' + other_arguments ).read()
							result = result_raw[len('Throughput:'):-len('FPS ')]
							print('> [' + str(times+1) + '] ' + str(result) + ' FPS ')
							result_string += result
							result_string += ','
						else:
							result_string = result_string[:-1]
							result_string += ')'
							#print(result_string)
							csvWriter.writerow([item['name'],precisions,result_string,item['framework'],item['task_type'],item['description']])
							csvReport.flush()
			elif os.path.isfile(selected):
				with open(reportFileName,'w') as csvReport:
					print(reportFileName)
					csvWriter = csv.writer(csvReport)
					csvWriter.writerow(['Device_Info', os.popen('lscpu |grep "Model name:" ').read()[20:-1]])
					csvWriter.writerow(['Target_Device',Target_Device])
					csvWriter.writerow(['Model_Name','Precisions','Performance','Model_framework','Model_Task_Type','Model_Description'])
					csvReport.flush()
					Path = selected
					print('===== Testing [ ' + Path + ' ] =====')
					print('> Path: ' + Path)

					result_string = '=AVERAGE('
					for times in range(int(model_testing_times)):
						result_raw = os.popen('$SAMPLE_LOC/benchmark_app' + ' -m ' + Path + ' -d ' + Target_Device + ' ' + other_arguments + ' |grep "Throughput" ').read()
						#result_raw = os.popen('$SAMPLE_LOC/benchmark_app' + ' -m ' + Path + ' -d ' + Target_Device + ' ' + other_arguments ).read()
						result = result_raw[len('Throughput:'):-len('FPS ')]
						print('> [' + str(times+1) + '] ' + str(result) + ' FPS ')
						result_string += result
						result_string += ','
					else:
						result_string = result_string[:-1]
						result_string += ')'
						#print(result_string)
						csvWriter.writerow([Path,'',result_string])
						csvReport.flush()
				break
			else:
				print('[ERROR] No options / Model Path as " ' + selected + 'Please check your input words.')
				break

###########
terminal_clean()
banner()

target_device_select()
model_list_show_select()
model_testing_times_input()
any_other_arguments_input()
excuting()