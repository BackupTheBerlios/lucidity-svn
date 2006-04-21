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
def test6(screen,region,txt)
	txt.text="Test 6. Curves"
	screen.draw
	sleep 2

	txt.text=""
	p=LRenderPath.new(0.1,0.1)
	region.objects << p

	l1=LRenderCurve.new(0.2,0.1,0.3,0.4,0.5,0.4)
	p.stroke=LColor.new(LColor::Red)
	p.objects << l1
	screen.draw
	sleep 2

	
	p.closed=true
	p.filled=true
	screen.draw
	sleep 2

	region.objects.pop
end
