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
# A group
require 'option'
class Group 
	attr_reader :name
	# Create a new group
	#
	# The following example creates a group within a config:
	#
	#  require 'rubygems'
	#  require_gem 'lconf'
	#  cfg=LConfig.new('test')
	#  grp=Group.new(cfg,'test2')
	def initialize(parent, name)
		if (parent == nil)
			@name = name
		end
		if (parent.kind_of?(Group)) 
			@name = parent.name + File::Separator + name 
		end
		Dir.mkdir(@name) unless File.directory?(@name)
	end

	# Search for groups within this group
	#
	# Each of the results are yielded to the caller.
	#
	# Here's an example that prints the names of all groups
	# matching a certain pattern. Because LConfig inherits this method
	# you can search within a config as well, as in the next example:
	#
	#  require 'rubygems'
	#  require_gem 'lconf'
	#  cfg=LConfig.new('existing_config')
	#  cfg.searchGroup(/foo/) { |grp| puts grp.name }
	def searchGroup(pattern)
		if pattern.kind_of?(Regexp)
			#--
			#again, laziness is a key factor :) 
			`find #{@name}/* -type d 2>/dev/null`.each { |i|
				i.chomp!
				yield(Group.new(nil,i)) if i=~ pattern
			}
		end
	end	

	# Search for options within this group
	#
	# Searching for an option is exactly like searching for a group,
	# both operations can be performed on a group or on a config as well
	def searchOption(pattern)
		if pattern.kind_of?(Regexp)
			`find #{@name} -type f 2>/dev/null`.each { |i|
				i.chomp!
				if i=~pattern
					tmp=Group.new(nil,File.dirname(i))
					opt=Option.open(tmp,File.basename(i))
					opt.close
					yield(opt)
				end
			}
		end
	end

	# does the group with a certain name exist within the specified
	# parent group?
	#
	# Here's a small example that checks if the 'example' group exists
	# within the config 'test' and prints the returned value:
	#
	#  require 'rubygems'
	#  require_gem 'lconf'
	#  cfg = LConfig.new('test')
	#  puts Group.exist?(cfg,'example')
	#
	# This also works for an allready existing group
	# (for example to see that another process hasn't deleted it)
	def Group.exist?(parent,name=nil)
		return File.directory?(parent.name+ File::Separator + name) if (name != nil)
		return File.directory?(parent.name) if (name == nil)
	end

	# delete a group (recursively). At some later point a less dangerous
	# form will be implemented that only deletes the directory
	# Here's an example
	#
	#  require 'rubygems'
	#  require_gem 'lconf'
	#  cfg = LConfig.new('test')
	#  grp = Group.new('test')
	#  grp.delete!
	def delete!
		#--
		#Now why should I bother implementing this 
		raise "Error deleting #{@name}" unless Kernel.system("rm -rf #{name}")
	end	
end
