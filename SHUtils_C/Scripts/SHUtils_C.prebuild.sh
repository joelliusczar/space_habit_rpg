#!/bin/sh

#	SHUtils_C.prebuild.sh
#	SHUtils_C
#
#	Created by Joel Pridgen on 5/10/19.
#	Copyright © 2019 Joel Gillette. All rights reserved.

cd "$SRCROOT"/../Build_Scripts

. module_map_cleanup.sh
. headers_cleanup.sh
rm -r "$SH_COMMON_BUILD_ROOT/$CONFIGURATION"/inttypes 2>/dev/null

bash create_inttypes_modulemap.sh
exit 0
