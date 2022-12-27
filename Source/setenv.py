import os
import json
import logging
from pathlib import Path
from banner import opening_banner,banner
logging.basicConfig(format='[ %(levelname)s ] %(message)s', level=logging.DEBUG)

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'

banner('Demo Kit Settings')

logging.info('Loading Settings...')

settings = []

with open(kit_info,'r') as DemoKitinfo:
    DemoKitJSON = json.load(DemoKitinfo)
    # Reading Settings
    settings.append(['OpenVINO Install Path',DemoKitJSON['openvinoPath']])
    settings.append(['Python Excution',DemoKitJSON['pythonExcute']])
    settings.append(['OMZ Models Download Path',DemoKitJSON['OMZmodelPath']])
    settings.append(['OMZ Models converted IR Path',DemoKitJSON['OMZconvertPath']])
    settings.append(['OMZ Models Dataset Download Path',DemoKitJSON['OMZdatasetPath']])

    settings.append(['Open Model Zoo repo download path',DemoKitJSON['OMZ']['path']])

    settings.append(['OpenVINO samples build path',DemoKitJSON['sample']['path']])

    settings.append(['Benchmark Report path',DemoKitJSON['benchmark']['reportPath']])
    settings.append(['Benchmark path',DemoKitJSON['benchmark']['path']])
    settings.append(['Benchmark python',str(DemoKitJSON['benchmark']['python'])])
    settings.append(['Benchmark Report File Generate',str(DemoKitJSON['benchmark']['report'])])
    #settings.append(['Benchmark Banned models',str(DemoKitJSON['benchmark']['modelBan'])])
    settings.append(['Benchmark Skip models',str(DemoKitJSON['benchmark']['skip'])])

count = 0
for setting in settings:
    count +=1
    print(str(count) + '.\t' + setting[0] + ' >> [' +setting[1] + ']')

def setvalue(keyStrList,value):
    check = keyStrList
    logging.debug('keyStrList0 : {}'.format(keyStrList))
    logging.debug('check0 : {}'.format(check))
    DemoKitJSON = ''
    with open(kit_info,'r') as DemoKitinfo:
        DemoKitJSON = json.load(DemoKitinfo)
    DemoKitJSON = setvalueinJSON(DemoKitJSON,keyStrList,value)
    with open(kit_info, 'w', encoding='utf-8') as DemoKitinfoWrite:
        json.dump(DemoKitJSON, DemoKitinfoWrite, ensure_ascii=False, indent=4)
    
def setvalueinJSON(json,keyStrList,value):
    if len(keyStrList)>1:
        keyStr=keyStrList.pop(0)
        json[keyStr] = setvalueinJSON(json[keyStr],keyStrList,value)
    elif len(keyStrList)==1:
        keyStr=keyStrList.pop(0)
        json[keyStr] = value
        return json
    else:
        logging.error('setvalueinJSON ERROR.')

def getvalue(keyStrList):
    DemoKitJSON = ''
    logging.debug('keyStrList1 : {}'.format(keyStrList))
    with open(kit_info,'r') as DemoKitinfo:
        DemoKitJSON = json.load(DemoKitinfo)
        return getvalueinJSON(DemoKitJSON,keyStrList)

def getvalueinJSON(json,keyStrList):
    if len(keyStrList)>1:
        keyStr=keyStrList.pop(0)
        return getvalueinJSON(json[keyStr],keyStrList)
    elif len(keyStrList)==1:
        keyStr=keyStrList.pop(0)
        logging.debug('KeyStr : {}'.format(keyStr))
        return json[keyStr]
    else:
        logging.error('readvalueinJSON ERROR.{}'.format(keyStrList))