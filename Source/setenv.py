import os
import json
import logging
from pathlib import Path
from banner import opening_banner,banner
from commonFunctions import getSettingValue


def settingsPrint():
    logging.info('Loading Settings...')
    settings = []
    # Reading Settings
    settings.append(['OpenVINO Install Path',getSettingValue(['openvinoPath'])])
    settings.append(['Python Excution',getSettingValue(['pythonExcute'])])
    settings.append(['Open Model Zoo(OMZ) Download Source',getSettingValue(['OMZ','git'])])
    settings.append(['Open Model Zoo(OMZ) Download Version',getSettingValue(['OMZ','tag'])])
    settings.append(['OMZ Models Download Path',getSettingValue(['OMZmodelPath'])])
    settings.append(['OMZ Models converted IR Path',getSettingValue(['OMZconvertPath'])])
    settings.append(['OMZ Models Dataset Download Path',getSettingValue(['OMZdatasetPath'])])

    settings.append(['Open Model Zoo repo download path',getSettingValue(['OMZ','path'])])

    settings.append(['OpenCV Download Source',getSettingValue(['opencvGit'])])
    settings.append(['OpenCV Download path',getSettingValue(['opencvPath'])])
    settings.append(['OpenCV Download Version',getSettingValue(['opencvVersion'])])
    settings.append(['OpenCV build path',getSettingValue(['opencvBuild'])])

    settings.append(['OpenVINO samples build path',getSettingValue(['sample','path'])])

    settings.append(['Benchmark Report path',getSettingValue(['benchmark','reportPath'])])
    settings.append(['Benchmark path',getSettingValue(['benchmark','path'])])
    settings.append(['Benchmark python',str(getSettingValue(['benchmark','python']))])
    settings.append(['Benchmark Report File Generate',str(getSettingValue(['benchmark','report']))])
    #settings.append(['Benchmark Banned models',str(getSettingValue(['benchmark','modelBan']))])
    settings.append(['Benchmark Skip models',str(getSettingValue(['benchmark','skip']))])
    count = 0
    for setting in settings:
        count +=1
        print(str(count) + '.\t' + setting[0] + ' >> [' +setting[1] + ']')

def main():
    banner('Demo Kit Settings')
    settingsPrint()

main()