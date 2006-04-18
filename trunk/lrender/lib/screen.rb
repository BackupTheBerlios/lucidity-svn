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
require 'virtualscreen'
require 'region'
require 'text'
require 'lrender.so'

class LRenderScreen
	attr_reader :width, :height, :regions, :virtualScreens, :antiAlias, :defaultScreen
	attr_writer :regions, :virtualScreens, :antiAlias, :defaultScreen
	def initialize(width,height)
		@width=width
		@height=height
		@virtualScreens=[]
		@defaultScreen=nil
		@display=LRender.openDisplay()
		@screen=LRender.createScreen(@display, @width,@height)
	end
	def draw
		LRender.paintScreen(@display,@screen)
		@defaultScreen.draw(@display,@screen)
		LRender.updateScreen(@display)
	end
end
