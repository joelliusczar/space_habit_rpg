#!/bin/sh

#  SHCommon.prebuild.sh
#  SHCommon
#
#  Created by Joel Pridgen on 1/18/20.
#  Copyright © 2020 Joel Gillette. All rights reserved.

#I shouldn't have to care about SHSpecial_C here
[ -e "$BUILT_PRODUCTS_DIR"/include/SHSpecial_C/module.modulemap ] && echo "It's there" || echo 'not there'

ls "$BUILT_PRODUCTS_DIR"
echo "SDKROO $SDKROOT"
echo "system headers $SYSTEM_HEADER_SEARCH_PATHS"
echo "stupid path $STUPID_PATH"
echo "asshole path $ASSHOLE_PATH"
echo "intmod $INTTYPES_MODMAP_FLAG"
