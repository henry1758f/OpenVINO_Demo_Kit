# File: omz_demos.py

import os
import logging
import json

from pathlib import Path

from banner import banner

logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'
OMZ_path_parent=str(Path.home())
OMZPath=''
modelPath= str(Path.home()) + '/open_model_zoo_models'
convertPath = str(Path.home()) + '/open_model_zoo_models/convert'
python_execute='/usr/bin/python3'
demos=''
openvinoVersion=''
with open(kit_info,'r') as DemoKitinfo:
    DemoKitJSON = json.load(DemoKitinfo)
    if not DemoKitJSON['OMZ']['path'] == '$HOME':
        OMZ_path_parent= DemoKitJSON['OMZ']['path']
    if not DemoKitJSON['modelPath'] == '$HOME':
        modelPath = DemoKitJSON['modelPath']
        if not Path(modelPath).is_dir():
            logging.debug('Default Model Directory not found. ({} not found.)'.format(modelPath))
    if not DemoKitJSON['convertPath'] == 'modelPath':
        convertPath = DemoKitJSON['convertPath']
    else:
        if not Path(convertPath).is_dir():
            logging.debug('ConvertPath not found, create new in {}'.format(convertPath))
            os.system('mkdir {}'.format(convertPath))
    demos = DemoKitJSON['demos']
    openvinoVersion= DemoKitJSON['openvinoVersion']
OMZPath= OMZ_path_parent + '/' + 'open_model_zoo-' + DemoKitJSON['OMZ']['tag']

def demo_Select():
    banner('Open Model Zoo - Demos')
    print('Available demos >>>')
    count=0
    for demo in demos:
        count+=1
        print('\t{number}.\t{name}'.format(number=count, name=demo['name']))
    selection = input(' > Please select a number of  the demo that you want >>>')
    try:
        if selection.isnumeric():
            return demos[int(selection)-1]
        else:
            for demo in demos:
                if selection == demo['name']:
                    return demo
            else:
                raise
    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)

def model_precision_selection(modelJSON):
    path=''
    if modelJSON['framework'] != 'dldt':
        path = convertPath + '/' + modelJSON['subdirectory']
    else:
        path = modelPath + '/' + modelJSON['subdirectory']
    available_precision_list=[]
    for precision in modelJSON['precisions']:
        logging.debug('checking {}'.format(path + '/' + precision + '/' + modelJSON['name'] + '.xml'))
        if os.path.isfile(path + '/' + precision + '/' + modelJSON['name'] + '.xml'):
            available_precision_list.append(precision)
    for precision in modelJSON['quantization_output_precisions']:
        logging.debug('checking {}'.format(path + '/' + precision + '/' + modelJSON['name'] + '.xml'))
        if os.path.isfile(path + '/' + precision + '/' + modelJSON['name'] + '.xml'):
            available_precision_list.append(precision)
    item_index=0
    if len(available_precision_list) <= 0:
        logging.error('Cannot Find any model!')
    else:
        print(' [ Available Precision List ]')
    for item in available_precision_list:
        item_index+=1
        print('\t{}.\t{}'.format(item_index,item))
    selection = input(' > Input the index number or the precision of the {} model >>>>'.format(modelJSON['name']))
    try:
        if selection.isnumeric():
            return available_precision_list[int(selection)-1]
        else:
            for available_precision in available_precision_list:
                if selection == available_precision:
                    return available_precision
            else:
                raise
    except Exception as e:
        logging.error('Your Input is invaild! Please check your input or path and try again! ')
        logging.error(e)

def OMZmodel_path_get(modelInfoJSON,precision):
    xmlpath = '/' + modelInfoJSON['subdirectory'] + '/' + precision + '/' + modelInfoJSON['name'] + '.xml'
    if modelInfoJSON['framework'] != 'dldt':
        xmlpath = convertPath + xmlpath
    else:
        xmlpath = modelPath + xmlpath
    if os.path.isfile(xmlpath):
        return xmlpath
    else:
        logging.error('File "{}" Not found!'.format(xmlpath))
        logging.debug('TODO: Download "{}" model'.format(modelInfoJSON['name']))
        exit()

def model_device_selection(modelJSON):
    selection = input('> Input the device you want to run [{}] inference. (CPU,GPU,AUTO,MULTI,HETERO,etc.)'.format(modelJSON['name']))
    if selection != '':
        return modelJSON['device_argument'] + ' ' + selection
    else:
        return modelJSON['device_argument'] + ' ' + modelJSON['default_device']

def model_quick_demo(model,models_info_JSON):
    for model_info in models_info_JSON:
        if model_info['name'] == model['default']:
            logging.debug('Use default setting "{}" {}'.format(model['default'],model['default_device']))
            return ' ' + model['argument'] + ' ' + OMZmodel_path_get(model_info,model['default_precisions'])  + ' '+ model['device_argument'] + ' ' + model['default_device'] + ' '
            break
    else:
        logging.error('The default model setting is invailed: [{name}][{precision}]->{dev}'.format(name=model['default'],precision=model['default_precisions'],dev=model['default_device']))

