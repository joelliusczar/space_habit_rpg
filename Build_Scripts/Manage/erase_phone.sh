#!/bin/sh

#	erase_phone.sh
#	
#
#	Created by Joel Pridgen on 4/22/19.
#	

xcrun simctl shutdown all &&
xcrun simctl erase all

