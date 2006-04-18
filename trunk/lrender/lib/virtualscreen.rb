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
require 'region'
require 'screen'
require 'text'
require 'line'
require 'lrender.so'

class LRenderVirtualScreen
	attr_reader :screen, :width, :height, :regions, :antiAlias
	attr_writer :regions, :antiAlias
	def initialize(width,height)
		@width=width
		@height=height
		@regions=[]
		@antiAlias=LRenderObject::AntiAlias::Subpixel
	end
	def draw(display,screen)
		GC.disable
		@regions.each { |r|
			@realWidth=(@width)*(r.width)
		        @realHeight=(@height)*(r.height)
			@cr=LRender.createCairoContext(display,screen,@realWidth,@realHeight) 
			r.objects.each { |o|
				begin
					o.render(r,@cr,self) 
				end 
			} 
		}
		GC.enable
	end
end
