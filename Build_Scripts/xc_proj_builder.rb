require 'securerandom'
require 'FileUtils'


class XcodeProjBuilder


OBJECT_DEF = '~object~  = {isa = PBXBuildFile; fileRef = ~fileRef~ ; settings = {ATTRIBUTES = (Public, ); }; };'
SOURCE_DEF = '~sourceRef~  = {isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = ~sourceCodePath~; sourceTree = "<group>"; };'
INFO_PLIST_DEF = '~infoPlist~  = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };'
OUTPUT_DEF = '~buidOutput~  = {isa = PBXFileReference; explicitFileType = archive.ar; includeInIndex = 0; path = SHUtils_C; sourceTree = BUILT_PRODUCTS_DIR; };'
SCRIPT_DEF = '~buildScript~ = {isa = PBXFileReference; lastKnownFileType = text.script.sh; path = ~scriptPath~; sourceTree = "<group>"; };'
MODULEMAP_DEF = '~moduleMap~  = {isa = PBXFileReference; lastKnownFileType = "sourcecode.module-map"; path = module.modulemap; sourceTree = "<group>"; };'
CONFIG_DEF = '~config~  = {isa = PBXFileReference; lastKnownFileType = text.xcconfig; path = ~configPath~; sourceTree = "<group>"; };'

	def initialize(projName, headerFromPaths, sourceFromPaths, buildOutputRoot)
		@projName = projName
		@projFiles = {}
		@groupKeys = {}
		@headerList = []
		@sourceList = []
		@productsList = []
		@resourcesList = []
		@frameworksList = []
		@scriptsList = []
		@configsList = []
		@moduleMapList = []
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
		create_info_plist(@projFiles, @resourcesList)
		create_configs(@projFiles, @configsList)
		create_scripts(@projFiles, @scriptsList)
		create_modulemap(@projFiles, @moduleMapList)
		copy_frameworks(@projFiles, @frameworksList)
		@headerFromPaths.each {|f| scan_source_files(f, @projFiles, @headerList, './Code') }
		@sourceFromPaths.each {|f| scan_source_files(f, @projFiles, @sourceList, './Code') }
		create_umbrella_header(@projFiles, @headerList)
		create_product_output(@projFiles, @projName, @productsList)
		create_scripts(@projFiles, @scriptsList)
		setup_xcode_skeleton

		codeFiles = @headerList + @sourceList + @moduleMapList

		
		objectList = @projFiles.keys
			.map {|k| @projFiles[k][:objectDef]} * "\n\t\t"
		templateContent.gsub!('~fullObjectList~',objectList)
		templateContent.gsub!('~targetProxyDef~', get_xc_uuid)
		templateContent.gsub!('~rootObject~', get_xc_uuid)
		templateContent.gsub!('~targetDef~', @targetDefId)
		templateContent.gsub!('~projName~',@projName)
		fileList = @projFiles.keys
			.map {|k| @projFiles[k][:projFileDef]} * "\n\t\t"
		templateContent.gsub!('~fullFileDefList~',fileList)
		templateContent.gsub!('~targetFrameworkPhaseDef~', get_xc_uuid)
		templateContent.gsub!('~codeGroup~', get_xc_uuid)

		codeIdList = codeFiles.map{|f| @projFiles[f][:fileId] } * "\n\t\t\t"
		templateContent.gsub!('~fullCodeFileList~', codeIdList)

		templateContent.gsub!('~resourcesGroup~', get_xc_uuid)

		resourceIdList = @resourcesList.map{|f| @projFiles[f][:fileId] } * "\n\t\t\t"
		templateContent.gsub!('~resourceFilelist~', resourceIdList)

		templateContent.gsub!('~mainGroup~', get_xc_uuid)
		templateContent.gsub!('~scriptsGroup~', get_xc_uuid)
		templateContent.gsub!('~configsGroup~', get_xc_uuid)
		templateContent.gsub!('~productsGroup~', get_xc_uuid)
		templateContent.gsub!('~frameworksGroup~', get_xc_uuid)

		productsIdList = @productsList.map{|f| @projFiles[f][:fileId] } * "\n\t\t\t"
		templateContent.gsub!('~productsIdList~', productsIdList)

		frameworkIdList = @frameworksList.map{|f| @projFiles[f][:fileId] } * "\n\t\t\t"
		templateContent.gsub!('~scriptIdList~', frameworkIdList)

		scriptIdList = @scriptsList.map{|f| @projFiles[f][:fileId] } * "\n\t\t\t"
		templateContent.gsub!('~frameworksIdList~', scriptIdList)

		configIdList = @configsList.map{|f| @projFiles[f][:fileId] } * "\n\t\t\t"
		templateContent.gsub!('~configIdList~', configIdList)

		templateContent.gsub!('~headerPhaseDef~', get_xc_uuid)

		headersIdList = @headerList.map{|f| @projFiles[f][:objectId] } * "\n\t\t\t"
		templateContent.gsub!('~objectIdHeaderList~', headersIdList)

		templateContent.gsub!('~shellScriptPhase1Def~', get_xc_uuid)
		templateContent.gsub!('~phaseSources~', get_xc_uuid)
		templateContent.gsub!('~shellScriptPhase2Def~', get_xc_uuid)

		configIdList = @configsList.map{|f| @projFiles[f][:fileId] } * "\n\t\t\t"
		templateContent.gsub!('~projectConfigList~', configIdList)

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

		projAccountDatadPath = "#{projUserDataPath}/#{@accountName}.xcuserdatad"
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

	def create_info_plist(projFiles, resourcesList)
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

		add_entry(projFiles, resourcesList, 'info.plist', method(:transform_info_plist_def))
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

	def scan_source_files(fileDir, projFiles, fileList, destDir)
		Dir.glob(fileDir) do |filepath|
			next if filepath == '.' or filepath == '..'
			fileName = File.basename(filepath)
			if destDir
				dest = "#{destDir}/#{fileName}"
				FileUtils.cp(filepath, dest)
			end

			add_entry(projFiles, fileList, fileName, method(:transform_source_def))
		end
	end

	def create_umbrella_header(projFiles, headersList)
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

		fileName = "#{@projName}.h"
		umbrellaHeaderPath = "./Code/#{fileName}"
		File.write(umbrellaHeaderPath, umbrellaHeader)

		add_entry(projFiles, headersList, fileName, method(:transform_source_def))
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

	def create_product_output(projFiles, projName, productsList)
		fileName = projName
		system("touch ./Products/#{fileName}")

		add_entry(projFiles, productsList, fileName, method(:transform_output_def))
	end

	def create_modulemap(projFiles, moduleMapList)
		moduleMapPath = "./Code/module.modulemap"
		moduleMapContent = <<~EOF
		framework module #{@projName} [extern_c] {
			umbrella header "#{@projName}.h"
			module * { export * }
			export *
		}
		EOF
		File.write(moduleMapPath, moduleMapContent)

		add_entry(projFiles, moduleMapList, "module.modulemap", 
			method(:transform_module_map_def))
	end

	def copy_frameworks(projFiles, frameworksList)
	end

	def transform_object_def(replacements)
		OBJECT_DEF.gsub('~fileRef~', replacements[:fileId])
				.gsub('~object~', replacements[:objectId])
	end

	def transform_source_def(replacements)
		SOURCE_DEF.gsub('~sourceRef~', replacements[:fileId])
			.gsub('~sourceCodePath~', replacements[:path])
	end

	def transform_info_plist_def(replacements)
		INFO_PLIST_DEF.gsub('~infoPlist~', replacements[:fileId])
	end

	def transform_output_def(replacements)
		OUTPUT_DEF.gsub('~buidOutput~',replacements[:fileId])
			.gsub('~outputName~', replacements[:path])
	end

	def transform_module_map_def(replacements)
		MODULEMAP_DEF.gsub('~moduleMap~', replacements[:fileId])
	end

	def transform_script_def(replacements)
		SCRIPT_DEF.gsub('~buildScript~', replacements[:fileId])
			.gsub('~scriptPath~', replacements[:path])
	end

	def transform_config_def(replacements)
		CONFIG_DEF.gsub('~config~', replacements[:fileId])
			.gsub('~configPath~', replacements[:path])
	end

	def add_entry(projFiles, fileList, fileName, transformFn)
		objectData = { fileId: get_xc_uuid,
			objectId: get_xc_uuid,
			path: fileName }

		objectData[:projFileDef] = transformFn.call(objectData)
		objectData[:objectDef] = transform_object_def(objectData)
		projFiles[fileName] = objectData
		fileList << fileName
	end

	def get_xc_uuid
		SecureRandom.hex(12).upcase
	end

end