#!/bin/sh

#  DTCopy.sh
#  
#
#  Created by Joel Pridgen on 4/26/18.
#
subPath="/$1"
#if [ -n "$IS_JOEL" ]; then
    rm -r -f $SRCROOT/../../Code/dttests/Code${subPath}
    cp -r -f $SRCROOT/Code/ $SRCROOT/../../Code/dttests/Code${subPath}
#fi
