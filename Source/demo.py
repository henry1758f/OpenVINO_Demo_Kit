# File: demos.py
# Date: 2022/04/28
# Author: henry1758f

import os
import json
import logging
from pathlib import Path
from banner import opening_banner

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
    TotalfeatureList = [\
        'Install Intel Distribution of OpenVINO Toolkit',\
        'Run Benchmark',\
        'Run Demos from Open Model Zoo',\
        'Open Model Zoo Downloader and Tools',\
        'Build Open Model Zoo Demos',\
        'Run Deep Learning Streamer',\
        'Environment Settings' \
        ]
    featureList=[]
    for feature in TotalfeatureList:
        if 'Install' in feature and 'openvino_2022.1.0.643' in openvinoInstalled and openvinoInstalled != '':
            logging.debug(openvinoInstalled)
            continue    
        else:
            featureList.append(feature)
    i = 1
    for listItem in featureList:
        if 'Build Open Model Zoo Demos' in listItem:
            if Path(str(Path.home()) + '/omz_demos_build/intel64/Release/interactive_face_detection_demo').is_file():
                listItem += ' (DONE!)'
        print( str(i) + '. ' + listItem)
        i+=1
    choose = input('\n >>> Input the Index number or the feature name you want.\n')
    fetutreSelected=''
    try:
        if choose.isnumeric():
            fetutreSelected=featureList[int(choose)-1]
        else:
            fetutreSelected=choose
        if fetutreSelected == 'Install Intel Distribution of OpenVINO Toolkit':
            install_openvino()
        elif fetutreSelected == 'Run Benchmark':
            benchmark()
        elif fetutreSelected == 'Run Demos from Open Model Zoo':
            OMZ_run()
        elif fetutreSelected == 'Open Model Zoo Downloader and Tools':
            OMZ_tools()
        elif fetutreSelected == 'Build Open Model Zoo Demos':
            OMZ_build()
        elif fetutreSelected == 'Run Deep Learning Streamer':
            DLStreamer()
        elif fetutreSelected == 'Environment Settings':
            Appsetting()
        else:
            raise

    except:
        logging.error('Your Input is invaild! Please check your input or path and try again!')

