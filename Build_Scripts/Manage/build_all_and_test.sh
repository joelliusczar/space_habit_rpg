#!/bin/sh

#	build_all_and_test.sh
#	
#
#	Created by Joel Pridgen on 1/25/19.
#	

cd $(dirname "${BASH_SOURCE[0]}")/../..

xcodebuild test -project SHDatetime/SHDatetime.xcodeproj -scheme SHDatetime -destination 'platform=macosx' -quiet
xcodebuild test -project SHSpecial_C/SHSpecial_C.xcodeproj -scheme SHSpecial_C -destination 'platform=macosx' -quiet
xcodebuild test -project SHCommon/SHCommon.xcodeproj -scheme SHCommon -destination 'platform=macosx' -quiet
xcodebuild test -project SHModels/SHModels.xcodeproj -scheme SHModels -destination 'platform=macosx' -quiet
