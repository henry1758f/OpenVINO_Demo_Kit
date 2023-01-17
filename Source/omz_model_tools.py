import os
import sys
import json
import logging
from pathlib import Path
from banner import banner
from commonFunctions import getSettingValue,setSettingValue,itemSelection,modelSelection,yesnoSelection,modelStageExtractor

logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

OMZmodelsSize = '39.9 GB'
OMZConvertSize = '32 GB'

def modelDownloader(mode='common',name=''):
    # support common,all,specific,listfile
    logging.debug('modelDownloader')

    pythonExcute = getSettingValue(['pythonExcute'])
    OMZPath = getSettingValue(['OMZ','path'])
    OMZmodelPath = getSettingValue(['OMZmodelPath'])
    logging.debug('Check if OMZ model download Path is exist or not.')
    if not os.path.isdir(OMZmodelPath):
        logging.debug('OMZmodelPath is not set or {} not exists.')
        if OMZmodelPath == '':
            OMZmodelPath = str(Path.home()) + '/omz_models'
        os.system('mkdir {}'.format(OMZmodelPath))
        if not os.path.isdir(OMZmodelPath):
            logging.error('Failed to set OMZ models download path, please check the Settings or raise an issue on GitHub.')
            return -1
        else:
            setSettingValue(['OMZmodelPath'],OMZmodelPath)
            logging.debug('OMZmodelPath set to {}'.format(OMZmodelPath))
    featureList = ['Download All Open Model Zoo models',\
                    'Download Specific Open Model Zoo model',\
                    'Download Models using list file']
    if mode == 'common':
        logging.debug('Model downloader common mode')
        question='Please select what you want to do.\n [Download Path set to {}]'.format(OMZmodelPath)
        selection = itemSelection(question,featureList)
        if selection == 0:
            # Download All Open Model Zoo models
            modelDownloader('all')
        elif selection == 1:
            # Download Specific Open Model Zoo model
            logging.debug('Loading Available OMZ models...')
            models_info_JSON = json.loads(os.popen('{python} {OMZPath}/tools/model_tools/info_dumper.py --all'.format(python=pythonExcute, OMZPath=OMZPath)).read())
            model_index=0
            modelList=[]
            for model_info in models_info_JSON:
                modelStageExtractorListModels = modelStageExtractor(model_info)
                for modelStageExtractorListModel in modelStageExtractorListModels:
                    modelList.append(modelStageExtractorListModel)
            question = 'Which model you want to download?'
            modelSelectionResult = modelSelection(question,modelList)
            if modelSelectionResult == -1:
                logging.error('Your Selection is invailed!!')
                return -1
            else:
                logging.debug('Starting Download "{}" model'.format(modelList[modelSelectionResult]['name']))
                modelDownloader('specific',modelList[modelSelectionResult]['name'])
        elif selection == 2:
            # Download Models using list file
            modelDownloader('listfile',name)
    elif mode == 'all':
        logging.debug('Download All Open Model Zoo models')
        if yesnoSelection('Do you want to Download ALL Open Model Zoo Models? It will take around {size} space and might take a long time!'.format(size=OMZmodelsSize)):
            doConvert = yesnoSelection('Do you want to convert ALL OMZ Public models to OpenVINO IR? It will take around {size} space and might take a long time!'.format(size=OMZConvertSize))
            os.system('omz_downloader --all -o {downloadPath}'.format(downloadPath=OMZmodelPath))
            if doConvert:
                modelConverter('all')
        else:
            logging.warning('Aborting... (Refuse to download all OMZ models)')
    elif mode == 'specific':
        logging.debug('Starting Download "{}" model'.format(name))
        logging.debug('Checking {} is available or not.'.format(name))
        models_info_JSON = json.loads(os.popen('{python} {OMZPath}/tools/model_tools/info_dumper.py --all'.format(python=pythonExcute, OMZPath=OMZPath)).read())
        model_index=0
        modelList=[]
        modelData=''
        for model_info in models_info_JSON:
            modelStageExtractorListModels = modelStageExtractor(model_info)
            for modelStageExtractorListModel in modelStageExtractorListModels:
                modelList.append(modelStageExtractorListModel)
        for modelListItem in modelList:
            if modelListItem['name'] == name:
                modelData = modelListItem
        if modelData=='':
            logging.error('{} is not a model in Open Model Zoo!'.format(name))
        else:
            os.system('omz_downloader --name {name} -o {downloadPath}'.format(name=modelData['name'], downloadPath=OMZmodelPath))
            doConvert = False
            if not modelData['framework'] == 'dldt':
                doConvert = yesnoSelection('Do you want to convert {modelName} [{framework}] to OpenVINO IR?'.format(modelName=modelData['name'],framework=modelData['framework']))
            if doConvert:
                modelConverter('specific',modelData['name'])
    elif mode == 'listfile':
        logging.debug('Model Downloader Listfile mode, List File Path={}'.format(name))
        # TODO : List File download.
    else:
        logging.error('Item Selection Error.')
        return -1

