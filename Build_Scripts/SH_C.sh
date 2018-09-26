#!/bin/sh

# SH_C.sh
#
#
# Created by Joel Gillette on 4/26
#

cd ${SRCROOT}/../Build_Scripts
. SHMaster.sh
if [ -n "$IS_JOEL" ]; then
    copyFiles "$SHFolder/SH_C"
	copyFiles "$SHFolder/SH_C" 'Copy'
fi
