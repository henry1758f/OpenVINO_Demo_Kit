import os
import json
import logging
from pathlib import Path
from banner import banner
from commonFunctions import setSettingValue,getSettingValue,yesnoSelection

logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

OSName=os.popen('cat /etc/os-release | grep "PRETTY_NAME"').read().split('"')[1]
OSversionID=os.popen('cat /etc/os-release | grep "VERSION_ID" | cut -c 13-17').read()
VendorID=os.popen('cat /proc/cpuinfo |grep "vendor_id"').read().split('\n')[0].split(':')[1]
kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'

openvinoVersion= getSettingValue(['openvinoVersion'])
python_execute= getSettingValue(['pythonExcute'])

banner('OpenVINO Installation')

def RuntimeInstall():
    openvinoPath= getSettingValue(['openvinoPath'])
    openvino_envsetup = 'source ' + openvinoPath + '/setupvars.sh'
    logging.debug('Install OpenVINO™ Runtime')
    if Path(openvinoPath).is_dir():
        if Path(openvinoPath+'/setupvars.sh').is_file():
            openvinoInstalled=os.popen('ls -l {} | grep "openvino" | cut -d">" -f 2 |cut -d"/" -f 4'.format(openvinoPath)).read()
            logging.info('OpenVINO ' + openvinoInstalled + ' Detect.')
            os.system(openvino_envsetup)
            return
    
    sudoStr = 'sudo '
    if openvinoPath == '':
        logging.debug('Set OpenVINO runtime path as default "/opt/intel" ')
        openvinoPath = '/opt/intel/openvino_2022'
        setSettingValue(['openvinoPath'],openvinoPath)
        if openvinoPath == getSettingValue(['openvinoPath']):
            logging.debug('Reset OpenVINO runtime path in json file SUCCESS.')
        else:
            logging.error('Reset OpenVINO runtime path in json file FAILED.')
            return

        sudoStr = 'sudo '
    elif str(Path.home()) in openvinoPath:
        sudoStr = ''
    logging.debug('Start installing OpenVINO™ Runtime in "' + openvinoPath + '"')
    os.system(sudoStr + 'mkdir /opt/intel')
    downloadosver = ''
    if 'Ubuntu' in OSName:
        if '18.04' in OSversionID:
            downloadosver = 'ubuntu18'
        elif '20.04' in OSversionID or '22.04' in OSversionID: # 22.04 is testing
            downloadosver = 'ubuntu20'
    os.system('curl -L https://storage.openvinotoolkit.org/repositories/openvino/packages/2022.3/linux/l_openvino_toolkit_{}_2022.3.0.9052.9752fafe8eb_x86_64.tgz --output ~/openvino_2022.3.0.tgz'.format(downloadosver))
    os.system('tar -xf ~/openvino_2022.3.0.tgz -C ~')
    
    os.system(sudoStr + 'mv ~/l_openvino_toolkit_ubuntu20_2022.3.0.9052.9752fafe8eb_x86_64 '+ str(os.path.dirname(openvinoPath)) + '/openvino_2022.3.0')
    os.system(sudoStr + 'ln -s {} {}'.format(str(os.path.dirname(openvinoPath)) + '/openvino_2022.3.0',openvinoPath))
    os.system(sudoStr + ' -E {}/install_dependencies/install_openvino_dependencies.sh'.format(openvinoPath))
    if yesnoSelection('Do you want to install Configurations for Intel® Processor Graphics (GPU) with OpenVINO™? (Y/n)'):
        os.system(sudoStr + ' -E {}/install_dependencies/install_NEO_OCL_driver.sh'.format(openvinoPath))
    if yesnoSelection('Do you want to install Configurations for Intel® Neural Compute Stick 2? (Y/n)'):
        os.system(sudoStr + ' -E {}/install_dependencies/install_NCS_udev_rules.sh'.format(openvinoPath))

def DevtoolInstall():
    logging.debug('Install OpenVINO™ Development Tools')
    os.system(python_execute + ' -m pip install --upgrade pip')
    os.system('pip install openvino-dev[caffe,ONNX,tensorflow2,pytorch,kaldi,mxnet]=={}'.format(openvinoVersion))
    logging.debug('Check OpenVINO™ Development Tools')
    os.system('mo -h')

def RequirementChecks():
    logging.info('System Requirements Checking...')
    logging.info('Checking if it has Intel Processor...')
    passFlag = True
    if 'Intel' in VendorID:
        logging.debug('[OK] - {}'.format(VendorID))
    else:
        passFlag = False
    logging.debug('Checking if OS meet the requirements...')
    if 'Ubuntu' in OSName:
        logging.debug('[OK] - {}'.format(OSName))
    else:
        passFlag = False
    logging.debug('Checking if OS version meet the requirements...')
    if '18.04' in OSversionID or '20.04' in OSversionID or '22.04' in OSversionID: # 22.04 is testing
        logging.debug('[OK] - {}'.format(OSversionID))
    else:
        passFlag = False
    
    if not passFlag:
        logging.error('Your system might not be able to run the Demo Kit.')
RequirementChecks()
RuntimeInstall()
DevtoolInstall()