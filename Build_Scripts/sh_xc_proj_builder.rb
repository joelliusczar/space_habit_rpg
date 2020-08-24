
require_relative 'xc_proj_builder'

class SHLibCXcodeProjBuilder < XcodeProjBuilder

	def create_configs(projFiles)
		baseConfigPath = "./Configs/#{@projName}.base.xcconfig"
		baseConfigContent = <<~CONFIG
		//
		//	#{@rojName}.base.xcconfig
		//	#{@projName}
		//
		//

		// Configuration settings file format documentation can be found at:
		// https://help.apple.com/xcode/#/dev745c5c974

		#include "../Configs/SHExternalLib.base.xcconfig"

		CONFIG
		File.write(baseConfigPath, baseConfigContent)
		projFiles["#{@projName}.base.xcconfig"] = { fileId: get_xc_uuid(), objectId: get_xc_uuid(), path: "#{@projName}.base.xcconfig" }
	end

	def create_scripts(projFiles)
		create_prescript(projFiles)
		create_postscript(projFiles)
	end

	def create_prescript(projFiles)
		scriptPath = "./Scripts/#{@projName}.prebuild.sh"
		scriptContent = <<~SCRIPT
		#!/bin/sh

		#	#{@proName}.prebuild.sh
		#	#{@proName}
		#
		#	Created by #{@devName} on #{Time.new.month}/#{Time.new.day}/#{Time.new.year}.
		#	Copyright © #{Time.new.year} #{@devName} All rights reserved.

		cd "$SRCROOT"/../Build_Scripts

		. module_map_cleanup.sh
		. headers_cleanup.sh

		exit 0

		SCRIPT
		File.write(scriptPath, scriptContent)
		projFiles["#{@projName}.postbuild.sh"] = { fileId: get_xc_uuid(), objectId: get_xc_uuid(), path: "#{@projName}.postbuild.sh" }	
	end

	def create_postscript(projFiles)
		scriptPath = "./Scripts/#{@projName}.postbuild.sh"
		scriptContent = <<~SCRIPT
		#!/bin/sh

		#	#{@proName}.postbuild.sh
		#	#{@proName}
		#
		#	Created by #{@devName} on #{Time.new.month}/#{Time.new.day}/#{Time.new.year}.
		#	Copyright © #{Time.new.year} #{@devName} All rights reserved.

		cd "$SRCROOT"/../Build_Scripts
		. SHMaster.sh

		. module_map_copy.sh

		exit 0

		SCRIPT
		File.write(scriptPath, scriptContent)
		projFiles["#{@projName}.postbuild.sh"] = { fileId: get_xc_uuid(), objectId: get_xc_uuid(), path: "#{@projName}.postbuild.sh" }	
	end

	def create_modulemap(projFiles)
		moduleMapPath = "./Code/module.modulemap"
		moduleMapContent = <<~EOF
		framework module #{@projName} [extern_c] {
			umbrella header "#{@projName}.h"
			module * { export * }
			export *
		}
		EOF
		File.write(moduleMapPath, moduleMapContent)
		projFiles["module.modulemap"] = { fileId: get_xc_uuid(), objectId: get_xc_uuid(), path: "module.modulemap" }
	end

end