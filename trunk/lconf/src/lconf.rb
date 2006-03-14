#
# Copyright (C) 2006 Eugen Minciu
#
# This file is part of Lucidity.
#
# Lucidity is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# Lucidity is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with Lucidity; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'lconf/option.rb'
require 'lconf/group.rb'
# A config
class Config < Group

	GlobalLConfPath='/etc/lucidity'
	LocalLConfPath=File.expand_path('~/.lucidity')
	# Create a new config. 
	#
	# 1. Attempt to find a path from the LCONF_PATH environment variable
	# 2. Try a per-user path (default: ~/.lucidity).
	# 3. Try a global path (default: /etc/lucidity). 
	#
	# If each of the directories is not found, lucidity tries to create it. 
	#
	# If we don't have a directory to work with an exception is raised
	# 
	# Here's a simple example:
	#
	#  cfg=Config.new('test_config')
	def initialize(name)
		path=ENV['LCONF_PATH']
		path=Config::LocalLConfPath if path==nil
		begin
			Dir.mkdir(path) unless File.directory?(path) 
		rescue
			path=Config::GlobalLConfPath 
		end
		Dir.mkdir(path) unless File.directory?(path)
		@name = path+File::Separator+name
		@parent = nil
		Dir.mkdir(@name) unless File.exist?(@name) 
	end
end
