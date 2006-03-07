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

# An option
class Option 
	attr_reader :name, :value
	# Create a new option, overwrites any existing option
	# Here's a small example. Remember the option is automatically
	# written there's no need to call write/close yourself
	#
	# require 'lconf'
	# cfg=Config.new('test')
	# opt=Option.new(cfg,'foo','some value here')
	def initialize(group,name,value=nil)
		@name=group.name + File::Separator + name
		@value = value
		self.write
	end
	# Opens an existing option file
	# Nothing evil should happen if it doesn't exist.
	# Also, unlike previous versions, the contents of the file
	# will not be blanked when opening it ( thus multiple objects,
	# from various processes can open the same option)
	# Any changes to the value will be written to the option file when the
	# program exits (even if it's a user break (^C))
	#
	# require 'lconf'
	# cfg=Config.new('test')
	# opt=Option.new('foo')
	# opt.value=5
	#
	# In the previous example the option is automatically saved, even
	# though opt.write was not explicitly called. If you this should be
	# controllable through some variable, write me an email and let
	# me know.
	def Option.open(group,name)
		@name=group.name + File::Separator + name
		@value=IO.readlines(@name)
		@value.each { |val|
			val.chomp!
		}
		opt=Option.new(group,name,@value)
		at_exit { 
			opt.write if Group.exist?(group)
		}
		return opt
	end
	# Save changes to an option. 
	# If the file allready exists it won't be overwritten until
	# you call this, or your program exits (when this is automatically 
	# called)
	# In the near future I plan to make this even more atomic, writing 
	# to a temporary file, deleting the existing file and then moving the
	# temporary file to where the current file is. But for now, this
	# will do.
	# Since options are automatically save this is usefull when you
	# want to save options while your application is still running.
	def write
		@f=File.open(@name,"w")
		if (@value != nil)
			@value.each { |val|
				@f.puts(val)
			}	
		end
		@f.close
	end
	# alias to write. should this exist? should it have another name?
	def close
		self.write
	end
	# Returns a truth value stating wether or not an option exists
	# in a certain group.
	# Look in group.rb for an example of how this works for a group
	# as this works in the same fashion
	def Option.exist?(parent,name)
		File.exist?(parent.name + File::Separator + name)
	end
	# Delete an option. For good. Forever ;)
	def delete!
		File.delete(@name)
	end
end
