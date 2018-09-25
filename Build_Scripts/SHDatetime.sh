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
	copyFiles 'SHDatetime'
	copyFiles 'SHDatetime' 'Copy'
	cp -r ../Copy/ ${SRCROOT}/../../SH_CP/
fi

