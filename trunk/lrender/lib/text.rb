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
require 'object'
require 'lrender.so'
class LRenderText < LRenderObject
	attr_reader :text, :size, :font, :bold, :italic, :oblique
	attr_writer :text, :size, :font, :bold
	def initialize(x,y,text)
		super(x,y)
		@text=text
		@size=0.5
		@font='Sans'
		@bold=false
		@italic=false
		@oblique=false
	end
	def render(region,cr,screen)
		super(region,screen)
		@realSize=@size*@height
		LRender.setCairoContext(cr,self)
		LRender.drawText(self,cr)
	end
	def italic=(value)
		begin
			@italic=true
			@oblique=false 
		end if value==true
		@italic=false if value==false
	end
	def oblique=(value)
		begin 
			@oblique=true
			@italic=false
		end if value==true
		@oblique=false if value==false
	end
end
