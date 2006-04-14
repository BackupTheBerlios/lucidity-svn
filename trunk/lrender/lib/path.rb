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
class LRenderPath < LRenderObject
	LineCap=Class.new
	LineCap::Butt=0
	LineCap::Round=1
	LineCap::Square=2

	FillRule=Class.new
	FillRule::Winding=0
	FillRule::EvenOdd=1

	LineJoin=Class.new
	LineJoin::Miter=0
	LineJoin::Round=1
	LineJoin::Bevel=2
	attr_reader :lineCap, :lineJoin, :fillRule, :objects, :lineWidth, :closed, :filled, :fillRed, :fillBlue, :fillGreen, :fillAlpha
	attr_writer :lineCap, :lineJoin, :fillRule, :objects, :lineWidth, :closed, :filled, :fillRed, :fillBlue, :fillGreen, :fillAlpha

	def initialize(x,y)
		super(x,y)
		@lineCap=LRenderPath::LineCap::Butt
		@lineJoin=LRenderPath::LineJoin::Miter
		@fillRule=LRenderPath::FillRule::Winding
		@objects=[]
		@lineWidth=5
		@closed=false
		@filled=false

		@fillRed=0
		@fillGreen=0
		@fillBlue=0
		@fillAlpha=1
	end

	def render(raw_surface,region,cr,screen)
		super(raw_surface,region,cr,screen)
		LRender.setCairoContext(cr,self)
		LRender.setPathOptions(cr,self)
		@objects.each { |obj|
			obj.render(cr,@width,@height)
		}
		LRender.finalizePath(cr,self)
		LRender.updateSDLSurface(screen,@width,@height,raw_surface)
	end
end
