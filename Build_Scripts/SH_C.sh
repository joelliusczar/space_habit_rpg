#!/bin/sh

# SH_C.sh
#
#
# Created by Joel Gillette on 4/26
#

cd ${SRCROOT}/../Build_Scripts
. SHMaster.sh
if [ -n "$IS_JOEL" ]; then
    copyFiles 'SH_C'
	copyFiles 'SH_C' 'Copy'
fi
