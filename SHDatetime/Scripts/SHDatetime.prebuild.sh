#!/bin/sh

#  SHDatetime.prebuild.sh
#  SHDatetime
#
#  Created by Joel Pridgen on 5/10/19.
#  Copyright © 2019 Joel Gillette. All rights reserved.

echo 'hello'


rm "$BUILT_PRODUCTS_DIR"/include/"$PRODUCT_NAME"/module.modulemap 2>/dev/null

if [ -e "$BUILT_PRODUCTS_DIR"/include/"$PRODUCT_NAME"/module.modulemap ]; then
	echo 'What the fuck?'
else
	echo 'deleted that bitch!'
fi

exit 0
