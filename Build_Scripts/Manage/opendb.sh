#!/bin/sh

#  opendb.sh
#  
#
#  Created by Joel Pridgen on 1/19/19.
#  
usedDevice=${1:-Booted}

#assumption source root/Build_Sripts/Manage
cd $(dirname "$0")/../../

buildEnv=$(xcodebuild -workspace SpaceHabitRPG.xcworkspace -scheme \
  SpaceHabitRPG -showBuildSettings)



bundleId=$(echo "$buildEnv" | \
  sed -n -e 's/^ *PRODUCT_BUNDLE_IDENTIFIER *= *\(.*\)/\1/p')

dataPath=$(xcrun simctl get_app_container "$usedDevice" "$bundleId" data)


sqlite3 "$dataPath"/Documents/Model.sqlite
