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
require 'lrender'
class LRenderObject
	AntiAlias=Class.new
	AntiAlias::Default=0	
	AntiAlias::None=1
	AntiAlias::Gray=2
	AntiAlias::Subpixel=3
	attr_accessor :x, :y, :fill, :stroke
	def initialize(x,y)
		@x=x
		@y=y
		@stroke=LColor.new(LColor::Black)
		@fill=LColor.new(LColor::Black)	
		@pattern=nil
	end
	def render(region,screen)
		@antiAlias=screen.antiAlias unless @antiAlias
                @width=screen.width * region.width
                @height=screen.height * region.height
                @realX=@width*@x
                @realY=@height*@y
	end
end
