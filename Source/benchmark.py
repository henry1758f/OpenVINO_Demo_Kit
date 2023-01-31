import os
import sys
import json
import logging
import csv
from pathlib import Path
from banner import banner
from commonFunctions import getSettingValue,setSettingValue,itemSelection,modelSelection,yesnoSelection,modelStageExtractor


logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

runwithPython=getSettingValue(['benchmark','python'])
genReportFlag=getSettingValue(['benchmark','report'])
benchmarkPath=getSettingValue(['benchmark','path'])


pythonExcute=getSettingValue(['pythonExcute'])
OMZPath=getSettingValue(['OMZ','path'])
#modelPath = getSettingValue(['OMZmodelPath'])

if benchmarkPath == '':
    logging.warning('Benchmark C++ Tool path is not set.')
    if not os.path.isfile(str(Path.home()) + 'openvino_cpp_samples_build/intel64/Release/benchmark_app'):
        logging.warning('Default benchmark C++ Tool not found. Will start build the OpenVINO samples.')
        openvinoPath=getSettingValue(['openvinoPath'])
        os.system('{openvinoPath}/samples/cpp/build_samples.sh'.format(openvinoPath=openvinoPath))
        benchmarkPath=str(Path.home()) + '/openvino_cpp_samples_build/intel64/Release/benchmark_app'
        if not os.path.isfile(benchmarkPath):
            logging.debug('Checking {} is exist?'.format(benchmarkPath))
            logging.error('Benchmark App C++ Tool Build Failed. Please check the log or make sure you have install OpenVINO.')
            exit()
    benchmarkPath=str(Path.home()) + '/openvino_cpp_samples_build/intel64/Release/benchmark_app'
    setSettingValue(['benchmark','path'],benchmarkPath)
    
benchmarkPath=getSettingValue(['benchmark','path'])
if not os.path.isfile(getSettingValue(['benchmark','path'])):
    logging.debug('Checking {} is exist?'.format(benchmarkPath))
    logging.error('Benchmark App C++ Tool Build Failed. Please check the log or make sure you have install OpenVINO.')
    exit()
if getSettingValue(['benchmark','python']):
    runwithPython=True

def resultExtractor(result,modelPath):
    #logging.debug('resultExtractor')
    # return [count, duration, throughput, latency[avg,mid,min,max], readtime, loadtime, modelInfo]
    count = '0'
    duration = '0'
    throughput = 'N/A'
    latency = ['N/A', 'N/A','N/A','N/A']  # latency[avg,mid,min,max]
    readtime = '0'
    loadtime = '0'
    modelInfo=['N/A','N/A','0']  # modelInfo[input,output,size]
    try:
        #logging.debug('Getting model files Reading and Compiling Time.....')
        result = result.split('Reading model files')[1]
        resultslines = result.split('\n')
        for resultsline in resultslines:
            if 'Read model took' in resultsline:
                readtime = resultsline.strip().split()[6]
            elif 'Compile model took' in resultsline:
                loadtime = resultsline.strip().split()[6]
        #logging.debug('Getting model files I/O informations.....')
        modelInputInfo = result.split('Resizing model to match image sizes and given batch')[0]
        modelInputInfolines = modelInputInfo.split('\n')
        InputcaptureFlag=False
        OutputcaptureFlag=False
        for modelInputInfoline in modelInputInfolines:
            #logging.debug(modelInputInfoline.strip().split())
            if 'Network inputs:' in modelInputInfoline:
                InputcaptureFlag=True
                continue
            elif 'Network outputs:' in modelInputInfoline:
                OutputcaptureFlag=True
                continue
            if InputcaptureFlag:
                modelInfo[0] = modelInputInfoline.split('[ INFO ] ')[1].strip()
                InputcaptureFlag=False
            if OutputcaptureFlag:
                modelInfo[1] = modelInputInfoline.split('[ INFO ] ')[1].strip()
                OutputcaptureFlag=False

        #logging.debug('Getting model benchmark results.....')
        result = result.split('Dumping statistics report')[1]
        resultslines = result.split('\n')
        for resultsline in resultslines:
            if 'Count' in resultsline:
                count = resultsline.strip().split()[4]
            elif 'Duration' in resultsline:
                duration = resultsline.strip().split()[4]
            elif 'Median' in resultsline:
                latency[1] = resultsline.strip().split()[4]
            elif 'Average' in resultsline:
                latency[0] = resultsline.strip().split()[4]
            elif 'Min' in resultsline:
                latency[2] = resultsline.strip().split()[4]
            elif 'Max' in resultsline:
                latency[3] = resultsline.strip().split()[4]
            elif 'Throughput' in resultsline:
                throughput = resultsline.strip().split()[4]
        
        #logging.debug('Getting model size.....')
        modelInfo[2] = os.stat(modelPath[:-3] + 'bin').st_size
    except Exception as e:
        logging.error('Some ERROR happened during processing the result! {}'.format(e))
    return count, duration, throughput, latency, readtime, loadtime, modelInfo
    

