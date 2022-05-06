# File: OpenModelZoo_demos.py
# Date: 2022/04/19
# Author: henry1758f

from posixpath import split
from common_demo import banner
import os
import json
import logging
import time
import sys
import subprocess

from pathlib import Path

logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'

OMZ_path_parent=str(Path.home())

openvinoPath=''
demokitVersion= ''
openvinoVersion= ''
OMZ_source=''
OMZ_git=''
OMZ_tag=''
OMZ_source_name=''
OMZ_source_type='git'
OMZ_asset='tar.gz'
#omz_source_type='package'
OMZPath=''
datasetPath=''
modelPath= str(Path.home()) + '/open_model_zoo_models'
python_execute='/usr/bin/python3'

with open(kit_info,'r') as DemoKitinfo:
    DemoKitJSON = json.load(DemoKitinfo)
    if not DemoKitJSON['OMZ']['path'] == '$HOME':
        OMZ_path_parent= DemoKitJSON['OMZ']['path']
    if not DemoKitJSON['modelPath'] == '$HOME':
        modelPath = DemoKitJSON['modelPath']
        if not Path(modelPath).is_dir():
            logging.debug('Default Model Directory not found. Create one in {} ....'.format(modelPath))
            os.system('mkdir {}'.format(modelPath))
    if not DemoKitJSON['datasetPath'] == 'modelPath':
        datasetPath = DemoKitJSON['datasetPath']
    else:
        datasetPath = modelPath
    demokitVersion = DemoKitJSON['demokitVersion']
    openvinoVersion= DemoKitJSON['openvinoVersion']
    openvinoPath= DemoKitJSON['openvinoPath']
    python_execute= DemoKitJSON['pythonExcute']
    OMZ_tag= DemoKitJSON['OMZ']['tag']
    OMZ_source_name= 'open_model_zoo-' + OMZ_tag
    OMZPath= OMZ_path_parent + '/' + 'open_model_zoo-' + DemoKitJSON['OMZ']['tag']
    OMZ_asset= DemoKitJSON['OMZ']['asset'] 
    OMZ_git= DemoKitJSON['OMZ']['git']
    OMZ_source= DemoKitJSON['OMZ']['source']
    
    
def initial():
    logging.info('Checking the Open Model Zoo folder...')
    if Path(OMZPath).is_dir() == True:
        logging.debug('Open Model Zoo folder EXIST!')
    else:
        if not Path(OMZPath + '/build_demos.sh').is_file():
            if OMZ_source_type == 'package':
                logging.info('Trying to download from {}!'.format(OMZ_source))
                os.system('wget ' + OMZ_source + ' -P ' + OMZ_path_parent)
                os.system('tar -zxf ' + OMZ_path_parent + '/' +OMZ_source_name + OMZ_asset +  ' --directory ' + OMZ_path_parent)
                if Path(OMZPath + '/demos/build_demos.sh').is_file():
                    os.system('rm ' + OMZ_path_parent + '/' + OMZ_source_name + OMZ_asset)
                else:
                    logging.error('Cannot get Open Model Zoo Package, Please check your Internet Connection.')
                    exit('Cannot get Open Model Zoo Package.')
            else:
                logging.info('Trying to clone repo from {}!'.format(OMZ_git))
                os.system('git clone -b ' + OMZ_tag + ' ' + OMZ_git + ' ' + OMZPath)
                if Path(OMZPath + '/demos/build_demos.sh').is_file():
                    os.system('cd ' + OMZPath + ' && git submodule update --init --recursive ')
                    if not Path(OMZPath + '/demos/thirdparty/gflags/CMakeLists.txt').is_file:
                        logging.error('Cannot get thirdparty repos. Please try again.  ')
                else:
                    logging.warning('{} is not exist!'.format(OMZPath + '/demos/build_demos.sh'))
                    logging.error('Cannot clone Open Model Zoo repository from {}, Please check your Internet Connection.'.format(OMZ_git))
                    exit('Cannot clone Open Model Zoo repository.')

        # Steps on https://docs.openvino.ai/2022.1/omz_tools_downloader.html
        os.system(python_execute +' -mpip install openvino-dev')
        os.system(python_execute + ' -mpip install --upgrade pip')
        os.system(python_execute + ' -mpip install ' + OMZPath + '/tools/model_tools/')
        #os.system(python_execute + '-mpip install --user -r ' + OMZPath + '/tools/model_tools/requirements-pytorch.in')
        #os.system(python_execute + '-mpip install --user -r ' + OMZPath + '/tools/model_tools/requirements-tensorflow.in')
        #os.system(python_execute + '-mpip install --user -r ' + OMZPath + '/tools/model_tools/requirements-paddle.in')

