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
require 'drb'

class LObject
	def initialize(application)
		@cfg=Config.new('lobject')
		@default_path=Option.open(@cfg,'default_path').value[0]
		Dir.mkdir(@default_path) unless File.directory?(@default_path)
		@path=@default_path+File::Separator+application
	end
	def registerObject(name,object)
		Dir.mkdir(@path) unless File.directory?(@path)
		object_path='drbunix://'+@path+File::Separator+name
		DRb.start_service(object_path,object)
		DRb.thread.join
	end
	def getObject(name)
		object_path='drbunix://'+@path+File::Separator+name
		obj = DRbObject.new(nil,object_path)
		return obj
	end
end
