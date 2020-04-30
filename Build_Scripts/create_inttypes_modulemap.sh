#!/bin/sh

#  create_inttypes_modulemap.sh
#  
#
#  Created by Joel Pridgen on 4/27/20.
#  

MODULE_LOCATION="$SH_COMMON_BUILD_ROOT/$CONFIGURATION/inttypes/module.modulemap"


mkdir -p "$SH_COMMON_BUILD_ROOT/$CONFIGURATION/inttypes"
cat << EOF > "$MODULE_LOCATION"
module inttypes [system] [extern_c] {
	header "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/11.0.3/include/inttypes.h"
	export *
}
EOF
