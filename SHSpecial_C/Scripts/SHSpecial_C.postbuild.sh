#!/bin/sh

# SH_C.sh
#
#
# Created by Joel Gillette on 4/26
#

cd "$SRCROOT"/../Build_Scripts
. SHMaster.sh
if [ -n "$IS_JOEL" ]; then
	copyFiles 'Code' "$SHFolder/Code/SHSpecial_C"
	copyFiles 'Send' "$SHFolder/Code/SHSpecial_C"
	copyFiles 'Send/Scripts' "$SHFolder/ServerCopy"
fi


. module_map_copy.sh
xs=$?

(exit "$xs") && echo 'copy successful' || echo 'copy failed for some reason'
echo 'done SHSpecial'