def tools():
    tools_featureList=['Model Downloader','Model Converter','Model Quantizer','Dataset Data Downloader']
    banner('Open Model Zoo - Model Downloader and Tools')
    index = 1
    for feature in tools_featureList:
        if 'Dataset Data Downloader' in feature:
            if Path(datasetPath + '/data/dataset_definitions.yml').is_file():
                feature += ' (DONE!)'
        print('{index}. {feature_string}'.format(index=str(index),feature_string=feature))
        index += 1
    choose = input('\n >>> Input the Index number or the feature name you want.\n')
    fetutreSelected=''
    try:
        if choose.isnumeric():
            fetutreSelected=tools_featureList[int(choose)-1]
        else:
            fetutreSelected=choose
        if fetutreSelected == 'Model Downloader':
            downloader()
        elif fetutreSelected == 'Model Converter':
            converter()
        elif fetutreSelected == 'Model Quantizer':
            converter()
        elif fetutreSelected == 'Dataset Data Downloader':
            dataset()
        else:
            raise

    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)

    os.system('omz_downloader --help')
    

def build_demos():
    banner('Open Model Zoo - Build Demos')
    os.system(python_execute + ' -mpip install --user -r {}/demos/requirements.txt'.format(OMZPath))
    os.system(OMZPath + '/demos/build_demos.sh')

def downloader():
    banner('Model Downloader')
    logging.info('Default Download folder is {}'.format(modelPath))
    featureList=['Download ALL models from Open Model Zoo',\
        'Download Specific Model from Open Model Zoo',\
        'Download Models using list file']
    index = 1
    for feature in featureList:
        print('{index}. {feature_string}'.format(index=str(index),feature_string=feature))
        index += 1
    choose = input('\n >>> Input the Index number or the feature name you want.\n')
    fetutreSelected=''
    try:
        if choose.isnumeric():
            fetutreSelected=featureList[int(choose)-1]
        else:
            fetutreSelected=choose
        if fetutreSelected == 'Download ALL models from Open Model Zoo':
            logging.warn('About 43 GB space will be use!')
            os.system('omz_downloader --all -o {downloadPath} -j8'.format(downloadPath=modelPath))
        elif fetutreSelected == 'Download Specific Model from Open Model Zoo':
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
            logging.debug('Downloading >> {} << '.format(modelSelected))
            os.system('omz_downloader --name {name} -o {downloadPath}'.format(name=modelSelected, downloadPath=modelPath))
        elif fetutreSelected == 'Download Models using list file':
            listfilePath = input('\n >>> Input the Path of the List File (Absolute path)\n > ')
            if not Path(listfilePath).is_file():
                raise ValueError('Your Input "{}" is not a vailed Path, Please check and try again.'.format(listfilePath))
            else:
                os.system('omz_downloader --list {path} -o {downloadPath}'.format(path=listfilePath, downloadPath=modelPath))
        else:
            raise

    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)

