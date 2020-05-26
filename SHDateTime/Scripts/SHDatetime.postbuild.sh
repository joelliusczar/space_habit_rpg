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
	copyFiles 'Code' "$SHFolder/Code/SHDatetime"
	copyFiles 'Send/Makefiles/' "$SHFolder/Code/SHDatetime/"
	copyFiles 'Send/dt_prompt/Code' "$SHFolder/Code/dt_prompt"
	copyFiles 'Send/dt_prompt/Makefiles' "$SHFolder/Code/dt_prompt"
	#put the copy for the global files here because SHDatetime's
	#make is the first to be dependent on them
	cp -r "$SRCROOT"/../Send/ ${SRCROOT}/../../${SHFolder}/Code/
fi

. module_map_copy.sh
#cp "$SRCROOT"/Headers/inttypes.modulemap "$BUILT_PRODUCTS_DIR"/Modules/inttypes.modulemap

echo "Done with SHDatetime"
