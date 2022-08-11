# File: benchmark.py
from ctypes import sizeof
import json
import os
import logging
import csv
from pathlib import Path

from omz_demos import banner

logging.basicConfig(format='[ %(levelname)s ] %(message)s',level=logging.DEBUG)

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'
OMZ_path_parent=str(Path.home())

targetDevice='CPU'
python_execute='/usr/bin/python3'
openvinoPath=''
sampleSource='/opt/intel/openvino_2022/samples/cpp'
samplePath=str(Path.home()) + '/inference_engine_{}_samples_build'.format(os.path.basename(os.getcwd()))
benchmarkTool=samplePath + '/intel64/Release/benchmark_app'
modelPath= str(Path.home()) + '/open_model_zoo_models'
OMZPath=''
openvinoVersion= ''
reportPath='default'
reportflag=True
reportName='OpenVINO_Benchmark_Report'
model_test_ban_list = []
model_skip = 0

with open(kit_info,'r') as DemoKitinfo:
    DemoKitJSON = json.load(DemoKitinfo)
    python_execute= DemoKitJSON['pythonExcute']
    openvinoPath= DemoKitJSON['openvinoPath']
    openvinoVersion= DemoKitJSON['openvinoVersion']
    if not DemoKitJSON['OMZ']['path'] == '$HOME':
        OMZ_path_parent= DemoKitJSON['OMZ']['path']
    OMZPath= OMZ_path_parent + '/' + 'open_model_zoo-' + DemoKitJSON['OMZ']['tag']
    if not DemoKitJSON['sample']['path'] == '$HOME':
        samplePath = DemoKitJSON['sample']['path']
    if not DemoKitJSON['modelPath'] == '$HOME':
        modelPath = DemoKitJSON['modelPath']
        if not Path(modelPath).is_dir():
            logging.debug('Default Model Directory not found. Create one in {} ....'.format(modelPath))
            os.system('mkdir {}'.format(modelPath))
    if not DemoKitJSON['benchmark']['reportPath'] == 'default':
        reportPath = DemoKitJSON['benchmark']['reportPath']
        if not Path(reportPath).is_dir():
            logging.debug('Default Report Directory not found. Create one in {} ....'.format(reportPath))
            os.system('mkdir {}'.format(reportPath))
    reportName= DemoKitJSON['benchmark']['reportName']
    reportflag= DemoKitJSON['benchmark']['report']
    model_test_ban_list = DemoKitJSON['benchmark']['modelBan']
    model_skip = DemoKitJSON['benchmark']['skip']

sampleSource = openvinoPath + '/samples/cpp'

def init():
    if not Path(sampleSource + '/build_samples.sh').is_file():
        logging.error('Cannot find benchmark sample code! Please check the installation of OpenVINO!')
        exit('{} Not Found!'.format(sampleSource + '/build_samples.sh'))
    else:
        logging.debug('Checking {} exist?'.format(samplePath))
        if not Path(samplePath).is_dir():
            logging.debug('Building samples to {}'.format(samplePath))
            os.system(sampleSource + '/build_samples.sh -b ' + samplePath)
        else:
            logging.debug('Checking {} DONE.'.format(samplePath))
        logging.debug('Checking {} exist?'.format(OMZPath))
        if not Path(OMZPath).is_dir():
            logging.error('{} not found! You have to download and initial the Open Model Zoo repo.')
        else:
            logging.debug('Checking {} DONE.'.format(OMZPath))

def device_select():
    return input('\n >>> Input the target device that you want to test. (CPU,GPU,AUTO,MULTI,etc.)\n > ')

