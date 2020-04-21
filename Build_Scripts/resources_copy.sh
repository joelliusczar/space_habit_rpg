#!/bin/sh

#  resources_copy.sh
#  
#
#  Created by Joel Pridgen on 4/19/20.
#  


mkdir -p "$BUILT_PRODUCTS_DIR"/Resources/ &&
cp -r "$SRCROOT"/Resources/ "$BUILT_PRODUCTS_DIR"/Resources/
