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
require 'path'
require 'lrender.so'
class LRenderCurve < LRenderObject
	attr_reader :realDestX, :realDestY
	attr_writer :realDestX, :realDestY
	def initialize(firstX,firstY,secondX,secondY,destX,destY)
		super(destX,destY)
		@firstX=firstX
		@firstY=firstY
		@secondX=secondX
		@secondY=secondY
		@destX=destX
		@destY=destY
	end
	def render(cr,width,height)
		@realFirstX=@firstX*width
		@realFirstY=@firstY*height
		@realSecondX=@secondX*width
		@realSecondY=@secondY*height
		@realDestX=@destX*width
		@realDestY=@destY*height
		LRender.drawCurve(self,cr)
	end
end