def listModels():
    models_info_JSON = json.loads(os.popen('{python} {omzPath}/tools/model_tools/info_dumper.py --all'.format(python=python_execute, omzPath=OMZPath)).read())
    model_index=0
    for model_info in models_info_JSON:
        model_index +=1
        supportPrecision = ''
        for precision in model_info['precisions']:
            supportPrecision += ' [{}] '.format(precision)
        for precisionQuant in model_info['quantization_output_precisions']:
            supportPrecision += ' [{}] '.format(precisionQuant)
        print('{index}. {name}\t{precision}'.format(index=model_index, name=model_info['name'], precision=supportPrecision))
    choose_model = input('\n >>> Input the Index number or the Model name you want to benchmark on [{}]. Or type "all" to benchmark all models.\n > '.format(targetDevice))
    if choose_model.isnumeric():
        return models_info_JSON[int(choose_model)-1]['name']
    elif choose_model == 'all' or choose_model == 'ALL' or choose_model == 'All':
        return 'all'
    elif os.path.isfile(choose_model.strip()):
        logging.debug('You have choose a model in {}'.format(choose_model))
        
        return choose_model
    else:
        for model_info in models_info_JSON:
            if choose_model == model_info['name']:
                return model_info['name']
        else:
            logging.warning('Cannot find model named "{}" in OMZ model, or as a path.'.format(choose_model))

def resultString_processor(resultDumpString):
    throughput = 'N/A'
    latency = ['N/A', 'N/A','N/A','N/A']
    # latency[0]: Average
    # latency[1]: Median
    # latency[2]: Min
    # latency[3]: Max
    count = '0'
    duration = '0'
    try:
        resultDumpString = resultDumpString.split('Dumping statistics report')[1]
        resultsString = resultDumpString.split('\n')
        
        for resultString in resultsString:
            if 'Count' in resultString:
                count = resultString.strip().split()[4]
            elif 'Duration' in resultString:
                duration = resultString.strip().split()[4]
            elif 'Median' in resultString:
                latency[1] = resultString.strip().split()[4]
            elif 'Average' in resultString:
                latency[0] = resultString.strip().split()[4]
            elif 'Min' in resultString:
                latency[2] = resultString.strip().split()[4]
            elif 'Max' in resultString:
                latency[3] = resultString.strip().split()[4]
            elif 'Throughput' in resultString:
                throughput = resultString.strip().split()[4]
    except :
        logging.error('Some ERROR happened during processing the result!')
    return throughput, latency, count, duration

def OMZmodel_path(model_info_JSON,precision):
    convert = ''
    if model_info_JSON['framework'] != 'dldt':
        convert = '/convert'
    return modelPath + convert + '/' + model_info_JSON['subdirectory'] + '/' + precision + '/' + model_info_JSON['name'] + '.xml'

def benchmark_OMZmodel(model_info_JSON, targetDevice, precision ,arguments):
    model = OMZmodel_path(model_info_JSON,precision)
    excuteString = benchmarkTool + ' -d ' + targetDevice + ' -m ' + model + ' ' + arguments
    logging.debug(excuteString) 
    resultDumpString = os.popen(excuteString).read()
    return resultString_processor(resultDumpString)

def benchmark_Specificmodel(model, targetDevice ,arguments):
    excuteString = benchmarkTool + ' -d ' + targetDevice + ' -m ' + model + ' ' + arguments
    logging.debug(excuteString) 
    resultDumpString = os.popen(excuteString).read()
    return resultString_processor(resultDumpString)

def reportCSV_writeInitial(reportCSV,Target_Device,add_arg):
    try:
        csvWriter = csv.writer(reportCSV)
        csvWriter.writerow(['Device_Info', os.popen('lscpu |grep "Model name:" ').read()[20:-1]])
        csvWriter.writerow(['Target_Device',Target_Device,'Additional Arguments',add_arg])
        csvWriter.writerow(['Model_Task_Type','Model_framework','Model_Name','Precisions','Throughput','Latency_Avg','Latency_Min','Latency_Mid','Latency_Max','Count','Duration','Model_Description','Model_Path'])
        reportCSV.flush()
        
    except Exception as e:
        logging.error('Error while Initializing the report file [%s]',e)

