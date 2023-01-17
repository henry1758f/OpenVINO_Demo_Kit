import os
import json
import logging
import importlib
from pathlib import Path
from banner import opening_banner
from commonFunctions import getSettingValue

logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'
OSName=os.popen('cat /etc/os-release | grep "PRETTY_NAME"').read().split('"')[1]
OSversionID=os.popen('cat /etc/os-release | grep "VERSION_ID" | cut -c 13-17').read()
openvinoInstalled=os.popen('ls -l /opt/intel/openvino_2022 | grep "openvino" | cut -d">" -f 2 |cut -d"/" -f 4').read()
python_execute='/usr/bin/python3'
AuthorName= 'SYNNEX Technology International Corp.'
AppName=    'Intel OpenVINO Demostration Kit'
openvinoPath=''
demokitVersion= ''
openvinoVersion= ''

sampleSource='/opt/intel/openvino_2022/samples/cpp'
samplePath=str(Path.home()) + '/inference_engine_{}_samples_build'.format(os.path.abspath(os.getcwd()))
with open(kit_info,'r') as DemoKitinfo:
    DemoKitJSON = json.load(DemoKitinfo)
    demokitVersion = DemoKitJSON['demokitVersion']
    openvinoVersion= DemoKitJSON['openvinoVersion']
    openvinoPath= DemoKitJSON['openvinoPath']
    python_execute= DemoKitJSON['pythonExcute']
    if not DemoKitJSON['sample']['path'] == '$HOME':
        samplePath = DemoKitJSON['sample']['path']

def features():
    openvinoInstalled=os.popen('ls -l /opt/intel/openvino_2022 | grep "openvino" | cut -d">" -f 2 |cut -d"/" -f 4').read()
    demoKitFeatures = ''
    demoKitFeaturesEnable = []
    with open(kit_info,'r') as DemoKitinfo:
        DemoKitJSON = json.load(DemoKitinfo)
        demoKitFeatures = DemoKitJSON['demoKitFeatures']
    
    for demoKitFeature in demoKitFeatures:
        if demoKitFeature['name'] == 'Install Intel Distribution of OpenVINO Toolkit':
            if not '2022.3' in openvinoInstalled:
                demoKitFeaturesEnable.append([demoKitFeature['name'],demoKitFeature['file'],demoKitFeature['intro']])
        elif demoKitFeature['name'] == 'Build Open Model Zoo Demos':
            if os.path.isdir(getSettingValue(['OMZ','build'])):
                demoKitFeaturesEnable.append([demoKitFeature['name']+' [DONE]',demoKitFeature['file'],demoKitFeature['intro']])
        else:
            demoKitFeaturesEnable.append([demoKitFeature['name'],demoKitFeature['file'],demoKitFeature['intro']])
    del demoKitFeatures
    count = 0
    for demoKitFeatureEnable in demoKitFeaturesEnable:
        count+=1 
        print('\t' + str(count) + '. ' + demoKitFeatureEnable[0])
    selection = input(' > Please select a number of the feature that you want >>>  ')
    try:
        if selection.isnumeric():
            return demoKitFeaturesEnable[int(selection)-1]
        else:
            for demoKitFeatureEnable in demoKitFeaturesEnable:
                if selection == demoKitFeatureEnable[0]:
                    return demoKitFeatureEnable
            else:
                raise
    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)

def main():
    opening_banner()
    featureName,featureFile,featureIntro = features()
    if featureName == 'Exit':
        return 0
    logging.debug(featureName + '///' + featureFile + '///' + featureIntro)
    os.system(python_execute + ' ' + os.path.abspath(os.getcwd()) + '/' + featureFile)
    main()
main()