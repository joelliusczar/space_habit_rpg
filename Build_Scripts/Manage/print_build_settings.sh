#!/bin/sh

#  print_build_settings.sh
#  
#
#  Created by Joel Pridgen on 12/15/19.
#  

cd $(dirname "$0")/../../ &&

xcodebuild -workspace SpaceHabitRPG.xcworkspace -scheme SpaceHabitRPG \
-showBuildSettings
