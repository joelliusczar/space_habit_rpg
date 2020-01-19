#!/bin/sh

# SHUtils_C.sh
#
#
# Created by Joel Gillette on 4/26
#

cd "$SRCROOT"/../Build_Scripts
#. SHMaster.sh
#if [ -n "$IS_JOEL" ]; then
#	copyFiles "$SHFolder/Code/SHUtils_C"
#	copyFiles "$SHFolder/Code/SHUtils_C" 'Copy'
#	copyFiles "Code/SHDatetime/SHUtils_C"
#fi

cp "$SRCROOT"/Headers/module.modulemap "$BUILT_PRODUCTS_DIR"/include/"$PRODUCT_NAME"/module.modulemap
