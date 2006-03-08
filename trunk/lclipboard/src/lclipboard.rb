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
class LClipboard
	DefaultClipboard='clipboard'
	def initialize(name=DefaultClipboard)
		@cfg=Config.new(name)
	end
	def copy(object)
		begin 
			id=rand(999999)
			group_name='object'+id.to_s 
		end while Group.exist?(@cfg,group_name)
		grp=Group.new(@cfg,group_name)
		Option.new(grp,'content',object)
		return id
	end
	def paste(id)
		group_name='object'+id.to_s
		grp=Group.new(@cfg,group_name)
		raise "No such object in clipboard: #{id}" if (Group.exist?(@cfg,group_name)==false)
		Option.open(grp,'content').value
	end
	def delete!(id)
		group_name='object'+id.to_s
		grp=Group.new(@cfg,group_name)
		grp.delete!
	end
	def each
		@cfg.searchGroup(/object/) { |x|
			id=x.name.gsub(/.*object/,"").to_i
			yield id
		}
	end
	def clear!
		self.each { |i|
			delete!(i)
		}
	end
end