def install_openvino():
    logging.debug('Install Intel Distribution of OpenVINO Toolkit')
    logging.info('Start Install OpenVINO Runtime on {}>>>> '.format(OSName))
    logging.debug('Step 1: Set Up the OpenVINO Toolkit APT Repository')
    publickeyName = 'GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB'
    publickeyPath = os.path.abspath(os.getcwd()) + '/' + publickeyName
    if not os.path.isfile(publickeyPath):
        os.system('wget https://apt.repos.intel.com/intel-gpg-keys/' + publickeyName)
    os.system('sudo apt-get install gnupg')
    os.system('sudo apt-key add ' + publickeyName)
    if '18.04' in OSversionID:
        os.system('echo "deb https://apt.repos.intel.com/openvino/2022 bionic main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2022.list')
    elif '20.04' in OSversionID:
        os.system('echo "deb https://apt.repos.intel.com/openvino/2022 focal main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2022.list')
    elif '22.04' in OSversionID:
        logging.error('Not support OpenVINO APT repo install on this version of Ubuntu yet.')
    else:
        logging.error('OS Not support!!')
        logging.debug('OSversionID: {}'.format(OSversionID))
    os.system('sudo apt update')
    logging.debug('Verify that the APT repository is properly set up. >>>> ')
    os.system('apt-cache search openvino')

    logging.debug('Step 2: Install OpenVINO Runtime Using the APT Package Manager')
    logging.debug('sudo apt install openvino-{}'.format(openvinoVersion[:-4]))
    os.system('sudo apt install openvino-{}'.format(openvinoVersion[:-4]))
    logging.debug('Check for Installed Packages and Versions')
    os.system('apt list --installed | grep openvino')
    os.system('sudo -E {}/install_dependencies/install_openvino_dependencies.sh')

    logging.debug('Step 3: Install OpenCV from APT')
    os.system('sudo apt install openvino-opencv')

    logging.debug('Step 4: Start Install OpenVINO Development Tools on {} >>>> '.format(OSName))
    os.system(python_execute + ' -m pip install --upgrade pip')
    os.system(python_execute + ' -m pip install openvino-dev')
    os.system('mo -h')
    os.system(python_execute + ' -m pip install --user -r {}/tools/requirements.txt'.format(openvinoPath))
    os.system(python_execute + ' -m pip install --user -r {}/tools/requirements_caffe.txt'.format(openvinoPath))
    os.system(python_execute + ' -m pip install --user -r {}/tools/requirements_kaldi.txt'.format(openvinoPath))
    os.system(python_execute + ' -m pip install --user -r {}/tools/requirements_mxnet.txt'.format(openvinoPath))
    os.system(python_execute + ' -m pip install --user -r {}/tools/requirements_onnx.txt'.format(openvinoPath))
    #os.system(python_execute + ' -m pip install --user -r {}/tools/requirements_tensorflow.txt'.format(openvinoPath))
    os.system(python_execute + ' -m pip install --user -r {}/tools/requirements_tensorflow2.txt'.format(openvinoPath))
    os.system(python_execute + ' -m pip install --user -r {}/tools/requirements_pytorch.txt'.format(openvinoPath))

    logging.debug('Step 5: Configurations for Intel Processor Graphics (GPU) >>>> ')
    os.system('sudo -E {}/install_dependencies/install_NEO_OCL_driver.sh'.format(openvinoPath))

    logging.debug('Step 6: Configure Inference on Non-CPU Devices >>>> ')
    i= 1
    noncpuDevicelist=['Intel Neural Compute Stick 2 (NCS2)','Intel Vision Accelerator Design with Intel Movidius VPUs(HDDL Plugin )']
    for noncpuDevice in noncpuDevicelist:
        print(str(i) + '. ' + noncpuDevice)
        i+=1
    print(str(i) + '. Skip this step.')

    myriad_choose = input(' > Which Non-CPU device might you test on your device? \n >>>>')
    try:
        if myriad_choose.isnumeric():
            fetutreSelected=noncpuDevicelist[int(myriad_choose)-1]
        else:
            fetutreSelected=myriad_choose
        if fetutreSelected == noncpuDevicelist[0]:
            os.system('sudo -E {}/install_dependencies/install_NCS_udev_rules.sh')
        elif fetutreSelected == noncpuDevicelist[1]:
            logging.warn('Please visit https://docs.openvino.ai/latest/openvino_docs_install_guides_installing_openvino_ivad_vpu.html#vpu-guide for further steps.')
        else:
            raise
    except:
        logging.warn('Skip the Non-CPU device setup!')
    
    main()
    

def benchmark():
    logging.debug('benchmark')
    os.system(python_execute + ' ' + os.path.abspath(os.getcwd()) + '/Source/benchmark.py')
    main()

def OMZ_run():
    logging.debug('Run Demos from Open Model Zoo')
    os.system(python_execute + ' ' + os.path.abspath(os.getcwd()) + '/Source/omz_demos.py')

def OMZ_tools():
    logging.debug('Open Model Zoo Downloader and Tools')
    os.system(python_execute + ' ' + os.path.abspath(os.getcwd()) + '/Source/omz_model_tools.py downloader')


def OMZ_build():
    logging.debug('Build Open Model Zoo Demos')
    logging.debug(python_execute + ' ' + os.path.abspath(os.getcwd()) + '/Source/omz_model_tools.py build_demos')
    os.system(python_execute + ' ' + os.path.abspath(os.getcwd()) + '/Source/omz_model_tools.py build_demos')
    main()

def DLStreamer():
    logging.debug('Run Deep Learning Streamer')

def Appsetting():
    logging.debug('Run App setting')
    

def main():
    opening_banner()
    features()

main()