def converter():
    banner('Model Converter')
    featureList=['Convert ALL Open Model Zoo Models that have been downloaded',\
        'Convert Specific Model from Open Model Zoo',\
        'Convert Models using list file']
    index = 1
    for feature in featureList:
        print('{index}. {feature_string}'.format(index=str(index),feature_string=feature))
        index += 1
    choose = input('\n >>> Input the Index number or the feature name you want.\n')
    fetutreSelected=''
    try:
        if choose.isnumeric():
            fetutreSelected=featureList[int(choose)-1]
        else:
            fetutreSelected=choose
        if fetutreSelected == 'Convert ALL Open Model Zoo Models that have been downloaded':
            p = subprocess.Popen(['omz_converter', '--all', '-d', modelPath, '-o', modelPath, '-p', python_execute], env=dict(os.environ))
            p.communicate()
        elif fetutreSelected == 'Convert Specific Model from Open Model Zoo':
            models_convertable_List = os.popen('omz_converter --print_all').read().split('\n')
            model_index=0
            modelSelected= ''
            for models_convertable in models_convertable_List:
                if models_convertable == '':
                    break
                model_index +=1
                print('{index}. {name}'.format(index=model_index, name=models_convertable))
            choose_model = input('\n >>> Input the Index number or the Model name you want to Convert.\n > ')
            if choose_model.isnumeric():
                modelSelected=models_convertable_List[int(choose_model)-1]
            else:
                modelSelected=choose_model
            logging.debug('Converting >> {} << '.format(modelSelected))
            p = subprocess.Popen(['omz_converter', '--name', modelSelected, '-d', modelPath, '-o', modelPath, '-p', python_execute], env=dict(os.environ))
            p.communicate()
        elif fetutreSelected == 'Convert Models using list file':
            listfilePath = input('\n >>> Input the Path of the List File (Absolute path)\n > ')
            if not Path(listfilePath).is_file():
                raise ValueError('Your Input "{}" is not a vailed Path, Please check and try again.'.format(listfilePath))
            else:
                p = subprocess.Popen(['omz_converter', '--list', listfilePath, '-d', modelPath, '-o', modelPath, '-p', python_execute], env=dict(os.environ))
                p.communicate()
        else:
            raise

    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)

def quantizer():
    banner(' Model Quantizer')
    featureList=['Quantize ALL Open Model Zoo Models that available',\
        'Quantize Specific Model from Open Model Zoo',\
        'Quantize Models using list file']
    index = 1
    for feature in featureList:
        print('{index}. {feature_string}'.format(index=str(index),feature_string=feature))
        index += 1
    choose = input('\n >>> Input the Index number or the feature name you want.\n')
    fetutreSelected=''
    try:
        if choose.isnumeric():
            fetutreSelected=featureList[int(choose)-1]
        else:
            fetutreSelected=choose
        if fetutreSelected == 'Quantize ALL Open Model Zoo Models that available':
            p = subprocess.Popen(['omz_quantizer', '--all', '--model_dir', modelPath, '-o', modelPath, '-p', python_execute, '--dataset_dir', datasetPath], env=dict(os.environ))
            p.communicate()
        elif fetutreSelected == 'Quantize Specific Model from Open Model Zoo':
            models_convertable_List = os.popen('omz_quantizer --print_all').read().split('\n')
            model_index=0
            modelSelected= ''
            for models_convertable in models_convertable_List:
                if models_convertable == '':
                    break
                model_index +=1
                print('{index}. {name}'.format(index=model_index, name=models_convertable))
            choose_model = input('\n >>> Input the Index number or the Model name you want to Quantize.\n > ')
            if choose_model.isnumeric():
                modelSelected=models_convertable_List[int(choose_model)-1]
            else:
                modelSelected=choose_model
            logging.debug('Quantizing >> {} << '.format(modelSelected))
            p = subprocess.Popen(['omz_quantizer', '--name', modelSelected, '--model_dir', modelPath, '-o', modelPath, '-p', python_execute, '--dataset_dir', datasetPath], env=dict(os.environ))
            p.communicate()
        elif fetutreSelected == 'Quantize Models using list file':
            listfilePath = input('\n >>> Input the Path of the List File (Absolute path)\n > ')
            if not Path(listfilePath).is_file():
                raise ValueError('Your Input "{}" is not a vailed Path, Please check and try again.'.format(listfilePath))
            else:
                p = subprocess.Popen(['omz_quantizer', '--list', modelSelected, '--model_dir', modelPath, '-o', modelPath, '-p', python_execute, '--dataset_dir', datasetPath], env=dict(os.environ))
                p.communicate()
        else:
            raise

    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)


def dataset():
    banner('Dataset Data Downloader')
    if Path(datasetPath + '/data/dataset_definitions.yml').is_file():
        logging.debug('Dataset Info already existed!')

    p = subprocess.Popen(['omz_data_downloader', '-o', datasetPath], env=dict(os.environ))
    p.communicate()

###########
def main():
    initial()
    #terminal_clean()
    banner('Open Model Zoo automation tools')
    if str(sys.argv[1]) == 'build_demos':
        build_demos()
    elif str(sys.argv[1]) == 'downloader':
        tools()


main()