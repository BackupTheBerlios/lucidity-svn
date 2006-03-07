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
module LClipboard
	def copy
		cfg=Config.new('lclipboard')
		begin 
			@id=rand(999999)
			group_name='object'+@id.to_s 
		end while Group.exist?(cfg,group_name)
		grp=Group.new(cfg,group_name)
		Option.new(grp,'content',self)
		#puts @id
		return @id
	end
	def LClipboard.paste(id)
		cfg=Config.new('lclipboard')
		group_name='object'+id.to_s
		grp=Group.new(cfg,group_name)
		raise "No such object in clipboard: #{id}" if (Group.exist?(cfg,group_name)==false)
		Option.open(grp,'content').value
	end
	def LClipboard.delete!(id)
		cfg=Config.new('lclipboard')
		group_name='object'+id.to_s
		grp=Group.new(cfg,group_name)
		grp.delete!
	end
end

class String
	include LClipboard
end

class Numeric
	include LClipboard
end

class File
	include LClipboard
end

class IO
	include LClipboard
end

class Process
	include LClipboard
end

class Array
	include LClipboard
end
