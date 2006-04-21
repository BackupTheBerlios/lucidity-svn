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

class LColor
	attr_accessor :red, :green, :blue, :alpha
	def initialize(red=0, green=0,blue=0, alpha=1)
		begin
			@blue=red[2]
			@green=red[1]
			@red=red[0]
			@alpha=1
		end if (red.is_a?(Array) and red.length==3)
		begin	
			@red=red
			@green=green
			@blue=blue
			@alpha=alpha
		end if (!red.is_a?(Array))
	end

	Black	=[0,0,0]
	Silver	=[0.75,0.75,0.75]
	Gray	=[0.5,0.5,0.5]
	White	=[1,1,1]
	Maroon	=[0.5,0,0]
	Red	=[1,0,0]
	Purple	=[0.5,0,0.5]
	Fuchsia	=[1,0,1]
	Green	=[0,0.5,0]
	Lime	=[0,1,0]
	Olive	=[0.5,0.5,0]
	Yellow	=[1,1,0]
	Navy	=[0,0,0.5]
	Blue	=[0,0,1]
	Teal	=[0,0.5,0.5]
	Aqua	=[0,1,1]
end