def SignleModel(modelPath,device='CPU',args=''):
    #logging.debug('SignleModel')
    excute='benchmark_app'
    count = '0'
    duration = '0'
    throughput = 'N/A'
    latency = ['N/A', 'N/A','N/A','N/A']  # latency[avg,mid,min,max]
    readtime = '0'
    loadtime = '0'
    modelInfo = ['N/A','N/A','0']  # modelInfo[input,output,size]
    if not runwithPython:
        excute = getSettingValue(['benchmark','path'])
    logging.debug('{excute} -d {device} -m {modelPath}  {args}'.format(excute=excute, device=device, modelPath=modelPath, args=args))
    result = os.popen('{excute} -d {device} -m {modelPath}  {args}'.format(excute=excute, device=device, modelPath=modelPath, args=args)).read()
    count, duration, throughput, latency, readtime, loadtime, modelInfo = resultExtractor(result,modelPath)
    logging.info('\n[BENCHMARK REPORT] \n count =\t{} \n duration =\t{} ms \n throughput =\t{} FPS \n \
latency[avg] =\t{} ms, latency[mid] = {} ms, latency[min] = {} ms, latency[max] = {} ms \n \
readtime =\t{} ms \n loadtime =\t{}ms\n Size =\t{} Bytes \n ModelInput =\n\t{} \n ModelOutput =\n\t{}'.format(count, duration, throughput, latency[0],latency[1],latency[2],latency[3], readtime, loadtime, modelInfo[2], modelInfo[0], modelInfo[1]))
    return count, duration, throughput, latency, readtime, loadtime, modelInfo

def benchmarkSingleModel(device='CPU',args='',reportCSVpath='',modelJSON=''):
    #logging.debug('benchmarkSingleModel')
    modelPath= getSettingValue(['OMZmodelPath'])
    if not modelJSON == '':
        logging.debug('TESTTTTT')
    else:
        # Manual Select Process
        models_info_JSON = json.loads(os.popen('{python} {OMZPath}/tools/model_tools/info_dumper.py --all'.format(python=pythonExcute, OMZPath=OMZPath)).read())
        modelList=[]
        for model_info in models_info_JSON:
            modelStageExtractorListModels = modelStageExtractor(model_info)
            for modelStageExtractorListModel in modelStageExtractorListModels:
                modelList.append(modelStageExtractorListModel)
        questionString='Select one model that you want to run benchmark'
        printDetail=False
        printAvailablePrecision=True
        modelSelectionResult = modelSelection(questionString,modelList,printDetail,printAvailablePrecision)
        if modelSelectionResult == -1:
            logging.error('Your Selection is invailed!!')
            return -1
        else:
            modelJSON = modelList[modelSelectionResult]
    if modelJSON['framework'] == 'dldt':
        modelPath+= '/' + modelJSON['subdirectory']
    else:
        modelPath+= '/ir/' + modelJSON['subdirectory']
    for precision in modelJSON['precisions'] + modelJSON['quantization_output_precisions']:
        model = '{modelPath}/{precision}/{name}.xml'.format(modelPath=modelPath,precision=precision,name=modelJSON['name'])
        logging.debug('Checking Existion -> Path:{}'.format(model))
        if os.path.isfile('{}'.format(model)):
            logging.debug('Start Benchmarking "{name}" model [{precision}]({model})'.format(name=modelJSON['name'],precision=precision,model=model))
            count, duration, throughput, latency, readtime, loadtime, modelInfo = SignleModel(model,device,args)
            # Writing Report File if Report Flag is true
            if genReportFlag:
                with open(reportCSVpath,'a') as csvReport:
                    reportCSV_write(csvReport, model, precision, count, duration, throughput, latency, readtime, loadtime, modelInfo, modelJSON)
        else:
            logging.warning('Model {modelPath}/{precision}/{name}.xml not exist!'.format(modelPath=modelPath,precision=precision,name=modelJSON['name']))
    
