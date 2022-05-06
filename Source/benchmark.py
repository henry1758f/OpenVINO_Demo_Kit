# File: benchmark.py
import json
import os
import string 
import logging
import sys
import csv
from pathlib import Path

from common_demo import banner

logging.basicConfig(format='[ %(levelname)s ] %(message)s',level=logging.DEBUG)

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'
OMZ_path_parent=str(Path.home())

python_execute='/usr/bin/python3'
openvinoPath=''
sampleSource='/opt/intel/openvino_2022/samples/cpp'
samplePath=str(Path.home()) + '/inference_engine_{}_samples_build'.format(os.path.basename(os.getcwd()))
modelPath= str(Path.home()) + '/open_model_zoo_models'
OMZPath=''
openvinoVersion= ''
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

def listModels():
    banner('Benchmark App for {}'.format(openvinoVersion))
    models_info_JSON = json.loads(os.popen('{python} {omzPath}/tools/model_tools/info_dumper.py --all'.format(python=python_execute, omzPath=OMZPath)).read())
    model_index=0
    modelSelected= ''
    for model_info in models_info_JSON:
        model_index +=1
        print('{index}. {name}'.format(index=model_index, name=model_info['name']))
    choose_model = input('\n >>> Input the Index number or the Model name you want to Download.\n > ')
    if choose_model.isnumeric():
        modelSelected=models_info_JSON[int(choose_model)-1]['name']
    else:
        modelSelected=choose_model
    logging.debug(modelSelected)

def main():
    init()
    listModels()
main()