import os
import logging
import json

kit_info=os.path.abspath(os.getcwd()) + '/Source/demo_kit.json'
OSName=os.popen('cat /etc/os-release | grep "PRETTY_NAME"').read().split('"')[1]
openvinoInstalled=os.popen('ls -l /opt/intel/openvino_2022 | grep "openvino" | cut -d">" -f 2 |cut -d"/" -f 4').read()
AuthorName= 'SYNNEX Technology International Corp.'
AppName=    'Intel OpenVINO Demostration Kit'
openvinoPath=''
demokitVersion= ''
openvinoVersion= ''
with open(kit_info,'r') as DemoKitinfo:
    DemoKitJSON = json.load(DemoKitinfo)
    demokitVersion = DemoKitJSON['demokitVersion']
    openvinoVersion= DemoKitJSON['openvinoVersion']
    openvinoPath= DemoKitJSON['openvinoPath']
    if not DemoKitJSON['sample']['path'] == '$HOME':
        samplePath = DemoKitJSON['sample']['path']
def banner(title,gap=4,updown_border_text='=',side_border_text='|'):
	updown_border = side_border_text
	side_border = side_border_text
	for x in range(len(title) + gap*2):
		updown_border += '='
	updown_border += side_border_text
	for x in range(gap):
		side_border += ' '
	side_border += title
	for x in range(gap):
		side_border += ' '
	side_border += side_border_text
	print(updown_border)
	print(side_border)
	print(updown_border)
	print(side_border_text + "  Support OpenVINO " + openvinoVersion + '\n')

def opening_banner(gap=4,updown_border_text='=',side_border_text='|'):
    
    updown_border = side_border_text
    for x in range(len(AuthorName) + gap*2):
        updown_border+=updown_border_text
    updown_border+=side_border_text
    
    bannerStrings = [side_border_text,side_border_text,side_border_text]
    gap1_string = ''
    for x in range(gap):
        gap1_string += ' '
    bannerStrings[0] += gap1_string + AuthorName + gap1_string + side_border_text
    for x in range(len(AuthorName) + gap*2):
        bannerStrings[1] += ' '
    bannerStrings[1] += side_border_text
    gap2_string = ''
    for x in range(int((len(AuthorName)+gap*2-len(AppName))/2)):
        gap2_string += ' '
    bannerStrings[2] += (gap2_string + AppName + gap2_string + side_border_text) if (len(AuthorName)-len(AppName))%2 == 0 else (gap2_string + AppName + gap2_string + ' ' + side_border_text)
    
    print(updown_border)
    for bannerString in bannerStrings:
        print(bannerString)
    print(updown_border)
    print(side_border_text + ' Ver. ' + demokitVersion + ' | Support OpenVINO ' + openvinoVersion)
    if openvinoInstalled != '':
        print(side_border_text + " You've installed " + openvinoInstalled + '| on ' + OSName)
    else:
        logging.warning('OpenVINO not detected! Please Install OpenVINO First!')
    print('\n'*1)