def benchmarkSpecificModel(device='CPU',args='',reportCSVpath=''):
    #logging.debug('benchmarkSpecificModel')
    modelPath = input(' > Input the Path of the model you want to run benchmark. >>> \n > ')
    modelPath = modelPath.strip()
    logging.debug('Check if the model path is exist.')
    modelList=[]
    if not os.path.isfile(modelPath):
        if not os.path.isdir(modelPath):
            logging.error('{} is not exist.Please check your input and try again.'.format(modelPath))
            return
        # Folder mode
        logging.debug('Checking models in {} folder'.format(modelPath))
        modelCheck=[]
        for (dirpath, dirnames, filenames) in os.walk(modelPath):
            for filename in filenames:
                logging.debug('Checking file {}'.format(os.path.join(dirpath, filename)))
                extension = filename[-4:]
                logging.debug(extension)
                if extension == '.xml' or extension == '.bin':
                    logging.debug('Listiing file {}'.format(os.path.join(dirpath, filename)))
                    modelCheck.append(os.path.join(dirpath, filename))
        # Check if there is any models
        for model in modelCheck:
            extension = model[-4:]
            if extension == '.xml':
                for binfile in modelCheck:
                    binextension = binfile[-4:]
                    if binextension == '.bin':
                        if binfile[:-4] == model[:-4]:
                            logging.debug('Find model "{}"'.format(model))
                            modelList.append(model)
    else:
        modelList.append(modelPath)
    if len(modelList) == 0:
        logging.error('No model to be benchmark!!')
    for model in modelList:
        count, duration, throughput, latency, readtime, loadtime, modelInfo = SignleModel(model,device,args)
        # Writing Report File if Report Flag is true
        if genReportFlag:
            with open(reportCSVpath,'a') as csvReport:
                reportCSV_writeSpecificmodel(csvReport, model, count, duration, throughput, latency, readtime, loadtime, modelInfo)

def benchmarkAllModels(device='CPU',args='',reportCSVpath=''):
    models_info_JSON = json.loads(os.popen('{python} {OMZPath}/tools/model_tools/info_dumper.py --all'.format(python=pythonExcute, OMZPath=OMZPath)).read())
    modelList=[]
    banList= getSettingValue(['benchmark','modelBan'])
    skip= getSettingValue(['benchmark','skip'])
    for model_info in models_info_JSON:
        modelStageExtractorListModels = modelStageExtractor(model_info)
        for modelStageExtractorListModel in modelStageExtractorListModels:
            for ban in banList:
                if modelStageExtractorListModel['name'] == ban:
                    logging.debug('Detect ban model: {}'.format(modelStageExtractorListModel['name']))
                    break
            else:
                modelList.append(modelStageExtractorListModel)
    total=len(modelList)-skip
    counter=0
    if skip>0:
        logging.warning('"Skip" is set to {}!'.format(str(skip)) )
    if len(banList) > 0 or skip>0:
        logging.warning('Following model(s) will NOT benchmark! (You can configure them in demo_kit.json file.)')
    if skip>0:
        counter=0
        for model in modelList:
            counter+=1
            print('\t{} \t(Skip)'.format(model['name']))
            if counter>=skip:
                break
    for ban in banList:
        print('\t{ban} \t(Ban List)')
    if not yesnoSelection(' We are going to benchmark {} models, it might take a long time! Enter Yes/y to continue.'.format(total)):
            logging.warning('Aborting benchmark ALL models.')
            return -1
    # Start
    for model in modelList:
        counter+=1
        logging.info('[{}/{}, {}%] Benchmarking {} model'.format(counter,total,round(counter/total*100,4), model['name']))
        benchmarkSingleModel(device,args,reportCSVpath,model)


