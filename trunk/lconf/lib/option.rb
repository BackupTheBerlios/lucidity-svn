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
require 'yaml'
require 'group'
class Option 
	attr_reader :name, :value
	attr_writer :value
	# Create a new option, overwrites any existing option
	#
	# Here's a small example. Remember the option is automatically
	# written there's no need to call write/close yourself
	#
	#  require 'lconf'
	#  cfg=LConfig.new('test')
	#  opt=Option.new(cfg,'foo','some value here')
	#
	# keep in mind that you can store all kinds of objects and 
	# that their structure will be preserved.
	#
	# For example:
	#  require 'rubygems'
	#  require_gem 'lconf'
	#  class TestObject
	#  	  def initialize
	#	  	  @value='foo'
	#		  @value2='bar'
	#	  end
	#  end
	#  t1=TestObject.new
	#  cfg=LConfig.new('test')
	#  opt=Option.new(cfg,'foo',t1)
	#
	#  opt2=Option.open(cfg,'test')
	#  puts opt2.value
	#  puts opt2.value2
	def initialize(group,name,value)
		@name=group.name + File::Separator + name + '.yaml'
		@value=value
		self.write
	end

	# Opens an existing option file
	#
	# Nothing evil should happen if it doesn't exist.
	#
	# Any changes to the value will be written to the option file when the
	# program exits (even if it's a user break (^C))
	#
	#  require 'rubygems'
	#  require_gem 'lconf'
	#  cfg=LConfig.new('test')
	#  opt=Option.open('foo')
	#  opt.value=5
	#
	# In the previous example the option is automatically saved, even
	# though opt.write was not explicitly called. If you think this 
	# behaviour should be  controllable through some variable, 
	# write me an email and let me know.
	def Option.open(group,name)
		@name=group.name + File::Separator + name + '.yaml'
		
		@value=YAML.load(File.open(@name))
		@option=Option.new(group,name,@value)
		at_exit { 
			@option.write if Group.exist?(group)
		}
		return @option
	end

	# Save changes to an option. 
	#
	# If the file allready exists it won't be overwritten until
	# you call this, or your program exits (when this is automatically 
	# called)
	#
	# In the near future I plan to make this even more atomic, writing 
	# to a temporary file, deleting the existing file and then moving the
	# temporary file to where the current file is. But for now, this
	# will do.
	#
	# Since options are automatically saved this is useful when you
	# want to save options while your application is still running.
	def write
		File.open(@name,"w") { |f| YAML.dump(@value,f) }
	end
	# Returns a truth value stating wether or not an option exists
	# in a certain group.
	#
	# Look in group.rb for an example of how this works for a group
	# as this works in the same fashion
	def Option.exist?(parent,name)
		File.exist?(parent.name + File::Separator + name + '.yaml')
	end
	# Delete an option. For good. Forever. Yes, really ;)
	def delete!
		File.delete(@name)
	end
end
