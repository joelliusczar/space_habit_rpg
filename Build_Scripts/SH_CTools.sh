#!/bin/sh

# SH_CTools.sh
#
#
# Created by Joel Gillette on 4/26
#

cd ${SRCROOT}/../Build_Scripts
. SHMaster.sh
if [ -n "$IS_JOEL" ]; then
    copyFiles 'SH_CTools'
    copyFiles 'SH_CTools' 'Copy'
fi
