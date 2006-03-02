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
	def initialize(group,name,value=nil)
		@name=group.name + File::Separator + name
		@f=File.open(@name,"w")
		@value = value
	end
	# Opens an existing option file
	# Nothing evil should happen if it doesn't exist
	def Option.open(group,name)
		@name=group.name + File::Separator + name
		@value=IO.readlines(@name)
		opt=Option.new(group,name,@value)
		return opt
	end
	# Save changes to an option. 
	# If the file allready exists it won't be overwritten until
	# you call this
	def write
		if (@value != nil)
			@value.each { |val|
				@f.puts(val)
			}	
		end
		@f.close
	end
	# An alias to write
	def close
		self.write
	end
	# Delete an option
	def delete
		File.delete(@name)
	end
end
