#!/bin/sh

# SHUtils_C.sh
#
#
# Created by Joel Gillette on 4/26
#

cd "$SRCROOT"/../Build_Scripts
. SHMaster.sh
if [ -n "$IS_JOEL" ]; then
	copyFiles "$SHFolder/Code/SHUtils_C" 'Headers'
	copyFiles "$SHFolder/Code/SHUtils_C"
	copyFiles "$SHFolder/Code/SHUtils_C" 'Copy'
	copyFiles "Code/SHDatetime/SHUtils_C"
fi

. module_map_copy.sh
#. resources_copy.sh

mkdir -p "$SH_COMMON_BUILD_ROOT/$CONFIGURATION"/inttypes &&
cp "$SRCROOT"/inttypes/module.modulemap "$SH_COMMON_BUILD_ROOT/$CONFIGURATION"/inttypes/module.modulemap
echo "$BUILT_PRODUCTS_DIR/$PRODUCT_NAME"