def modelConverter(mode='common',name=''):
    # support common,all,specific,listfile
    logging.debug('modelConverter')
    pythonExcute = getSettingValue(['pythonExcute'])
    OMZPath = getSettingValue(['OMZ','path'])
    OMZmodelPath = getSettingValue(['OMZmodelPath'])
    # read/set OMZconvertPath
    OMZconvertPath = getSettingValue(['OMZconvertPath'])
    logging.debug('Check if OMZ model IR Path is exist or not.')
    if not os.path.isdir(OMZconvertPath):
        logging.debug('OMZmodelPath is not set or {} not exists. Try to create.')
        if OMZconvertPath == '':
            OMZconvertPath = str(Path.home()) + '/omz_models/ir'
        os.system('mkdir {}'.format(OMZconvertPath))
        if not os.path.isdir(OMZconvertPath):
            logging.error('Failed to set OMZ models IR path, please check the Settings or raise an issue on GitHub.')
            return -1
        else:
            setSettingValue(['OMZconvertPath'],OMZconvertPath)
            logging.debug('OMZconvertPath set to {}'.format(OMZconvertPath))

    if mode == 'common':
        featureList = ['Convert All Open Model Zoo models',\
                    'Convert Specific Open Model Zoo model',\
                    'Convert Models using list file',]
        question='Please select what you want to do.\n [Convert Path set to {}]'.format(OMZconvertPath)
        selection = itemSelection(question,featureList)
        if selection == 0:
            # Convert All Open Model Zoo models
            modelConverter('all')
        elif selection == 1:
            # Convert Specific Open Model Zoo model
            logging.debug('Loading Available OMZ models...')
            models_info_JSON = json.loads(os.popen('{python} {OMZPath}/tools/model_tools/info_dumper.py --all'.format(python=pythonExcute, OMZPath=OMZPath)).read())
            model_index=0
            modelList=[]
            for model_info in models_info_JSON:
                modelStageExtractorListModels = modelStageExtractor(model_info)
                for modelStageExtractorListModel in modelStageExtractorListModels:
                    modelList.append(modelStageExtractorListModel)
            question = 'Which model you want to convert?'
            modelSelectionResult = modelSelection(question,modelList)
            if modelSelectionResult == -1:
                logging.error('Your Selection is invailed!!')
                return -1
            else:
                logging.debug('Starting convert "{}" model'.format(modelList[modelSelectionResult]['name']))
                modelConverter('specific',modelList[modelSelectionResult]['name'])
        elif selection == 2:
            # Convert Models using list file
            # TODO: Convert Models using list file
            modelConverter('listfile',name)
    elif mode == 'all':
        logging.warning('Will convert all OMZ Public models! It might take around {} space on your device!')
        # os.system('{python} -m pip install keras'.format(python=pythonExcute)) # TODO for efficientdet-d0-tf,efficientdet-d1-tf 
        os.system('omz_converter --all -d {downloadPath} -o {convertPath}'.format(downloadPath=OMZmodelPath, convertPath=OMZconvertPath))
    elif mode == 'specific':
        logging.debug('Will convert {name} model'.format(name=name))
        # if 'efficientdet-d' in name: # TODO for efficientdet-d0-tf,efficientdet-d1-tf 
        #    os.system('{python} -m pip install keras'.format(python=pythonExcute))
        os.system('omz_converter --name {name} -d {downloadPath} -o {convertPath}'.format(name=name, downloadPath=OMZmodelPath, convertPath=OMZconvertPath))
    elif mode == 'listfile':
        logging.debug('Model Converter Listfile mode, List File Path={}'.format(name))
        # TODO : List File download.
    else:
        logging.error('Item Selection Error.')
        return -1

