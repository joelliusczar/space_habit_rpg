#!/bin/bash

#  emptydb.sh
#  
#
#  Created by Joel Pridgen on 1/6/19.
#  Run this to reset my app to it's base state by clearing all the data.

usedDevice=${1:-Booted}

buildEnv=$(xcodebuild -workspace SpaceHabitRPG.xcworkspace -scheme SpaceHabitRPG \
 -showBuildSettings)

bundleID=$(echo "$buildEnv" | sed -n -e 's/PRODUCT_BUNDLE_IDENTIFIER *= *\(.*\)/\1/p')

sourceRoot=$(echo "$buildEnv" | sed -n -e 's/SRCROOT *= *\(.*\)/\1/p')

dataPath=$(xcrun simctl get_app_container "$usedDevice" "$bundleID" data)

sqlite3 "$dataPath"/Documents/Model.sqlite \
  "$sourceRoot"/Build_Scripts/SQL/clean_up_script.sql

echo 'Clean up done'
