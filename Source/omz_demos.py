import os
import sys
import json
import logging
from pathlib import Path
from banner import opening_banner
from commonFunctions import setSettingValue,getSettingValue,yesnoSelection

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
    # If OMZ path not set
    if omzPath == '': 
        # Write Default OMZ path to JSON
        logging.debug('Open Model Zoo Path is not set, will use "' + str(Path.home()) + '" as default.')
        defaultOMZpath = str(Path.home()) + '/open_model_zoo_' + omzTag
        defaultOMZbuild = defaultOMZpath+'_build'
        logging.debug('Setting ' + defaultOMZpath + ' As Open Model Zoo Download Path.')
        setSettingValue(['OMZ','path'],defaultOMZpath)
        setSettingValue(['OMZ','build'],defaultOMZbuild)
        # TODO: Check if the value been written.
    # If there's no OMZ repo, start clone from github
    omzPath = getSettingValue(['OMZ','path'])
    if not os.path.isdir(omzPath):
        os.system('git clone --recurse-submodules --branch ' + omzTag + ' --depth 1 ' + omzGit + ' ' + omzPath)
    # If there's still no OMZ repo, raise error and exit, otherwise start build OMZ demos
    if not os.path.isdir(omzPath) and not os.path.isdir(omzPath+'/demos'):
        logging.error('Cannot clone Open Model Zoo repo from GitHub to {dir}.Please check if you have access right or the Internet connection'.format(dir=omzPath))
        return -1
    else: # If OMZ repo and demos exist.
        logging.debug('Open Model Zoo dir detect, will start build demos')
        omzBuild = getSettingValue(['OMZ','build'])
        if omzBuild == '': # If build path not set, set build path
            omzBuild = omzPath+'_build'
            logging.debug('Build Path is not set, will use {buildPath} as default'.format(omzBuild))
            setSettingValue(['OMZ','build'],omzBuild)
    # If OpenCV path is not set or not found the openCV dir, Download and build OpenCV.
    opencvPath = getSettingValue(['opencvPath'])
    opencvVersion = getSettingValue(['opencvVersion'])
    opencvGit = getSettingValue(['opencvGit'])
    opencvBuild = getSettingValue(['opencvBuild'])
    installOpenCV = False
    if not os.path.isdir(opencvBuild):
        logging.warning('OpenCV Build path is not set, or the path {opencvBuild} not found.'.format(opencvBuild=opencvBuild))
        opencvPath = str(Path.home()) + '/opencv'
        installOpenCV = yesnoSelection('Do you want to Download, Build and install OpenCV {version} in {path}'.format(version=opencvVersion,path=opencvPath))
        if not installOpenCV:
            logging.error('Open Model Zoo demos build need OpenCV, please set the OpenCV path or install manually.')
            return -1
        else:
            setSettingValue(['opencvPath'],opencvPath)
    # install prerequest and start building
    logging.debug('Start install prerequest and build OMZ demos')
    os.system(openvino_envsetup)
    # Install Python requirements
    logging.debug('Step1. Install python requirements.')
    os.system('python3 -m pip install --upgrade pip')
    os.system(python_execute +' -mpip install -r ' + omzPath + '/demos/requirements.txt')
    # Download and build OpenCV 
    if installOpenCV:
        # Refer to https://github.com/opencv/opencv/wiki/BuildOpenCV4OpenVINO#building-on-ubuntu
        logging.debug('Step2. Install OpenCV')
        logging.debug('Step2-1. Download OpenCV')
        os.system('git clone --recurse-submodules --branch {tag} --depth 1 {git} {path}'.format(tag=opencvVersion,git=opencvGit,path=opencvPath))
        if not os.path.isdir(opencvPath):
            logging.error('Cannot clone OpenCV repo from GitHub to {dir}.Please check if you have access right or the Internet connection'.format(dir=opencvPath))
            return -1
        logging.debug('Step2-2. Install Prerequisites')
        opencvPrerequisites = 'sudo apt-get install build-essential cmake ninja-build libgtk-3-dev libpng-dev libjpeg-dev libwebp-dev libtiff5-dev libopenexr-dev libopenblas-dev libx11-dev libavutil-dev libavcodec-dev libavformat-dev libswscale-dev libavresample-dev libtbb2 libssl-dev libva-dev libmfx-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev'
        os.system(opencvPrerequisites)
        logging.debug('Step3. Build OpenCV')
        logging.debug('Step3-1. Make/set OpenCV Build Directory')
        if opencvBuild == '':
            opencvBuild = str(Path.home()) + '/build-opencv/install'
            logging.debug('Will set {} as default OpenCV Build path'.format(str(os.path.dirname(opencvBuild))))
            setSettingValue(['opencvBuild'],opencvBuild)
            os.system('mkdir {}'.format(str(os.path.dirname(opencvBuild))))
        else:
            if not os.path.isdir(opencvBuild):
                os.system('mkdir {}'.format(str(os.path.dirname(opencvBuild))))
        if not os.path.isdir(str(os.path.dirname(opencvBuild))):
            logging.error('Failed to create OpenCV Build Path, Please make sure you have access right or "opencvBuild" is set to an exist directory.')
            return -1
        opencvCompile = 'cmake -G Ninja -D BUILD_INFO_SKIP_EXTRA_MODULES=ON -D BUILD_EXAMPLES=OFF -D BUILD_JASPER=OFF -D BUILD_JAVA=OFF -D BUILD_JPEG=ON -D BUILD_APPS_LIST=version -D BUILD_opencv_apps=ON -D BUILD_opencv_java=OFF -D BUILD_OPENEXR=OFF -D BUILD_PNG=ON -D BUILD_TBB=OFF -D BUILD_WEBP=OFF -D BUILD_ZLIB=ON -D WITH_1394=OFF -D WITH_CUDA=OFF -D WITH_EIGEN=OFF -D WITH_GPHOTO2=OFF -D WITH_GSTREAMER=ON -D OPENCV_GAPI_GSTREAMER=OFF -D WITH_GTK_2_X=OFF -D WITH_IPP=ON -D WITH_JASPER=OFF -D WITH_LAPACK=OFF -D WITH_MATLAB=OFF -D WITH_MFX=ON -D WITH_OPENCLAMDBLAS=OFF -D WITH_OPENCLAMDFFT=OFF -D WITH_OPENEXR=OFF -D WITH_OPENJPEG=OFF -D WITH_QUIRC=OFF -D WITH_TBB=OFF -D WITH_TIFF=OFF -D WITH_VTK=OFF -D WITH_WEBP=OFF -D CMAKE_USE_RELATIVE_PATHS=ON -D CMAKE_SKIP_INSTALL_RPATH=ON -D ENABLE_BUILD_HARDENING=ON -D ENABLE_CONFIG_VERIFICATION=ON -D ENABLE_PRECOMPILED_HEADERS=OFF -D ENABLE_CXX11=ON -D INSTALL_PDB=ON -D INSTALL_TESTS=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D CMAKE_INSTALL_PREFIX=install -D OPENCV_SKIP_PKGCONFIG_GENERATION=ON -D OPENCV_SKIP_PYTHON_LOADER=OFF -D OPENCV_SKIP_CMAKE_ROOT_CONFIG=ON -D OPENCV_GENERATE_SETUPVARS=OFF -D OPENCV_BIN_INSTALL_PATH=bin -D OPENCV_INCLUDE_INSTALL_PATH=include -D OPENCV_LIB_INSTALL_PATH=lib -D OPENCV_CONFIG_INSTALL_PATH=cmake -D OPENCV_3P_LIB_INSTALL_PATH=3rdparty -D OPENCV_SAMPLES_SRC_INSTALL_PATH=samples -D OPENCV_DOC_INSTALL_PATH=doc -D OPENCV_OTHER_INSTALL_PATH=etc -D OPENCV_LICENSES_INSTALL_PATH=etc/licenses -D OPENCV_INSTALL_FFMPEG_DOWNLOAD_SCRIPT=ON -D BUILD_opencv_world=OFF -D BUILD_opencv_python2=OFF -D BUILD_opencv_python3=ON -D PYTHON3_PACKAGES_PATH=install/python/python3 -D PYTHON3_LIMITED_API=ON -D HIGHGUI_PLUGIN_LIST=all -D OPENCV_PYTHON_INSTALL_PATH=python -D CPU_BASELINE=SSE4_2 -D OPENCV_IPP_GAUSSIAN_BLUR=ON -D WITH_OPENVINO=ON -D VIDEOIO_PLUGIN_LIST=ffmpeg,gstreamer,mfx -D CMAKE_EXE_LINKER_FLAGS=-Wl,--allow-shlib-undefined -D CMAKE_BUILD_TYPE=Release ' + opencvPath
        opencvBuildCommand = 'ninja && cmake --install .'
        logging.debug('Step3-2. OpenCV Compile')
        os.system('cd {buildDir} && {opencvCompile}'.format(buildDir=str(os.path.dirname(opencvBuild)),opencvCompile=opencvCompile))
        logging.debug('Step3-3 OpenCV Install')
        os.system('cd {buildDir} && {opencvBuildCommand}'.format(buildDir=str(os.path.dirname(opencvBuild)),opencvBuildCommand=opencvBuildCommand))
    else:
        logging.debug('Step2 ~ 3. [SKIP] Download and Install OpenCV')
    logging.debug('Step4. OpenCV Environment Setting')
    openCVDirSet = 'export OpenCV_DIR="{}/cmake"'.format(opencvBuild)
    LDPathSet = 'export LD_LIBRARY_PATH="{}/lib${{LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}}"'.format(opencvBuild)
    pythonSet = 'export PYTHONPATH="{}/python${{PYTHONPATH:+:$PYTHONPATH}}"'.format(opencvBuild)
    # os.system(openCVDirSet + ' && ' + LDPathSet + ' && ' + pythonSet)
    # Build Demos
    # TODO: DENABLE_PYTHON=y build pass
    #buildStr = openCVDirSet + ' && ' + LDPathSet + ' && ' + pythonSet + ' && ' + omzPath + '/demos/build_demos.sh -DENABLE_PYTHON=y --build_dir={}'.format(omzBuild)
    buildStr = openCVDirSet + ' && ' + LDPathSet + ' && ' + pythonSet + ' && ' + omzPath + '/demos/build_demos.sh --build_dir={}'.format(omzBuild)
    logging.debug(buildStr)
    os.system(buildStr)
    # Installing Python* Model API package
    os.system('pip install {omzPath}/demos/common/python'.format(omzPath=omzPath))
    if not os.path.isdir(omzBuild + '/intel64'):
        logging.error('Open Model Zoo Demo Build might be failed, output file path not found. {}'.format('> ' + omzBuild + '/intel64'))
        return -1

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