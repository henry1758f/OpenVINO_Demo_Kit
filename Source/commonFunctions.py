import os
import json
import logging
from pathlib import Path

logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'

def yesnoSelection(question):
    selection = input(question + ' >> ')
    if selection == 'Y' or selection == 'y' or selection == 'yes' or selection == 'YES' or selection == 'Yes':
        return True
    else:
        return False

def itemSelection(question,items):
    counter=0
    for item in items:
        counter +=1
        print('\t' + str(counter) + '.\t' + item)
    selection = input(question + ' >> ')
    try:
        if selection.isnumeric():
            return int(selection)-1
        else:
            counter = 0
            for item in items:
                if selection == items[counter]:
                    return counter
                counter+=1
            else:
                raise
    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)
        return -1

def modelStageExtractor(model_info_JSON):
    modelList=[]
    if len(model_info_JSON['model_stages'])>0:
        for model_info in model_info_JSON['model_stages']:
            modelStageExtractorListModels = modelStageExtractor(model_info)
            for modelStageExtractorListModel in modelStageExtractorListModels:
                modelList.append(modelStageExtractorListModel)
    else:
        modelList.append(model_info_JSON)
    return modelList

def modelSelection(question,modelsJSON,printDetail=False,printAvailablePrecision=False):
    model_index=0
    for model in modelsJSON:
        model_index +=1
        detail = ''
        precisions = ''
        if printDetail:
            detail=' ({})'.format(model['description'])
        if printAvailablePrecision:
            precisions = '\t'
            modelPath = getSettingValue(['OMZmodelPath'])
            if model['framework'] == 'dldt':
                modelPath+= '/' + model['subdirectory']
            else:
                modelPath+= '/ir/' + model['subdirectory']
            for precision in model['precisions']:
                #logging.debug('Checking Existion -> Path:{modelPath}/{precision}/{name}.xml'.format(modelPath=modelPath,precision=precision,name=model['name']))
                if os.path.isfile('{modelPath}/{precision}/{name}.xml'.format(modelPath=modelPath,precision=precision,name=model['name'])):
                    precisions+= '[{}]'.format(precision)
            for precision in model['quantization_output_precisions']:
                #logging.debug('Checking Existion -> Path:{modelPath}/{precision}/{name}.xml'.format(modelPath=modelPath,precision=precision,name=model['name']))
                if os.path.isfile('{modelPath}/{precision}/{name}.xml'.format(modelPath=modelPath,precision=precision,name=model['name'])):
                    precisions+= '[{}]'.format(precision)
        print('\t{index}. {name} {precisions} {detail}'.format(index=model_index, name=model['name'], precisions=precisions, detail=detail))
    try:
        selection = input('\n >>> {}\n > '.format(question))
        if selection.isnumeric():
            if int(selection) > len(modelsJSON):
                raise
            return int(selection)-1
        else:
            model_index = 0
            for model in modelsJSON:
                if model['name'] == selection:
                    return model_index
                model_index+=1
            else:
                raise
    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)
        return -1

def setSettingValue(keyStrList,value):
    DemoKitJSON = ''
    with open(kit_info,'r') as DemoKitinfo:
        DemoKitJSON = json.load(DemoKitinfo)
    DemoKitJSON = setSettingValueinJSON(DemoKitJSON,keyStrList,value)
    with open(kit_info, 'w', encoding='utf-8') as DemoKitinfoWrite:
        json.dump(DemoKitJSON, DemoKitinfoWrite, ensure_ascii=False, indent=4)
    
def setSettingValueinJSON(json,keyStrList,value):
    #logging.debug('KEY:{},Value:{},len of Key:{}'.format(keyStrList,value,len(keyStrList)))
    if len(keyStrList)>1:
        keyStr=keyStrList.pop(0)
        json[keyStr] = setSettingValueinJSON(json[keyStr],keyStrList,value)
    elif len(keyStrList)==1:
        keyStr=keyStrList.pop(0)
        json[keyStr] = value
        #logging.debug('Will return :{}'.format(json))
        return json
    else:
        logging.error('setSettingValueinJSON ERROR.')
    return json

def getSettingValue(keyStrList):
    DemoKitJSON = ''
    with open(kit_info,'r') as DemoKitinfo:
        DemoKitJSON = json.load(DemoKitinfo)
        return getSettingValueinJSON(DemoKitJSON,keyStrList)

def getSettingValueinJSON(json,keyStrList):
    if len(keyStrList)>1:
        keyStr=keyStrList.pop(0)
        return getSettingValueinJSON(json[keyStr],keyStrList)
    elif len(keyStrList)==1:
        keyStr=keyStrList.pop(0)
        return json[keyStr]
    else:
        logging.error('readvalueinJSON ERROR.{}'.format(keyStrList))