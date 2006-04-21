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
require 'screen'
def test5(screen,region,txt)
	txt.text="Test 5. Lines"
	screen.draw
	sleep 2

	txt.text=""
	p=LRenderPath.new(0.4,0.4)
	region.objects << p

	l1=LRenderLine.new(0.4,0.6)
	p.stroke=LColor.new(LColor::Red)
	p.objects << l1
	screen.draw
	sleep 2

	l2=LRenderLine.new(0.6,0.6)
	p.stroke=LColor.new(LColor::Green)
	p.objects << l2
	screen.draw
	sleep 2

	l3=LRenderLine.new(0.6,0.4)
	p.stroke=LColor.new(LColor::Blue)
	p.objects << l3
	screen.draw
	sleep 2
	
	p.closed=true
	p.stroke=LColor.new(LColor::Black)
	p.stroke.alpha=0.25
	screen.draw
	sleep 2

	p.stroke=LColor.new(0.4,0.75,0.2)
	screen.draw
	sleep 2

	60.times { |i|
		p.lineWidth=i/2
		screen.draw
		sleep(0.05)
	}
	region.objects.pop
end
