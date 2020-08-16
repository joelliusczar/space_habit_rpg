#!/usr/bin/env ruby

require 'securerandom'

def get_xc_uuid() 
	SecureRandom.uuid.gsub('-','')[0..23].upcase()
end

projFiles = Hash.new
objectDef = '~object~  = {isa = PBXBuildFile; fileRef = ~fileRef~ ; settings = {ATTRIBUTES = (Public, ); }; };'
sourceRefDef = '~sourceRef~  = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ~sourceCodePath~; sourceTree = "<group>"; };'
infoPlistDef = '~infoPlist~  = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };'
outputDef = '~buidOutput~  = {isa = PBXFileReference; explicitFileType = archive.ar; includeInIndex = 0; path = SHUtils_C; sourceTree = BUILT_PRODUCTS_DIR; };'
preScriptDef = '~prebuildScript~ = {isa = PBXFileReference; lastKnownFileType = text.script.sh; path = ~projName~.postbuild.sh; sourceTree = "<group>"; };'
postScriptDef = '~postbuildScript~ = {isa = PBXFileReference; lastKnownFileType = text.script.sh; path = ~projName~.prebuild.sh; sourceTree = "<group>"; };'
moduleMapDef = '~moduleMap~  = {isa = PBXFileReference; lastKnownFileType = "sourcecode.module-map"; path = module.modulemap; sourceTree = "<group>"; };'
debugConfigDef = '~debugConfig~  = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = ~projName~.debug.xcconfig; sourceTree = "<group>"; };'
baseConfigDef = '~baseConfig~  = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = ~projName~.base.xcconfig; sourceTree = "<group>"; };'
frameworksIdList = ''
scriptIdList = '~prebuildScript~,\n\t\t\t\t~postbuildScript~,'
configIdList = '~debugConfig~,\n\t\t\t\t~baseConfig~'
sendGroupIdList = ''
objectIdHeaderList = ''
objectIdSourceList = ''
fullObjectList = ''
developerName = '' //args
projName = '' //args
resourcesBuildPhase = get_xc_uuid()
shellScriptPhase1Content = '' //args
shellScriptPhase2Content = '' //args

Dir.foreach("./untar/libxml2-2.7.2/include/*.h") do |filename|
	next if filename == '.' or filename == '..'
	dest = "./Code/#{filename}"
	FileUtils.cp(filename, dest)
	projFiles[filename] = get_xc_uuid()
end

Dir.foreach("./untar/libxml2-2.7.2/*.c") do |filename|
	next if filename == '.' or filename == '..'
	dest = "./Code/#{filename}"
	FileUtils.cp(filename, dest)
	projFiles[filename] = get_xc_uuid()
end