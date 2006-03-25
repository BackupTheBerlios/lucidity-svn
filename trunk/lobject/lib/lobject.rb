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

require 'rubygems'
require 'drb'
require_gem 'lconf'

# An object container
class LObject
	DefaultLObjectPath="/tmp/lucidity"
	# Create a new group of LObjects
	#
	# Here's a simple example:
	#
	#  require 'rubygems'
	#  require_gem 'lobject'
	#  obj_server=LObject.new('my_program')
	#
	def initialize(application)
		@cfg=LConfig.new('lobject')
		begin
			@default_path=Option.open(@cfg,'default_path').value
		rescue
			@default_path=DefaultLObjectPath
		end
		Dir.mkdir(@default_path) unless File.directory?(@default_path)
		@path=@default_path+File::Separator+application
		Dir.mkdir(@path) unless File.directory?(@path)
		@threads=Hash.new
	end

	# Register an object. The process that gets created will not
	# wait indefinitely when creating such an object. You need to call
	# LObject#wait(name) for the application to hold indefinitely for
	# this object.
	#
	# Right now I'm not setting $SAFE to any value. This is because
	# the created socket belongs to whoever creates it
	# and no other user can write to it.
	#
	# Here's an example:
	#
	#  require 'rubygems'
	#  require_gem 'lobject'
	#  class TestObject
	#  	  def initialize
	#		  @name='foo'
	#  	  end
	#  end
	#
	#  container=LObject.new('test') 
	#  anObject=TestServer.new
	#  container.registerObject('anObject',anObject)
	#
	def registerObject(name,object)
		@threads[name] =  Thread.new {
			#--
			#@SAFE=2
			object_path='drbunix://'+@path+File::Separator+name
			DRb.start_service(object_path,object)
			DRb.thread.join
		}
	end

	# Wait for a certian object indefinitely
	# 
	# As an example, consider the LObject#registerObject example and
	# add this line:
	#
	#  container.wait('anObject')
	#
	def wait(name)
		@threads.each { |thr_name,thr| thr.join if thr_name==name}
	end
	# Get an object (by name)
	# 
	# Here's an example. This relies on the example from LObject#wait
	# allready running as a separate process
	#
	#  require 'rubygems'
	#  require_gem 'lobject'
	#  container=LObject.new('test')
	#  obj=container.getObject('anObject')
	def getObject(name)
		object_path='drbunix://'+@path+File::Separator+name
		obj = DRbObject.new(nil,object_path)
		return obj
	end

	# Yields each object an LObject has opened
	# 
	# Here's a fictional example. If you have various objects running
	# for various utilities that monitor system status, and each of these
	# has a printStatus method that displays their current status, you
	# can run that method on all these objects as easy as:
	#
	#  require 'rubygems'
	#  require_gem 'lobject'
	#  container=LObject.new('system_monitors')
	#  container.each { |c| c.printStatus }
	#
	def each
		`find #{@path} -type s 2>/dev/null`.each { |obj_path|
			obj_path.chomp!
			obj_path='drbunix://'+obj_path
			obj=DRbObject.new(nil,obj_path)
			yield obj
		}
	end
end
