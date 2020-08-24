#!/usr/bin/env ruby

require_relative 'sh_xc_proj_builder'

builder = SHLibCXcodeProjBuilder.new('libxml2', ARGV[0].split(','), 
	ARGV[1].split(','), 
	ARGV[2])
builder.full_setup