def modelQuantizer(mode='common',name=''):
    # support 'common', 'all', 'specific'
    # TODO : Model Quantizer
    #ARGS=' --dry_run'
    ARGS=''
    logging.debug('modelQuantizer')
    pythonExcute = getSettingValue(['pythonExcute'])
    OMZPath = getSettingValue(['OMZ','path'])
    OMZmodelPath = getSettingValue(['OMZmodelPath'])
    # read/set OMZconvertPath
    OMZconvertPath = getSettingValue(['OMZconvertPath'])
    OMZdatasetPath = getSettingValue(['OMZconvertPath'])
    logging.debug('Check if OMZ model IR Path is exist or not.')
    if not os.path.isdir(OMZconvertPath):
        logging.debug('OMZmodelPath is not set or {} not exists. Try to create.')
        if OMZconvertPath == '':
            OMZconvertPath = str(Path.home()) + '/omz_models/ir'
        os.system('mkdir {}'.format(OMZconvertPath))
        if not os.path.isdir(OMZconvertPath):
            logging.error('Failed to set OMZ models IR path, please check the Settings or raise an issue on GitHub.')
            return -1
        else:
            setSettingValue(['OMZconvertPath'],OMZconvertPath)
            logging.debug('OMZconvertPath set to {}'.format(OMZconvertPath))
    # read/set OMZdatasetPath
    OMZdatasetPath = getSettingValue(['OMZdatasetPath'])
    logging.debug('Check if OMZ model dataset Path is exist or not.')
    if not os.path.isdir(OMZdatasetPath):
        logging.debug('OMZdatasetPath is not set or {} not exists. Try to create.')
        if OMZdatasetPath == '':
            OMZdatasetPath = str(Path.home()) + '/omz_models/datasets'
        os.system('mkdir {}'.format(OMZdatasetPath))
        if not os.path.isdir(OMZdatasetPath):
            logging.error('Failed to set OMZ models dataset path, please check the Settings or raise an issue on GitHub.')
            return -1
        else:
            setSettingValue(['OMZdatasetPath'],OMZdatasetPath)
            logging.debug('OMZdatasetPath set to {}'.format(OMZdatasetPath))

    if mode == 'common':
        featureList = ['Quantize All available Open Model Zoo models',\
                    'Quantize Specific Open Model Zoo model',\
                    'Quantize Models using list file',]
        question='Please select what you want to do.\n [Convert Path set to {}]'.format(OMZconvertPath)
        selection = itemSelection(question,featureList)
        if selection == 0:
            # Quantize All available Open Model Zoo models
            modelQuantizer('all')
        elif selection == 1:
            # Convert Specific Open Model Zoo model
            logging.debug('Loading Available OMZ models...')
            models_info_JSON = json.loads(os.popen('{python} {OMZPath}/tools/model_tools/info_dumper.py --all'.format(python=pythonExcute, OMZPath=OMZPath)).read())
            model_index=0
            modelList=[]
            for model_info in models_info_JSON:
                modelStageExtractorListModels = modelStageExtractor(model_info)
                for modelStageExtractorListModel in modelStageExtractorListModels:
                    modelList.append(modelStageExtractorListModel)
            question = 'Which model you want to Quantize?'
            modelSelectionResult = modelSelection(question,modelList)
            if modelSelectionResult == -1:
                logging.error('Your Selection is invailed!!')
                return -1
            else:
                logging.debug('Starting Quantize "{}" model'.format(modelList[modelSelectionResult]['name']))
                modelQuantizer('specific',modelList[modelSelectionResult]['name'])
        elif selection == 2:
            # Convert Models using list file
            # TODO: Quantize Models using list file
            modelQuantizer('listfile',name)
    elif mode == 'all':
        logging.warning('Will Quantize all available OMZ Public models!')
        # os.system('{python} -m pip install keras'.format(python=pythonExcute)) # TODO for efficientdet-d0-tf,efficientdet-d1-tf 
        os.system('omz_quantizer --all --model_dir {model_dir} -o {output_dir} --dataset_dir {dataset_dir} {additional_arg}'.format(model_dir=OMZconvertPath, output_dir=OMZconvertPath,dataset_dir=OMZdatasetPath, additional_arg=ARGS))
    elif mode == 'specific':
        logging.debug('Will Quantize {name} model'.format(name=name))
        # if 'efficientdet-d' in name: # TODO for efficientdet-d0-tf,efficientdet-d1-tf 
        #    os.system('{python} -m pip install keras'.format(python=pythonExcute))
        os.system('omz_quantizer --name {name} --model_dir {model_dir} -o {output_dir} --dataset_dir {dataset_dir} {additional_arg}'.format(name=name,model_dir=OMZconvertPath, output_dir=OMZconvertPath,dataset_dir=OMZdatasetPath, additional_arg=ARGS))
    elif mode == 'listfile':
        logging.debug('Model Quantizer Listfile mode, List File Path={}'.format(name))
        # TODO : List File download.
    else:
        logging.error('Item Selection Error.')
        return -1

