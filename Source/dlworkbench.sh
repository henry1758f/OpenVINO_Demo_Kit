#!/bin/bash
# File: dlworkbench.sh

feature_install="Install Deep Learning Workbench"
feature_runstop_workbench="running Deep Learning Workbench"
unknow_input_str="Unknow options! Please Check your Input. "
token=""
function banner()
{
  echo "|====================================|"
  echo "|  OpenVINO Deep Learning Workbench  |"
  echo "|====================================|"
  echo ""
}
function feature_choose()
{
  local docker_stats
  docker_img_ls=$(docker images |grep "workbench")
  docker_container_stats=$(docker container ls |grep "workbench")
  if [[ $docker_img_ls == *"workbench"* ]]; then
    echo "1. RE-${feature_install}"
  else
    echo "1. ${feature_install} >>> ${docker_img_ls}"
  fi
  if [[ $docker_container_stats == *"workbench"* ]]; then
    echo "2. STOP running ${feature_runstop_workbench} "
    docker_stats="RUN"
  else
    echo "2. START running ${feature_runstop_workbench}"
    docker_stats="STOP"
  fi
  echo "3. Return to pervious list."
  if [[ $docker_container_stats == *"workbench"* ]]; then
    echo "4. Get Login Token to DL workbench"
  fi
  local choose
  read choose
  case $choose in
    "1")
      install_docker
      ;;
    "2")
      if [[ $docker_stats == "RUN" ]]; then
        stop_dlworkbench
      else
        echo "[INFO] Loading Deep Learning Workbench..."
        run_dlworkbench 
      fi
      ;;
    "3")
      return
      ;;
    "4")
      docker exec workbench cat /home/workbench/.workbench/token.txt
      echo ""
      echo ""
      echo "Press any key to continue..."
      read -n 1 INP
      if [ $INP != '' ] ; then
              echo -ne '\b \n'
      fi
      return
      ;;
    *)
      echo "[WARNING] $unknow_input_str"
      banner
      feature_choose
    ;;
  esac

}

function stop_dlworkbench()
{
  echo "[INFO] Stopping Deep Learning Workbench..."
  sudo ./start_workbench.sh -STOP workbench
}

function install_docker()
{
  echo "[INFO] Removing Old Docker..."
  echo "[Uninstall old Docker versions]"
  sudo apt-get remove docker docker-engine docker.io containerd runc
  echo "[INFO] Installing Latest Docker Repository and Engine..."
  echo "[Install latest Docker Repository and Engine]"
  sudo apt-get update
  sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
}

function run_dlworkbench()
{
  echo "[Run DeepLearning Workbench]"
  if [ -f ./start_workbench.sh ]; then
    sudo docker pull openvino/workbench:latest
    sudo ./start_workbench.sh -IMAGE_NAME openvino/workbench -TAG latest ENABLE_GPU
  else
    echo "[Download DeepLearning Workbench script]"
    wget https://raw.githubusercontent.com/openvinotoolkit/workbench_aux/master/start_workbench.sh
    chmod +x ./start_workbench.sh
    run_dlworkbench
  fi
}
banner
feature_choose


