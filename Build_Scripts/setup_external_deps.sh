#!/bin/sh

libDir='spacehabit_extern_libs'
scriptDir=$(pwd)

cd '../..'

mkdir -p "$libDir/Configs" 2> /dev/null

echo '
	//
//
//

// Configuration settings file format documentation can be found at:
// https://help.apple.com/xcode/#/dev745c5c974


' > "$libDir/Configs/SHExternalLib.base.xcconfig"

if [ -e "$libDir/libxml2" ]; then
	rm -r "$libDir/libxml2"
fi
mkdir -p "$libDir/libxml2/untar"
cd "$libDir/libxml2/untar"
curl -o libxlm2-2.7.2.tar.gz  ftp://xmlsoft.org/libxml2/libxml2-2.7.2.tar.gz
tar -xf libxlm2-2.7.2.tar.gz

cd '../'

ruby "$scriptDir/create_libxml2_proj.rb" \
	'./untar/libxml2-2.7.2/include/libxml/*.h' \
	'./untar/libxml2-2.7.2/*.c' \
	'../../spacehabitrpg_output'

# cd 'libxml2.xcodeproj'
# touch 'project.pbxproj'
# mkdir 'project.xcworkspace'
# cd 'project.xcworkspace'
# echo '<?xml version="1.0" encoding="UTF-8"?>
# <Workspace
#    version = "1.0">
#    <FileRef
#       location = "self">
#    </FileRef>
# </Workspace>
# ' > 'contents.xcworkspacedata'
# mkdir 'xcshareddata'
# cd 'xcshareddata'
# echo '<?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
# <dict>
# 	<key>IDEDidComputeMac32BitWarning</key>
# 	<true/>
# </dict>
# </plist>
# ' > 'IDEWorkspaceChecks.plist'
# cd ..
# mkdir xcuserdata