def reportCSV_writeInitial(reportCSV,Target_Device,add_arg):
    try:
        csvWriter = csv.writer(reportCSV)
        kernelInfo = os.popen('uname -s -r').read()
        hostname = os.popen('hostname').read()
        ramInfo = os.sysconf('SC_PAGE_SIZE') * os.sysconf('SC_PHYS_PAGES')
        osInfo = ' '.join(os.popen('hostnamectl |grep "Operating System"').read().split(':')[1].split() )
        csvWriter.writerow(['Device_Info', os.popen('lscpu |grep "Model name:" ').read()[20:-1].strip(),'Target_Device',Target_Device,'Additional Arguments',add_arg])
        csvWriter.writerow(['Kernel',kernelInfo,'OS',osInfo,'RAM_size',ramInfo,'HostName',hostname])
        csvWriter.writerow(['Model_Task_Type','Model_framework','Model_Name','Precisions','Throughput(FPS)','Latency_Avg(ms)','Latency_Min(ms)','Latency_Mid(ms)','Latency_Max(ms)','Count','Duration(ms)','Model_Size(Byte)','Model_Load(ms)','Model_Input','Model_Output','Model_Description','Model_Path'])
        reportCSV.flush()
        
    except Exception as e:
        logging.error('Error while Initializing the report file [%s]',e)

def reportCSV_write(reportCSV, model, precision, count, duration, throughput, latency, readtime, loadtime, modelInfo, modelJSON):
    try:
        csvWriter = csv.writer(reportCSV)
        csvWriter.writerow([modelJSON['task_type'],modelJSON['framework'],modelJSON['name'],precision,throughput,latency[0],latency[2],latency[1],latency[3],count,duration,modelInfo[2],loadtime,modelInfo[0],modelInfo[1],modelJSON['description'],model])
        reportCSV.flush()
    except Exception as e:
        logging.error('Error while Writing results to the report file [%s]',e)

def reportCSV_writeSpecificmodel(reportCSV, path, count, duration, throughput, latency, readtime, loadtime, modelInfo):
    nullString = 'N/A'
    try:
        model = Path(path).stem
        csvWriter = csv.writer(reportCSV)
        csvWriter.writerow([nullString,nullString,model,nullString,throughput,latency[0],latency[2],latency[1],latency[3],count,duration,modelInfo[2],loadtime,modelInfo[0],modelInfo[1],nullString,path])
        reportCSV.flush()
    except Exception as e:
        logging.error('Error while Writing results to the report file [%s]',e)

def main():
    banner('OpenVINO Benchmark Tool')

    reportName=getSettingValue(['benchmark','reportName'])
    reportPath=getSettingValue(['benchmark','reportPath'])
    modelSkip=getSettingValue(['benchmark','skip'])
    modelBan=getSettingValue(['benchmark','modelBan'])

    tagStr='C++'
    if runwithPython:
        tagStr='Python'
    logging.debug('Will use {} Benchmark Tool'.format(tagStr))
        
    featureList=['Run All OMZ Models benchmark.(Will take a long time.)',\
                'Run Specific Open Model Zoo Model.',\
                'Run model that you assign.']
    # Device Selection
    excute='benchmark_app'
    if not runwithPython:
        excute = getSettingValue(['benchmark','path'])
    result = os.popen('{excute} -h |grep "Available target devices"'.format(excute=excute)).read()
    device = input('\n\nInput the target device to benchmark -> ({} is now available on your platform) \n > '.format(result.split('Available target devices:')[1].split()))
    # Argument input
    arg = input('\n\nIf you have additional arguments, Please Input now, or press ENTER to skip.\n > ')
    # Feature Selection
    selection= itemSelection('Select what you want to do with {} Benchmark_app'.format(tagStr),featureList)
    # Creating Report File if Report Flag is true
    if genReportFlag:
        if not reportPath == '':
            if not os.path.isdir(reportPath):
                logging.warning('{} is not exists. Will try to create...'.format(reportPath))
                os.system('mkdir {}'.format(reportPath))
            if not os.path.isdir(reportPath):
                logging.error('Cannot create path "{}". Will use {} instead.'.format(reportPath,os.path.abspath(os.getcwd())))
                reportPath=os.path.abspath(os.getcwd())
        time=os.popen('echo $(date +\'%Y%m%d_%H%M%S\')').read().split()[0]
        reportName+='-{}_{}.csv'.format(device,time)
        logging.debug('Will Generate Report File "{}{}"'.format(reportPath,reportName))
        with open(reportPath+reportName,'w') as csvReport:
            reportCSV_writeInitial(csvReport,device,arg)
    if selection == 0:
        logging.debug(featureList[selection])
        benchmarkAllModels(device,arg,reportPath+reportName)
    elif selection == 1:
        logging.debug(featureList[selection])
        benchmarkSingleModel(device,arg,reportPath+reportName)
    elif selection == 2:
        logging.debug(featureList[selection])
        benchmarkSpecificModel(device,arg,reportPath+reportName)

main()