def model_selection(modelJSON):
    args = ''
    quickdemo = False
    models_info_JSON = json.loads(os.popen('{python} {omzPath}/tools/model_tools/info_dumper.py --all'.format(python=python_execute, omzPath=OMZPath)).read())
    for model in modelJSON:
        required = ''
        if model['required']:
            required = ' [required] '
        print('\n\n > Select a/an {} {} >>> '.format(model['name'],required))
        available_model_list = []
        for model_info in models_info_JSON:
            model_stages=model_info['model_stages']
            if model_stages:
                for model_stage in model_stages:
                    for available_model in model['items']:
                        if available_model in model_stage['name']:
                            for ban in model['ban']:
                                if ban in model_stage['name']:
                                    break
                            else:
                                available_model_list.append(model_stage)
            else:
                for available_model in model['items']:
                    if available_model in model_info['name']:
                        for ban in model['ban']:
                            if ban in model_stage['name']:
                                break
                        else:
                            available_model_list.append(model_info)
        item_index=0
        for item in available_model_list:
            item_index+=1
            print('\t{}.\t{}'.format(item_index,item['name']))
        if quickdemo:
            logging.warning('Quick Demo is enabled! Will used default setting....')
            args += model_quick_demo(model,models_info_JSON)
            continue
        selection = input(' > Input the index number or the name of the model >>>>')
        return_args = ''
        selection_modelJSON = ''
        precision=''
        device=''
        if selection == '' and model['required']:
            quickdemo = True
        if quickdemo:
            args += model_quick_demo(model,models_info_JSON)
            continue
        try:
            if selection.isnumeric():
                logging.debug(available_model_list[int(selection)-1])
                selection_modelJSON = available_model_list[int(selection)-1]
                precision = model_precision_selection(selection_modelJSON)
            else:
                for available_model in available_model_list:
                    if selection == available_model['name']:
                        selection_modelJSON = available_model
                        precision = model_precision_selection(selection_modelJSON)
                else:
                    if selection == '' and  bool(model['required']):
                        for model_info in models_info_JSON:
                            if model_info['name'] == model['default']:
                                selection_modelJSON = model_info
                                precision = model_info['default_precisions']
                                break
                        else:
                            raise Exception('The default model "{}" is not found in model zoo!'.format(model['default']))
                    elif os.path.isfile(selection):
                        logging.debug('{} is a file!'.format(selection))
                        return_args = ' ' + model['argument'] + ' ' + selection
                    raise
            if selection_modelJSON != '':
                if precision != '':
                    return_args = ' ' + model['argument'] + ' ' + OMZmodel_path_get(selection_modelJSON,precision)
                else:
                    return_args = ' ' + model['argument'] + ' ' + OMZmodel_path_get(selection_modelJSON,model['default_precisions'])
            if model['device_argument'] != '':
                    device = model_device_selection(model)
            return_args += ' ' + device + ' '
        except Exception as e:
            logging.error('Your Input is invaild! Please check your input or path and try again! ')
            logging.error(e)
        args += return_args
    return args

def input_selection(inputJSON):
    selection = input('> Input the {}. >> '.format(inputJSON['hint']))
    if os.path.isfile(selection) | os.path.isdir(selection) | os.path.islink(selection):
        return inputJSON['argument'] + ' ' + selection
    elif selection == '':
        if str(inputJSON['default']).isnumeric():
            logging.debug('Use default input "Camera {}"'.format(inputJSON['default']))
            return inputJSON['argument'] + ' ' + inputJSON['default']
        else:
            logging.debug('Use default input "{}"'.format(os.path.abspath(os.getcwd()) + inputJSON['default']))
            if not os.path.isfile(os.path.abspath(os.getcwd()) + inputJSON['default']):
                logging.debug('Cannot find default input file!')
                os.system('curl -o {path} {source}'.format(path=os.path.abspath(os.getcwd()) + inputJSON['default'],source=inputJSON['source']))
                if os.path.isfile(os.path.abspath(os.getcwd()) + inputJSON['default']): 
                    return inputJSON['argument'] + ' ' + os.path.abspath(os.getcwd()) + inputJSON['default']
                else:
                    logging.error('Failed to Download Input Source from {} , Please check the internet connection.'.format(inputJSON['source']))
                    logging.warning('Tried to used camera 0 as input...')
                    return inputJSON['argument'] + ' ' + '0 '
            return inputJSON['argument'] + ' ' + os.path.abspath(os.getcwd()) + inputJSON['default']
    elif selection.isnumeric():
        return inputJSON['argument'] + ' ' + selection
    else:
        logging.error('Failed to find file or folder "{}". Please check your input and try again!'.format(selection))
    return input_selection(inputJSON)