def reportCSV_write(reportCSV,model,path,precisions,reportThroughput,reportLatency,testCount,testDuration):
    try:
        csvWriter = csv.writer(reportCSV)
        csvWriter.writerow([model['task_type'],model['framework'],model['name'],precisions,reportThroughput,reportLatency[0],reportLatency[2],reportLatency[1],reportLatency[3],testCount,testDuration,model['description'],path])
        reportCSV.flush()
    except Exception as e:
        logging.error('Error while Writing results to the report file [%s]',e)

def reportCSV_writeSpecificmodel(reportCSV,path,reportThroughput,reportLatency,testCount,testDuration):
    nullString = 'N/A'
    try:
        model = Path(path).stem
        csvWriter = csv.writer(reportCSV)
        csvWriter.writerow([nullString,nullString,model,nullString,reportThroughput,reportLatency[0],reportLatency[2],reportLatency[1],reportLatency[3],testCount,testDuration,'Custom Model',path])
        reportCSV.flush()
    except Exception as e:
        logging.error('Error while Writing results to the report file [%s]',e)

def main():
    targetDevice = 'CPU'
    targetModel = ''
    init()
    banner('Benchmark App for {}'.format(openvinoVersion))
    targetDevice = device_select()
    targetModel = listModels()
    add_arg = input('\n >>> Input the addition parameter that you want to test. Or just press ENTER to skip it.\n > ')
    cap_time = os.popen('echo $(date +\'%Y%m%d_%H%M%S\')').read().split()[0]
    reportNamewithTime = reportName+'_'+cap_time+'.csv'
    reportThroughput = '0'
    reportLatency = '0'
    if reportflag:
        logging.debug('Will generate a report file named "{name}" in {path}'.format(name=reportName+'_'+cap_time+'.csv', path=reportPath))
    else:
        logging.debug('Will NOT generate a report file!')
    with open(reportNamewithTime,'w') as csvReport:
        reportCSV_writeInitial(csvReport,targetDevice,add_arg)
        models_info_JSON = json.loads(os.popen('{python} {omzPath}/tools/model_tools/info_dumper.py --all'.format(python=python_execute, omzPath=OMZPath)).read())
        if targetModel == 'all':
            logging.warning('You are going to test {count} of the Open Model Zoo''s models on {device}! It might take a LONG TIME!!'.format(count=len(models_info_JSON)-len(model_test_ban_list), device=targetDevice))
            count=0
            total= len(models_info_JSON)
            for model_info_JSON in models_info_JSON:
                skipFlag = False
                count +=1
                if model_skip > count:
                    logging.warning('Will skip {} model(s) due to demo_kit.json setting, please check the "skip" value!'.format(model_skip))
                    logging.warning('will SKIP "{}" >>>>'.format(model_info_JSON['name']))
                    skipFlag = True
                for model_test_ban in model_test_ban_list:
                    if model_test_ban in model_info_JSON['name']:
                        logging.warning('"{}" is on the ban list!(Setting in demo_kit.json), will SKIP this model !'.format(model_info_JSON['name']))
                        skipFlag = True
                if skipFlag:
                    continue

                print('\n[{time}]\n[{num}/{total}, {process}%] Benchmarking " {name} " >>>>>>'.format(num=count, \
                    total=total, process=round(count/total*100,2), name=model_info_JSON['name'], \
                    time=os.popen('echo $(date +\'%Y/%m/%d_%H:%M:%S\')').read().split()[0]))
                for precision in model_info_JSON['precisions']:
                    print(' \t[{}] >>>>'.format(precision))
                    reportThroughput, reportLatency, testCount, testDuration =  benchmark_OMZmodel(model_info_JSON,targetDevice,precision,add_arg)
                    print(' > Throughput: {} FPS, Latency:avg[ {} ms],median[ {} ms],min[ {} ms],max[ {} ]ms\n > TestCount: {} , TestDuraction: {} ms'.format(\
                        reportThroughput, reportLatency[0], reportLatency[1], reportLatency[2], reportLatency[3], testCount, testDuration))
                    reportCSV_write(csvReport,model_info_JSON,OMZmodel_path(model_info_JSON,precision),precision,reportThroughput,reportLatency,testCount, testDuration)

                for precision in model_info_JSON['quantization_output_precisions']:
                    print(' \t[{}] >>>>'.format(precision))
                    reportThroughput, reportLatency, testCount, testDuration =  benchmark_OMZmodel(model_info_JSON,targetDevice,precision,add_arg)
                    print(' > Throughput: {} FPS, Latency:avg[ {} ms],median[ {} ms],min[ {} ms],max[ {} ]ms\n > TestCount: {} , TestDuraction: {} ms'.format(\
                        reportThroughput, reportLatency[0], reportLatency[1], reportLatency[2], reportLatency[3], testCount, testDuration))
                    reportCSV_write(csvReport,model_info_JSON,OMZmodel_path(model_info_JSON,precision),precision,reportThroughput,reportLatency,testCount, testDuration)
                    
        else:       
            count=0
            total=1
            for model_info_JSON in models_info_JSON:
                if targetModel == model_info_JSON['name']:
                    count += 1
                    print('\n[{time}]\n[{num}/{total}, {process}%] Benchmarking " {name} " >>>>>>'.format(num=count, \
                    total=total, process=round(count/total*100,4), name=model_info_JSON['name'], \
                    time=os.popen('echo $(date +\'%Y/%m/%d_%H:%M:%S\')').read().split()[0]))
                    for precision in model_info_JSON['precisions']:
                        print(' \t[{}] >>>>'.format(precision))
                        reportThroughput, reportLatency, testCount, testDuration =  benchmark_OMZmodel(model_info_JSON,targetDevice,precision,add_arg)
                        print(' > Throughput: {} FPS, Latency:avg[ {} ms],median[ {} ms],min[ {} ms],max[ {} ]ms\n > TestCount: {} , TestDuraction: {} ms'.format(\
                            reportThroughput, reportLatency[0], reportLatency[1], reportLatency[2], reportLatency[3], testCount, testDuration))
                        reportCSV_write(csvReport,model_info_JSON,OMZmodel_path(model_info_JSON,precision),precision,reportThroughput,reportLatency,testCount, testDuration)
                        
                    for precision in model_info_JSON['quantization_output_precisions']:
                        print(' \t[{}] >>>>'.format(precision))
                        reportThroughput, reportLatency, testCount, testDuration =  benchmark_OMZmodel(model_info_JSON,targetDevice,precision,add_arg)
                        print(' > Throughput: {} FPS, Latency:avg[ {} ms],median[ {} ms],min[ {} ms],max[ {} ]ms\n > TestCount: {} , TestDuraction: {} ms'.format(\
                            reportThroughput, reportLatency[0], reportLatency[1], reportLatency[2], reportLatency[3], testCount, testDuration))
                        reportCSV_write(csvReport,model_info_JSON,OMZmodel_path(model_info_JSON,precision),precision,reportThroughput,reportLatency,testCount, testDuration)
                    break
            else:
                if os.path.isfile(str(targetModel).strip()):
                    count += 1
                    print('\n[{time}]\n[{num}/{total}, {process}%] Benchmarking from " {name} " >>>>>>'.format(num=count, \
                    total=total, process=round(count/total*100,4), name=targetModel, \
                    time=os.popen('echo $(date +\'%Y/%m/%d_%H:%M:%S\')').read().split()[0]))
                    reportThroughput, reportLatency, testCount, testDuration =  benchmark_Specificmodel(targetModel,targetDevice,add_arg)
                    print(' > Throughput: {} FPS, Latency:avg[ {} ms],median[ {} ms],min[ {} ms],max[ {} ]ms\n > TestCount: {} , TestDuraction: {} ms'.format(\
                        reportThroughput, reportLatency[0], reportLatency[1], reportLatency[2], reportLatency[3], testCount, testDuration))
                    reportCSV_writeSpecificmodel(csvReport,targetModel,reportThroughput,reportLatency,testCount,testDuration)
                else:
                    logging.error('Cannot find model named "{}"'.format(targetModel))
                
main()