def datasetDownloader(mode='common'):
    logging.debug('datasetDownloader')
    # TODO : apt update for unzip
    datasetDownloaderList=['ImageNet',\
                            'Common Objects in Context (COCO)',\
                            'WIDER FACE',\
                            'Visual Object Classes Challenge 2012 (VOC2012)',\
                            'Visual Object Classes Challenge 2007 (VOC2007)',\
                            'SYGData0829',\
                            'erfnet_data',\
                            'PASCAL-S',\
                            'CoNLL2003 Named Entity Recognition',\
                            'MRL Eye',\
                            'Labeled Faces in the Wild (LFW)',\
                            'NYU Depth Dataset V2']
    pythonExcute = getSettingValue(['pythonExcute'])
    # read/set OMZdatasetPath
    OMZdatasetPath = getSettingValue(['OMZdatasetPath'])
    logging.debug('Check if OMZ model dataset Path is exist or not.')
    if not os.path.isdir(OMZdatasetPath):
        logging.debug('OMZdatasetPath is not set or {} not exists. Try to create.')
        if OMZdatasetPath == '':
            OMZdatasetPath = str(Path.home()) + '/omz_models/datasets'
        os.system('mkdir {}'.format(OMZdatasetPath))
        if not os.path.isdir(OMZdatasetPath):
            logging.error('Failed to set OMZ models dataset path, please check the Settings or raise an issue on GitHub.')
            return -1
        else:
            setSettingValue(['OMZdatasetPath'],OMZdatasetPath)
            logging.debug('OMZdatasetPath set to {}'.format(OMZdatasetPath))
    if mode == 'common':
        counter = 0
        items=[]
        for datasetDownloaderItem in datasetDownloaderList:
            existFlag=False
            existString=' [Dataset Detected.]'
            if datasetDownloaderItem == 'ImageNet':
                logging.debug('Checking ImageNet Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/ILSVRC2012_img_val') and \
                    os.path.isfile(OMZdatasetPath+'/val.txt') and \
                    os.path.isfile(OMZdatasetPath+'/val15.txt'):
                    existFlag=True
            elif datasetDownloaderItem == 'Common Objects in Context (COCO)':
                logging.debug('Checking COCO Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/val2017') and \
                    os.path.isfile(OMZdatasetPath+'/annotations/instances_val2017.json') and \
                    os.path.isfile(OMZdatasetPath+'/annotations/person_keypoints_val2017.json'):
                    existFlag=True
            elif datasetDownloaderItem == 'WIDER FACE':
                logging.debug('Checking WIDER FACE Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/WIDER_val/images') and \
                    os.path.isfile(OMZdatasetPath+'/wider_face_split/wider_face_val_bbx_gt.txt'):
                    existFlag=True
            elif datasetDownloaderItem == 'Visual Object Classes Challenge 2012 (VOC2012)':
                logging.debug('Checking VOC2012 Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/VOCdevkit/VOC2012/Annotations') and \
                    os.path.isdir(OMZdatasetPath+'/VOCdevkit/VOC2012/JPEGImages') and \
                    os.path.isdir(OMZdatasetPath+'/VOCdevkit/VOC2012/SegmentationClass') and\
                    os.path.isfile(OMZdatasetPath+'/VOCdevkit/VOC2012/ImageSets/Main/val.txt') and \
                    os.path.isfile(OMZdatasetPath+'/VOCdevkit/VOC2012/ImageSets/Segmentation/val.txt'):
                    existFlag=True
            elif datasetDownloaderItem == 'Visual Object Classes Challenge 2007 (VOC2007)':
                logging.debug('Checking VOC2007 Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/VOCdevkit/VOC2007/Annotations') and \
                    os.path.isdir(OMZdatasetPath+'/VOCdevkit/VOC2007/JPEGImages') and \
                    os.path.isfile(OMZdatasetPath+'/VOCdevkit/VOC2007/ImageSets/Main/val.txt'):
                    existFlag=True
            elif datasetDownloaderItem == 'SYGData0829':
                logging.debug('Checking SYGData0829 Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/SYGData0829/dataset_format_VOC2007/Annotations') and \
                    os.path.isdir(OMZdatasetPath+'/SYGData0829/dataset_format_VOC2007/JPEGImages') and \
                    os.path.isfile(OMZdatasetPath+'/SYGData0829/dataset_format_VOC2007/ImageSets/Main/val.txt'):
                    existFlag=True
            elif datasetDownloaderItem == 'erfnet_data':
                logging.debug('Checking erfnet_data Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/erfnet_data/Annotations') and \
                    os.path.isdir(OMZdatasetPath+'/erfnet_data/JPEGImages') and \
                    os.path.isfile(OMZdatasetPath+'/erfnet_data/erfnet_meta_zxw.json') and \
                    os.path.isfile(OMZdatasetPath+'/erfnet_data/val.txt'):
                    existFlag=True
            elif datasetDownloaderItem == 'PASCAL-S':
                logging.debug('Checking PASCAL-S Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/PASCAL-S/image') and \
                    os.path.isdir(OMZdatasetPath+'/PASCAL-S/mask'):
                    existFlag=True
            elif datasetDownloaderItem == 'CoNLL2003 Named Entity Recognition':
                logging.debug('Checking CoNLL2003 Named Entity Recognition Dataset is exist?')
                if os.path.isfile(OMZdatasetPath+'/CONLL-2003/valid.txt'):
                    existFlag=True
            elif datasetDownloaderItem == 'MRL Eye':
                logging.debug('Checking MRL Eye Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/mrlEyes_2018_01'):
                    existFlag=True
            elif datasetDownloaderItem == 'Labeled Faces in the Wild (LFW)':
                logging.debug('Checking Labeled Faces in the Wild (LFW) Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/LFW/lfw') and \
                    os.path.isfile(OMZdatasetPath+'/LFW/annotation/pairs.txt') and \
                    os.path.isfile(OMZdatasetPath+'/LFW/annotation/lfw_landmark.txt'):
                    existFlag=True
            elif datasetDownloaderItem == 'NYU Depth Dataset V2':
                logging.debug('Checking NYU Depth Dataset V2 Dataset is exist?')
                if os.path.isdir(OMZdatasetPath+'/nyudepthv2/val') and \
                    os.path.isdir(OMZdatasetPath+'/nyudepthv2/val/official') and \
                    os.path.isdir(OMZdatasetPath+'/nyudepthv2/val/converted/images') and\
                    os.path.isdir(OMZdatasetPath+'/nyudepthv2/val/converted/depth'):
                    existFlag=True
            if existFlag:
                items.append(datasetDownloaderItem+existString)
            else:
                items.append(datasetDownloaderItem)
        result = itemSelection('Select a dataset you want to download.',items)
        if result == 0:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            logging.warning('Please visit ImageNet website (http://www.image-net.org/) to obtain the dataset.')
            logging.warning('Tools cannot help downloading ImageNet datasets.')
            logging.warning('Also refer to (https://github.com/openvinotoolkit/open_model_zoo/blob/master/data/datasets.md#imagenet) for more info.')
        elif result == 1:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/val2017.zip http://images.cocodataset.org/zips/val2017.zip && curl -o {OMZdatasetPath}/annotations_trainval2017.zip http://images.cocodataset.org/annotations/annotations_trainval2017.zip'.format(OMZdatasetPath=OMZdatasetPath))
            logging.debug('Extracting {} Dataset'.format(datasetDownloaderList[result]))
            os.system('unzip {OMZdatasetPath}/val2017.zip -d {OMZdatasetPath}'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('unzip {OMZdatasetPath}/annotations_trainval2017.zip -d {OMZdatasetPath}'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/val2017.zip & rm -r {OMZdatasetPath}/annotations_trainval2017.zip'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 2:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/WIDER_val.zip -L https://huggingface.co/datasets/wider_face/resolve/main/data/WIDER_val.zip && curl -o {OMZdatasetPath}/wider_face_split.zip -L https://huggingface.co/datasets/wider_face/resolve/main/data/wider_face_split.zip'.format(OMZdatasetPath=OMZdatasetPath))
            logging.debug('Extracting {} Dataset'.format(datasetDownloaderList[result]))
            os.system('unzip {OMZdatasetPath}/wider_face_split.zip -d {OMZdatasetPath}'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('unzip {OMZdatasetPath}/WIDER_val.zip -d {OMZdatasetPath}'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/WIDER_val.zip & rm -r {OMZdatasetPath}/wider_face_split.zip'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 3:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/VOCtrainval_11-May-2012.tar -L http://host.robots.ox.ac.uk/pascal/VOC/voc2012/VOCtrainval_11-May-2012.tar '.format(OMZdatasetPath=OMZdatasetPath))
            logging.debug('Extracting {} Dataset'.format(datasetDownloaderList[result]))
            os.system('tar -xf {OMZdatasetPath}/VOCtrainval_11-May-2012.tar --directory {OMZdatasetPath}'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/VOCtrainval_11-May-2012.tar'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 4:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/VOCtrainval_06-Nov-2007.tar http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtrainval_06-Nov-2007.tar'.format(OMZdatasetPath=OMZdatasetPath))
            logging.debug('Extracting {} Dataset'.format(datasetDownloaderList[result]))
            os.system('tar -xf {OMZdatasetPath}/VOCtrainval_06-Nov-2007.tar --directory {OMZdatasetPath}'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/VOCtrainval_06-Nov-2007.tar'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 5:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/SYGData0829.z01 -L https://github.com/ermubuzhiming/OMZ-files-download/releases/download/v1-ly/SYGData0829.z01'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('curl -o {OMZdatasetPath}/SYGData0829.z02 -L https://github.com/ermubuzhiming/OMZ-files-download/releases/download/v1-ly/SYGData0829.z02'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('curl -o {OMZdatasetPath}/SYGData0829.z03 -L https://github.com/ermubuzhiming/OMZ-files-download/releases/download/v1-ly/SYGData0829.z03'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('curl -o {OMZdatasetPath}/SYGData0829.z04 -L https://github.com/ermubuzhiming/OMZ-files-download/releases/download/v1-ly/SYGData0829.zip'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('cat {OMZdatasetPath}/SYGData0829.z0* > {OMZdatasetPath}/SYGData0829.zip'.format(OMZdatasetPath=OMZdatasetPath))
            # unzip will return error 
            # p7zip-full must be installed
            os.system('7z x {OMZdatasetPath}/SYGData0829.zip -o"{OMZdatasetPath}"'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/SYGData0829.z*'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 6:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/Annotations.rar -L https://github.com/Zhangxianwen2021/ERFNet/releases/download/erfnet/Annotations.rar'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('curl -o {OMZdatasetPath}/JPEGImages.rar -L https://github.com/Zhangxianwen2021/ERFNet/releases/download/erfnet/JPEGImages.rar'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('curl -o {OMZdatasetPath}/erfnet_meta_zxw.json -L https://github.com/Zhangxianwen2021/ERFNet/releases/download/erfnet/erfnet_meta_zxw.json'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('curl -o {OMZdatasetPath}/val.txt -L https://github.com/Zhangxianwen2021/ERFNet/releases/download/erfnet/val.txt'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/erfnet_data'.format(OMZdatasetPath=OMZdatasetPath))
            # p7zip-rar must be installed
            os.system('mkdir {OMZdatasetPath}/erfnet_data && mv {OMZdatasetPath}/val.txt {OMZdatasetPath}/erfnet_data && mv {OMZdatasetPath}/erfnet_meta_zxw.json {OMZdatasetPath}/erfnet_data && \
            7z x {OMZdatasetPath}/JPEGImages.rar -o"{OMZdatasetPath}/erfnet_data" && \
            7z x {OMZdatasetPath}/Annotations.rar -o"{OMZdatasetPath}/erfnet_data"'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/Annotations.rar & rm -r {OMZdatasetPath}/JPEGImages.rar'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 7:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/salObj.zip -L https://cbs.ic.gatech.edu/salobj/download/salObj.zip --insecure -H "Content-Type:application/x-zip-compressed"'.format(OMZdatasetPath=OMZdatasetPath))
            # Very slow, and might block by anti-virus
            os.system('rm -r {OMZdatasetPath}/PASCAL-S'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('mkdir {OMZdatasetPath}/PASCAL-S && unzip {OMZdatasetPath}/salObj.zip -d {OMZdatasetPath}/PASCAL-S && mv {OMZdatasetPath}/PASCAL-S/datasets/imgs/pascal {OMZdatasetPath}/PASCAL-S/image && mv {OMZdatasetPath}/PASCAL-S/datasets/masks/pascal {OMZdatasetPath}/PASCAL-S/mask'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/salObj.zip & rm -r {OMZdatasetPath}/PASCAL-S/algmaps & rm -r {OMZdatasetPath}/PASCAL-S/benchmark & rm -r {OMZdatasetPath}/PASCAL-S/code & rm -r {OMZdatasetPath}/PASCAL-S/datasets & rm -r {OMZdatasetPath}/PASCAL-S/results & rm -r {OMZdatasetPath}/PASCAL-S/tips_for_matlab.txt'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 8:
            # Server is slow
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/conll2003.zip -L https://data.deepai.org/conll2003.zip'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('mkdir {OMZdatasetPath}/CONLL-2003 && 7z x {OMZdatasetPath}/conll2003.zip -o"{OMZdatasetPath}/CONLL-2003"'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/conll2003.zip'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 9:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/mrlEyes_2018_01.zip -L http://mrl.cs.vsb.cz/data/eyedataset/mrlEyes_2018_01.zip'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('7z x {OMZdatasetPath}/mrlEyes_2018_01.zip -o"{OMZdatasetPath}"'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/mrlEyes_2018_01.zip'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 10:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            os.system('curl -o {OMZdatasetPath}/lfw.tgz -L http://vis-www.cs.umass.edu/lfw/lfw.tgz'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('curl -o {OMZdatasetPath}/pairs.txt -L http://vis-www.cs.umass.edu/lfw/pairs.txt'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('curl -o {OMZdatasetPath}/lfw_landmark.txt -L https://raw.githubusercontent.com/clcarwin/sphereface_pytorch/master/data/lfw_landmark.txt'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('mkdir {OMZdatasetPath}/LFW && tar -xf {OMZdatasetPath}/lfw.tgz --directory {OMZdatasetPath}/LFW'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('mkdir {OMZdatasetPath}/LFW/annotation && mv {OMZdatasetPath}/pairs.txt {OMZdatasetPath}/LFW/annotation && mv {OMZdatasetPath}/lfw_landmark.txt {OMZdatasetPath}/LFW/annotation '.format(OMZdatasetPath=OMZdatasetPath))
            os.system('rm -r {OMZdatasetPath}/lfw.tgz'.format(OMZdatasetPath=OMZdatasetPath))
        elif result == 11:
            logging.debug('Downloading {} Dataset'.format(datasetDownloaderList[result]))
            # It might timeout...
            os.system('curl -o {OMZdatasetPath}/nyudepthv2.tar.gz -L http://datasets.lids.mit.edu/fastdepth/data/nyudepthv2.tar.gz'.format(OMZdatasetPath=OMZdatasetPath))
            os.system('tar -xf {OMZdatasetPath}/nyudepthv2.tar.gz --directory {OMZdatasetPath}'.format(OMZdatasetPath=OMZdatasetPath))
        else:
            logging.error('ERROR in datasetDownloader!')
            

def main(arg):
    if arg == 'modelDownloader':
        mode = ''
        name = ''
        try:
            mode = sys.argv[2]
            name = sys.argv[3]
        except IndexError:
            mode = 'common'
            name = ''
        modelDownloader(mode,name)
    elif arg == 'modelConverter':
        mode = ''
        name = ''
        try:
            mode = sys.argv[2]
            name = sys.argv[3]
        except IndexError:
            mode = 'common'
            name = ''
        modelConverter(mode,name)
    elif arg == 'datasetDownloader':
        mode = ''
        name = ''
        try:
            mode = sys.argv[2]
            name = sys.argv[3]
        except IndexError:
            mode = 'common'
            name = ''
        datasetDownloader(mode,name)
    elif arg == 'common':
        banner('Open Model Zoo Model Tools')
        featureList = ['Open Model Zoo Model Downloader','Open Model Zoo Public Model Converter','Open Model Zoo Public Model Quantizer','Open Model Zoo Models Dataset Downloader']
        featureIndex = itemSelection('Select a tool you want to run. (Input a number or the name of the tool.)',featureList)
        if featureIndex == 0:
            modelDownloader('common')
        elif featureIndex == 1:
            modelConverter('common')
        elif featureIndex == 2:
            modelQuantizer('common')
        elif featureIndex == 3:
            datasetDownloader('common')
        else:
            logging.error('Something wrong during selection.Please raise a issue in GitHub, Thank you. DEBUG_MESSAGE:{}'.format('featureIndex='+ str(featureIndex)))
    else:
        return

try:
    arg = sys.argv[1]
except IndexError:
    arg = ''
main(arg)