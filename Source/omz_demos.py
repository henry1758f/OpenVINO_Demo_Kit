import os
import sys
import json
import logging
from pathlib import Path
from banner import opening_banner

logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'
openvinoPath=''
omzPath=''
omzBuild=''
samplePath=''
omzSource=''
omzTag=''
omzGit=''
python_execute=''

with open(kit_info,'r') as DemoKitinfo:
    DemoKitJSON = json.load(DemoKitinfo)
    # Reading Settings
    openvinoPath = DemoKitJSON['openvinoPath']
    python_execute = DemoKitJSON['pythonExcute']
    omzPath = DemoKitJSON['OMZ']['path']
    omzBuild = DemoKitJSON['OMZ']['build']
    samplePath = DemoKitJSON['sample']['path']
    omzTag = DemoKitJSON['OMZ']['tag']
    omzGit = DemoKitJSON['OMZ']['git']

openvino_envsetup = 'source ' + openvinoPath + '/setupvars.sh'

def build(python_execute,omzPath,omzBuild,omzGit,omzTag):
    if omzPath == '':
        logging.debug('Open Model Zoo Path is not set, will use "' + str(Path.home()) + '" as default.')
        DemoKitJSON = ''
        with open(kit_info,'r') as DemoKitinfo:
            DemoKitJSON = json.load(DemoKitinfo)
        defaultOMZpath = str(Path.home()) + '/open_model_zoo_' + omzTag
        
        logging.debug('Setting ' + defaultOMZpath + ' As Open Model Zoo Download Path.')
        DemoKitJSON['OMZ']['path'] = defaultOMZpath
        DemoKitJSON['OMZ']['build'] = defaultOMZbuild
        if not os.path.isdir(defaultOMZpath):
            os.system('git clone --recurse-submodules --branch ' + omzTag + ' --depth 1 ' + omzGit + ' ' + defaultOMZpath)
        if not os.path.isdir(defaultOMZpath):
            logging.error('Cannot clone Open Model Zoo repo.')
            return -1
        with open(kit_info, 'w', encoding='utf-8') as DemoKitinfoWrite:
            json.dump(DemoKitJSON, DemoKitinfoWrite, ensure_ascii=False, indent=4)
        with open(kit_info,'r') as DemoKitinfo:
            DemoKitJSON = json.load(DemoKitinfo)
            # Reading Settings
            omzPath = DemoKitJSON['OMZ']['path']
            if omzPath != defaultOMZpath:
                logging.error('There is some error while setting new OMZ path! {} {}'.format(omzPath,defaultOMZpath))
    else:
        logging.debug('Open Model Zoo dir detect, will start build demos')
        if omzBuild == '':
            DemoKitJSON = ''
            with open(kit_info,'r') as DemoKitinfo:
                DemoKitJSON = json.load(DemoKitinfo)
            defaultOMZbuild = str(Path.home()) + '/open_model_zoo_' + omzTag + '_build'
            logging.debug('Setting ' + defaultOMZbuild + ' As Open Model Zoo build Path.')
            DemoKitJSON['OMZ']['build'] = defaultOMZbuild
            with open(kit_info, 'w', encoding='utf-8') as DemoKitinfoWrite:
                json.dump(DemoKitJSON, DemoKitinfoWrite, ensure_ascii=False, indent=4)
            with open(kit_info,'r') as DemoKitinfo:
                DemoKitJSON = json.load(DemoKitinfo)
                # Reading Settings
                omzBuild = DemoKitJSON['OMZ']['build']
                if omzBuild != defaultOMZbuild:
                    logging.error('There is some error while setting new OMZ build path! {} {}'.format(omzBuild,defaultOMZbuild))
        # install prerequest and start building
        os.system('sudo apt install libopencv-dev python3-opencv')
        os.system(python_execute +' -mpip install --user -r ' + omzPath + '/demos/requirements.txt')
        logging.debug(openvino_envsetup + ' & ' + omzPath + '/demos/build_demos.sh -DENABLE_PYTHON=y --build_dir={}'.format(omzBuild))
        os.system(openvino_envsetup + ' & ' + omzPath + '/demos/build_demos.sh -DENABLE_PYTHON=y --build_dir={}'.format(omzBuild))

def main(arg):
    if arg == 'build':
        logging.debug('Demo Build')
        build(python_execute,omzPath,omzBuild,omzGit,omzTag)
    else:
        logging.debug('Demo Select')

try:
    arg = sys.argv[1]
except IndexError:
    arg = ''
main(arg)