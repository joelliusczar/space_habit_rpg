#!/bin/sh

# SH_CTools.sh
#
#
# Created by Joel Gillette on 4/26
#

cd ${SRCROOT}/../Build_Scripts
. SHMaster.sh
if [ -n "$IS_JOEL" ]; then
    copyFiles "$SHFolder/Code/SH_CTools"
    copyFiles "$SHFolder/Code/SH_CTools" 'Copy'
    copyFiles "Code/SHDatetime/SH_CTools"
fi
