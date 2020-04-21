#!/bin/sh

# SH_C.sh
#
#
# Created by Joel Gillette on 4/26
#

cd "$SRCROOT"/../Build_Scripts
. SHMaster.sh
#if [ -n "$IS_JOEL" ] && [ False ]; then
#	copyFiles "$SHFolder/Code/SH_C"
#	copyFiles "$SHFolder/Code/SH_C" 'Copy'
#	copyFiles "$SHFolder/ServerCopy" "Scripts"
#fi


. module_map_copy.sh
xs=$?

(exit "$xs") && echo 'copy successful' || echo 'copy failed for some reason'
echo 'done SHSpecial'
