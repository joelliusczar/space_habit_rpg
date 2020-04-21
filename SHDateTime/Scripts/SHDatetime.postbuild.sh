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
	echo "Copying files for SHDatetime to $SHFolder/Code"
	copyFiles "$SHFolder/Code/SHDatetime" 'Headers'
	copyFiles "$SHFolder/Code/SHDatetime"
	copyFiles "$SHFolder/Code/SHDatetime" 'Copy/Makefiles'
	copyFiles "$SHFolder/Code/SHDatetime" 'Copy/dt_prompt/Code'
	cp -r ../Copy/ ${SRCROOT}/../../${SHFolder}/Code/
	copyFiles "Code/SHDatetime/SHDatetime" #Copy the library code
	copyFiles "Code/SHDatetime" 'Copy/dt_prompt/Code' #copy the test harness code
	copyFiles "Code/SHDatetime" 'Copy/dt_prompt/Copy' #copy the makefile
fi

. module_map_copy.sh
#cp "$SRCROOT"/Headers/inttypes.modulemap "$BUILT_PRODUCTS_DIR"/Modules/inttypes.modulemap

echo "Done with SHDatetime"
