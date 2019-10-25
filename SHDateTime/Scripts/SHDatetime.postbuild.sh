#!/bin/sh

# SHDatetime.sh
#
#
# Created by Joel Gillette on 4/26
#

cd ${SRCROOT}/../Build_Scripts
. SHMaster.sh
pwd
#disabling this code for now to speed up build time
if [ -n "$IS_JOEL" ] && [ False ]; then
	copyFiles "$SHFolder/Code/SHDatetime"
	copyFiles "$SHFolder/Code/SHDatetime" 'Copy/Makefiles'
	copyFiles "$SHFolder/Code/SHDatetime" 'Copy/dt_prompt/Code'
	cp -r ../Copy/ ${SRCROOT}/../../${SHFolder}/Code/
	copyFiles "Code/SHDatetime/SHDatetime" #Copy the library code
	copyFiles "Code/SHDatetime" 'Copy/dt_prompt/Code' #copy the test harness code
	copyFiles "Code/SHDatetime" 'Copy/dt_prompt/Copy' #copy the makefile
fi

