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

require 'lconf'
# A group
class Group 
	attr_reader :name
	# Create a new group
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
	def searchGroup(pattern)
		if pattern.kind_of?(Regexp)
			#again, laziness is a key factor :) 
			`find #{@name} -type d`.each { |i|
				yield(Group.new(nil,i)) if i=~ pattern
			}
		end
	end	
	# Search for options within this group
	def searchOption(pattern)
		if pattern.kind_of?(Regexp)
			`find #{@name} -type f`.each { |i|
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
	def Group.exist?(parent,name)
		File.directory?(parent.name+ File::Separator + name)
	end
	#delete a group (recursively)
	def delete
		#Now why should I bother implementing this 
		raise "Error deleting #{@name}" unless Kernel.system("rm -rf #{name}")
	end	
end
