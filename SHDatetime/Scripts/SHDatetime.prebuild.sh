#!/bin/sh

#  SHDatetime.prebuild.sh
#  SHDatetime
#
#  Created by Joel Pridgen on 5/10/19.
#  Copyright © 2019 Joel Gillette. All rights reserved.

cd "$SRCROOT"/../Build_Scripts

echo "system headers $SYSTEM_HEADER_SEARCH_PATHS"


. module_map_cleanup.sh
#rm "$BUILT_PRODUCTS_DIR"/Modules/inttypes.modulemap 2>dev/null


exit 0
