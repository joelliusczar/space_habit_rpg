#!/bin/sh

cd ../../

mkdir 'spaceHabitExternalLibs' 2> /dev/null

cd 'spaceHabitExternalLibs'
if [ -e './libxml2' ]; then
	rm -r './libxml2'
fi
mkdir -p 'libxml2/untar'
cd './libxml2/untar'
curl -o libxlm2-2.7.2.tar.gz  ftp://xmlsoft.org/libxml2/libxml2-2.7.2.tar.gz
tar -xf libxlm2-2.7.2.tar.gz

cd ..
pwd
ruby '../../spacehabitrpg/Build_Scripts/libxml2MakeProj.rb'
mkdir 'libxml2.xcodeproj'
cd 'libxml2.xcodeproj'
touch 'project.pbxproj'
mkdir 'project.xcworkspace'
cd 'project.xcworkspace'
echo '<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "self">
   </FileRef>
</Workspace>
' > 'contents.xcworkspacedata'
mkdir 'xcshareddata'
cd 'xcshareddata'
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>IDEDidComputeMac32BitWarning</key>
	<true/>
</dict>
</plist>
' > 'IDEWorkspaceChecks.plist'
cd ..
mkdir xcuserdata
