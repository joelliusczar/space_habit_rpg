require 'securerandom'
require 'FileUtils'


class XcodeProjBuilder


OBJECT_DEF = '~object~  = {isa = PBXBuildFile; fileRef = ~fileRef~ ; settings = {ATTRIBUTES = (Public, ); }; };'
SOURCE_DEF = '~sourceRef~  = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ~sourceCodePath~; sourceTree = "<group>"; };'
INFO_PLIST_DEF = '~infoPlist~  = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };'
OUTPUT_DEF = '~buidOutput~  = {isa = PBXFileReference; explicitFileType = archive.ar; includeInIndex = 0; path = SHUtils_C; sourceTree = BUILT_PRODUCTS_DIR; };'
PRESCRIPT_DEF = '~buildScript~ = {isa = PBXFileReference; lastKnownFileType = text.script.sh; path = ~scriptPath~; sourceTree = "<group>"; };'
MODULEMAP_DEF = '~moduleMap~  = {isa = PBXFileReference; lastKnownFileType = "sourcecode.module-map"; path = module.modulemap; sourceTree = "<group>"; };'
CONFIG_DEF = '~config~  = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = ~configPath~; sourceTree = "<group>"; };'

	def initialize(projName, headerFromPaths, sourceFromPaths, buildOutputRoot)
		@projName = projName
		@projFiles = {}
		@groupKeys = {}
		@headerList = []
		@sourceList = []
		@headerFromPaths = headerFromPaths
		@sourceFromPaths = sourceFromPaths
		@accountName = (/darwin/ =~ RUBY_PLATFORM) != nil ? `id -un` : 'missing_name'
		@accountName.chomp!
		@devName = (/darwin/ =~ RUBY_PLATFORM) != nil ? `id -F` : 'missing_name'
		@devName.chomp!
		@buildOutputRoot = buildOutputRoot
		@targetDefId = get_xc_uuid
	end

	def full_setup
		
		@schemesTemplateContent = File.read("#{__dir__}/schemesTemplate.txt")
		templateContent = File.read("#{__dir__}/templateProj.txt")
		setup_groups
		create_info_plist(@projFiles)
		create_configs(@projFiles)
		create_scripts(@projFiles)
		create_modulemap(@projFiles)
		@headerFromPaths.each {|f| scan_files(f, @projFiles, @headerList, './Code') }
		@sourceFromPaths.each {|f| scan_files(f, @projFiles, @sourceList, './Code') }
		create_umbrella_header(@headerList, @projFiles)
		setup_xcode_skeleton
		
		objectList = @projFiles.keys
			.map {|k| transform_object_def(@projFiles[k])} * "\n\t\t"
		templateContent.gsub!('~fullObjectList~',objectList)
		templateContent.gsub!('~targetProxyDef~', get_xc_uuid)
		templateContent.gsub!('~rootObject~', get_xc_uuid)
		templateContent.gsub!('~targetDef~', @targetDefId)
		templateContent.gsub!('~projName~',@projName)
		fileList = @projFiles.keys
			.map {|k| transform_source_def(@projFiles[k])} * "\n\t\t"
		templateContent.gsub!('~fullFileDefList~',fileList)
		templateContent.gsub!('~targetFrameworkPhaseDef~', get_xc_uuid)
		templateContent.gsub!('~codeGroup~', get_xc_uuid)
		templateContent.gsub!('~resourcesGroup~', get_xc_uuid)
		templateContent.gsub!('~mainGroup~', get_xc_uuid)
		templateContent.gsub!('~scriptsGroup~', get_xc_uuid)
		templateContent.gsub!('~configsGroup~', get_xc_uuid)
		templateContent.gsub!('~productsGroup~', get_xc_uuid)
		templateContent.gsub!('~frameworksGroup~', get_xc_uuid)
		File.write("#{@projName}.xcodeproj/project.pbxproj",templateContent)
	end

	def create_config(projFiles)
		puts("create_config super")
	end

	def setup_xcode_skeleton()

		#xcodeproj
		projPath = "#{@projName}.xcodeproj"
		Dir.mkdir(projPath) unless File.exists?(projPath)

		#xcodeproj > xcworkspace
		workspacePath = "#{projPath}/project.xcworkspace"
		Dir.mkdir(workspacePath) unless File.exists?(workspacePath)

		create_workspace_data(workspacePath)

		#codeproj > xcworkspace > xcshareddata
		sharedDataPath = "#{workspacePath}/xcshareddata"
		Dir.mkdir(sharedDataPath) unless File.exists?(sharedDataPath)

		create_workspace_checks(sharedDataPath)
		create_workspace_settings(sharedDataPath)

		#codeproj > xcworkspace > xcuserdata
		userDataPath = "#{workspacePath}/xcuserdata"
		Dir.mkdir(userDataPath) unless File.exists?(userDataPath)

		accountDatadPath = "#{userDataPath}/#{@accountName}.xcuserdatad"
		Dir.mkdir(accountDatadPath) unless File.exists?(accountDatadPath)

		if @buildOutputRoot
			create_workspace_build_settings(accountDatadPath,@buildOutputRoot) 
		end

		#xcodeproj > xcshareddata
		projSharedDataPath = "#{projPath}/xcshareddata"
		Dir.mkdir(projSharedDataPath) unless File.exists?(projSharedDataPath)

		schemesPath = "#{projSharedDataPath}/xcschemes"
		Dir.mkdir(schemesPath) unless File.exists?(schemesPath)

		create_product_schemes(@schemesTemplateContent, schemesPath)

		#xcodeproj > xcuserdata
		projUserDataPath = "#{projPath}/xcuserdata"
		Dir.mkdir(projUserDataPath) unless File.exists?(projUserDataPath)

		puts(@accountName)
		projAccountDatadPath = "#{projUserDataPath}/#{@accountName}.xcuserdatad"
		puts(projAccountDatadPath)
		Dir.mkdir(projAccountDatadPath) unless File.exists?(projAccountDatadPath)
		
		accountDataSchemePath = "#{projAccountDatadPath}/xcschemes"
		Dir.mkdir(accountDataSchemePath) unless File.exists?(accountDataSchemePath)
		create_scheme_management(accountDataSchemePath, @projName, @targetDefId)

	end

	def setup_groups
		Dir.mkdir('./Scripts') unless File.exists?('./Scripts')
		@groupKeys['Scripts'] = get_xc_uuid

		Dir.mkdir('./Code') unless File.exists?('./Code')
		@groupKeys['Code'] = get_xc_uuid

		Dir.mkdir('./Configs') unless File.exists?('./Configs')
		@groupKeys['Configs'] = get_xc_uuid

		Dir.mkdir('./Resources') unless File.exists?('./Resources')
		@groupKeys['Resources'] = get_xc_uuid

		Dir.mkdir('./Products') unless File.exists?('./Products')
		@groupKeys['Products'] = get_xc_uuid

		Dir.mkdir('./Frameworks') unless File.exists?('./Frameworks')
		@groupKeys['Frameworks'] = get_xc_uuid
	end

	def create_info_plist(projFiles)
		infoPlistPath = './Resources/info.plist'
		infoPlistContent = <<~PLIST
		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>CFBundleDevelopmentRegion</key>
			<string>$(DEVELOPMENT_LANGUAGE)</string>
			<key>CFBundleExecutable</key>
			<string>lib$(EXECUTABLE_NAME).a</string>
			<key>CFBundleIdentifier</key>
			<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
			<key>CFBundleInfoDictionaryVersion</key>
			<string>6.0</string>
			<key>CFBundleName</key>
			<string>$(PRODUCT_NAME)</string>
			<key>CFBundlePackageType</key>
			<string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
			<key>CFBundleShortVersionString</key>
			<string>1.0</string>
			<key>CFBundleVersion</key>
			<string>$(CURRENT_PROJECT_VERSION)</string>
		</dict>
		</plist>
		PLIST

		File.write(infoPlistPath, infoPlistContent)
		projFiles['info.plist'] = { fileId: get_xc_uuid(), objectId: get_xc_uuid(), path: 'info.plist' }	
	end


	def create_workspace_data(workspacePath)
		workspaceContent = <<~EOF 
		<?xml version="1.0" encoding="UTF-8"?>
		<Workspace
				version = "1.0">
				<FileRef
					location = "self">
				</FileRef>
		</Workspace>
		EOF
		File.write("#{workspacePath}/contents.xcworkspacedata", workspaceContent)
	end

	def create_workspace_checks(sharedDataPath)
		checksPlistContent = <<~EOF
		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>IDEDidComputeMac32BitWarning</key>
			<true/>
		</dict>
		</plist>
		EOF

		File.write("#{sharedDataPath}/IDEWorkspaceChecks.plist", checksPlistContent)
	end

	def create_workspace_settings(sharedDataPath)

		settingsContent = <<~SETTINGS
		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>PreviewsEnabled</key>
			<false/>
		</dict>
		</plist>
		SETTINGS
			File.write("#{sharedDataPath}/WorkspaceSettings.xcsettings",settingsContent)
	end

	def create_workspace_build_settings(path, outputRoot)
		settingsContent = <<~SETTINGS
		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>BuildLocationStyle</key>
			<string>UseAppPreferences</string>
			<key>CustomBuildIntermediatesPath</key>
			<string>#{outputRoot}/Build/Intermediates.noindex</string>
			<key>CustomBuildLocationType</key>
			<string>RelativeToWorkspace</string>
			<key>CustomBuildProductsPath</key>
			<string>#{outputRoot}/Build/Products</string>
			<key>CustomIndexStorePath</key>
			<string>#{outputRoot}/Index/DataStore</string>
			<key>DerivedDataLocationStyle</key>
			<string>Default</string>
			<key>EnabledFullIndexStoreVisibility</key>
			<false/>
			<key>IssueFilterStyle</key>
			<string>ShowAll</string>
			<key>LiveSourceIssuesEnabled</key>
			<true/>
		</dict>
		</plist>
		
		SETTINGS
		File.write("#{path}/WorkspaceSettings.xcsettings",settingsContent)
	end

	def scan_files(fileDir, projFiles, fileList, destDir)
		Dir.glob(fileDir) do |filepath|
			next if filepath == '.' or filepath == '..'
			filename = File.basename(filepath)
			if destDir
				dest = "#{destDir}/#{filename}"
				FileUtils.cp(filepath, dest)
			end
			projFiles[filename] = { fileId: get_xc_uuid(), objectId: get_xc_uuid(), path: filename }
			fileList << filename
		end
	end

	def create_umbrella_header(headersList, projFiles)
		importList = headersList.collect { |h| "#import \"#{h}\";"} * "\n"
		umbrellaHeader = <<~UMBRELLA
		//
		//	#{@projName}.h
		//	#{@projName}
		//
		//

		#ifndef #{@projName}_h
		#define #{@projName}_h
		#{importList}
		#endif /* #{@projName}_h */
		UMBRELLA

		umbrellaHeaderPath = "./Code/#{@projName}.h"
		File.write(umbrellaHeaderPath, umbrellaHeader)
		projFiles["#{@projName}.h"] = { fileId: get_xc_uuid(), objectId: get_xc_uuid(), path: "#{@projName}.h" }
	end

	def create_scheme_management(path, projName, targetDef)

		schemeManagement = <<~SCHEME
		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>SchemeUserState</key>
			<dict>
				<key>#{projName}.xcscheme_^#shared#^_</key>
				<dict>
					<key>orderHint</key>
					<integer>0</integer>
				</dict>
			</dict>
			<key>SuppressBuildableAutocreation</key>
			<dict>
				<key>#{targetDef}</key>
				<dict>
					<key>primary</key>
					<true/>
				</dict>
			</dict>
		</dict>
		</plist>
		SCHEME

		schemelistPath = "#{path}/xcschememanagement.plist"
		File.write(schemelistPath, schemeManagement)

	end

	def create_product_schemes(schemesTemplateContent, path)
		schemesContent = schemesTemplateContent.gsub!('~targetDef~',@targetDefId)
			.gsub('~projName~', @projName)
		File.write("#{path}/#{@projName}.xcscheme", schemesContent)
	end


	def transform_object_def(replacements)
		OBJECT_DEF.gsub('~fileRef~', replacements[:fileId])
				.gsub('~object~', replacements[:objectId])
	end

	def transform_source_def(replacements)
		SOURCE_DEF.gsub('~sourceRef~', replacements[:fileId])
			.gsub('~sourceCodePath~', replacements[:path])
	end

	def get_xc_uuid
		SecureRandom.hex(12).upcase
	end

end