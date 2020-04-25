#!/bin/sh

#	SHCore_C.prebuild.sh
#	SHCore_C
#
#	Created by Joel Pridgen on 5/5/19.
#	Copyright © 2019 Joel Gillette. All rights reserved.

cd "$SRCROOT"/../Build_Scripts

echo "a module path: $SHUTILS_C_MODMAP_FLAG"
echo "other flags $OTHER_CFLAGS"

. module_map_cleanup.sh

echo "Done with SHSpecial_C pre"

exit 0
