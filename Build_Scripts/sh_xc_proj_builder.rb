
require_relative 'xc_proj_builder'

class SHLibCXcodeProjBuilder < XcodeProjBuilder

	def create_configs(projFiles, configsList)
		fileName = "#{@projName}.base.xcconfig"
		baseConfigPath = "./Configs/#{fileName}"
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

		add_entry(projFiles, configsList, fileName, method(:transform_config_def))
	end

	def create_scripts(projFiles, scriptsList)
		create_prescript(projFiles, scriptsList)
		create_postscript(projFiles, scriptsList)
	end

	def create_prescript(projFiles, scriptsList)
		fileName = "#{@projName}.prebuild.sh"
		scriptPath = "./Scripts/#{fileName}"
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

		add_entry(projFiles, scriptsList, fileName, method(:transform_script_def))
	end

	def create_postscript(projFiles, scriptsList)
		fileName = "#{@projName}.postbuild.sh"
		scriptPath = "./Scripts/#{fileName}"
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
		
		add_entry(projFiles, scriptsList, fileName, method(:transform_script_def))
	end

end