#!/bin/sh

#  ModuleMapCopy.sh
#  
#
#  Created by Joel Pridgen on 3/18/20.
#  
#cp "$SRCROOT"/Headers/"$PRODUCT_NAME".h "$BUILT_PRODUCTS_DIR"/include/"$PRODUCT_NAME"/"$PRODUCT_NAME".h
#cp "$SRCROOT"/Headers/module.modulemap "$BUILT_PRODUCTS_DIR"/include/"$PRODUCT_NAME"/module.modulemap

mkdir -p "$BUILT_PRODUCTS_DIR"/Modules/ &&
cp "$SRCROOT"/Headers/module.modulemap "$BUILT_PRODUCTS_DIR"/Modules/module.modulemap
echo "$BUILT_PRODUCTS_DIR/$PRODUCT_NAME"
echo "Module Map Copied"
