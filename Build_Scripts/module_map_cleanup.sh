#!/bin/sh

#  CleanUpModuleMap.sh
#  
#
#  Created by Joel Pridgen on 3/18/20.
#  

#rm "$BUILT_PRODUCTS_DIR"/include/"$PRODUCT_NAME"/module.modulemap 2>/dev/null
rm -r "$BUILT_PRODUCTS_DIR"/Modules/ 2>/dev/null
