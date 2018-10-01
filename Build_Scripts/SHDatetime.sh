#!/bin/sh

# SHDatetime.sh
#
#
# Created by Joel Gillette on 4/26
#

cd ${SRCROOT}/../Build_Scripts
. SHMaster.sh
pwd
if [ -n "$IS_JOEL" ]; then
	copyFiles "$SHFolder/SHDatetime"
	copyFiles "$SHFolder/SHDatetime" 'Copy/Makefiles'
	copyFiles "$SHFolder/SHDatetime" 'Copy/dt_prompt/Code'
	cp -r ../Copy/ ${SRCROOT}/../../${SHFolder}/
	copyFiles "Code/SHDatetime/SHDatetime" #Copy the library code
	copyFiles "Code/SHDatetime" 'Copy/dt_prompt/Code' #copy the test harness code
	copyFiles "Code/SHDatetime" 'Copy/dt_prompt/Copy' #copy the makefile
fi

