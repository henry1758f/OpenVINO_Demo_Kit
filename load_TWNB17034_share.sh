#!/bin/bash
# File: load_TWNB17034_share.sh
# ver 0.1.1
# This is design for connecting to the share folder on TWNB17034
# 2017/11/08 	henry1758	0.1.0 	first-create
# 2018/05/15	henry1758	0.1.1	checki_dir bug fixed.
#

export VERSION="0.1.1"S
DIR_LOC="Desktop/TWNB17034"
NET_DIR_LOC_0="//TWNB17034/TWNB17034_share"

function make_dir()
{
	mkdir ${DIR_LOC} && echo " Create the directory-> \"$DIR_LOC\""
}

function check_dir()
{
	test -e ${DIR_LOC} || echo "${DIR_LOC} is NOT EXIST !!!" 
	test -e ${DIR_LOC} || make_dir

}
function mount_dir()
{

	sudo mount.cifs ${NET_DIR_LOC_0} ${DIR_LOC} -o username=henryhuang,password=$LINKPWD,uid=1000 0 0 && echo "Mount Success!! " || echo "Mount FAILED!!" 

}


echo
echo "|=========================================|"
echo "|  SYNNEX TECHNOLOGY INTERNATIONAL CORP.  |"
echo "|                                         |"
echo "|   Mount local Network folders Service   |"
echo "|=========================================|"
echo "          Version $VERSION                 "
echo ""
echo ""

echo "- Enter the password of the terminal user ->" 
read -s LINKPWD
check_dir
mount_dir

exit 0