def label_selection(labelsJSON,execute_args):
    if modelPath in execute_args: #Maybe using one of the model in Open Model Zoo
        default=''
        item_List=[]
        for item in labelsJSON['items']:
            for model in item['models']:
                if model == '*':
                    default = item
                modelString='/'+model+'.xml'
                if modelString in execute_args:
                    return ' ' + labelsJSON['argument'] + ' ' + OMZPath + item['path'] + item['name'] 
        else:
            if default:
                return ' ' + labelsJSON['argument'] + ' ' + OMZPath + default['path'] + default['name'] 
    required=''
    if labelsJSON['required']:
        required='[Required]'
    logging.debug(labelsJSON)
    print('\n\n > {title} {required} >>> '.format(title=labelsJSON['title'],required=required))
    index = 0
    labels = []
    for item in labelsJSON['items']:
        index +=1
        print('\t{index}. {name}'.format(index=index,name=item['name']))
        labels.append(item)
    selection = input('> ' + labelsJSON['hint'] + '>')
    try:
        if selection.isnumeric():
            return ' ' + labelsJSON['argument'] + ' ' + OMZPath + labels[int(selection)-1]['path'] + labels[int(selection)-1]['name']
        elif os.path.isfile(selection):
            return ' ' + labelsJSON['argument'] + ' ' + selection
        else:
            if labelsJSON['required']:
                logging.error('Failed to find label file "{}". Please check your input and try again!'.format(selection))
                label_selection(labelsJSON,execute_args)
            else:
                logging.warning('SKIP the label setting')
                return ''
    except Exception as e:
        logging.error('Failed to find label file "{}". Please check your input and try again!'.format(selection))
        logging.error(e)

def type_selection(typeJSON,execute_args):
    if modelPath in execute_args: #Maybe using one of the model in Open Model Zoo
        default=''
        item_List=[]
        for item in typeJSON['items']:
            for model in item['models']:
                if model == '*':
                    default = item
                modelString='/'+model+'.xml'
                logging.debug(modelString)
                if modelString in execute_args:
                    return ' ' + typeJSON['argument'] + ' ' + item['name'] 
        else:
            if default:
                return ' ' + typeJSON['argument'] + ' ' + default['name'] 
    required=''
    if typeJSON['required']:
        required='[Required]'
    print('\n\n > {title} {required} >>> '.format(title=typeJSON['title'],required=required))
    index = 0
    items = []
    for item in typeJSON['items']:
        index +=1
        print('\t{index}. {name}'.format(index=index,name=item['name']))
        items.append(item)
    selection = input('> ' + typeJSON['hint'] + '>')
    try:
        if selection.isnumeric():
            return ' ' + typeJSON['argument'] + ' ' + items[int(selection)-1]['name']
        elif selection in items:
            return ' ' + typeJSON['argument'] + ' ' + selection
        else:
            logging.debug(typeJSON['required'])
            if typeJSON['required']:
                logging.error('"{}". Please check your input and try again!'.format(typeJSON['hint']))
                label_selection(typeJSON,execute_args)
            else:
                logging.warning('SKIP the {} setting'.format(typeJSON['name']))
                return ''
    except Exception as e:
        logging.error('Invailed Input! Please check your input and try again!'.format(selection))
        logging.error(e)

def run_demo(demoJSON):
    banner(demoJSON['name'])
    print(' > {}\n\n'.format(demoJSON['description']))
    execute_args=''
    for setting in demoJSON['setting']:
        if setting['name'] == 'model':
            execute_args += model_selection(setting['items'])
            logging.debug(execute_args)
        elif setting['name'] == 'input':
            execute_args += input_selection(setting)
            logging.debug(execute_args)
        elif setting['name'] == 'labels':
            execute_args += label_selection(setting,execute_args)
        elif setting['name'] == 'architecture type':
            execute_args += type_selection(setting,execute_args)
        else:
            hint = ''
            skipHint=''
            if setting['required']:
                hint += '[Required]'
            else:
                skipHint= ' [Press ENTER to skip this setting.]'
            hint += '> ' + setting['hint'] + ' >>'
            selection = input('\n\n' + hint + skipHint + '\n >> ')
            if selection == '':
                if setting['required']:
                    execute_args += ' ' + setting['argument'] + ' ' + setting['default']
                else:
                    logging.debug('Skip {} Setting.'.format(setting['name']))
                    continue
            else:
                execute_args += ' ' + setting['argument'] + ' ' + selection
    path = str(demoJSON['path']).replace('~',str(Path.home())) + '/'
    if '.py' in demoJSON['appName']:
        execute_args = demoJSON['preprocess'] + python_execute + ' ' + path + demoJSON['appName'] + ' ' + execute_args
    else:
        execute_args = demoJSON['preprocess'] + path + demoJSON['appName'] + ' ' + execute_args
    logging.debug(execute_args)
    os.system(execute_args)

def main():
    run_demo(demo_Select())

main()

