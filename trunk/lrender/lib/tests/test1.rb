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
def test1(screen,txt)
	txt.text="Test 1. Transparency fading"
	screen.draw
	sleep 2

	txt.text="Transparency fading from black"
	100.times { 
		txt.stroke.alpha-=0.01
		screen.draw
		sleep(0.015)
	}

	txt.text="Transparency fading from red"
	txt.stroke=LColor.new(LColor::Red)
	screen.draw
	100.times { 
		txt.stroke.alpha-=0.01
		screen.draw
		sleep(0.015)
	}

	txt.text="Transparency fading from green"
	txt.stroke=LColor.new(LColor::Green)
	screen.draw
	100.times { 
		txt.stroke.alpha-0.01
		screen.draw
		sleep(0.015)
	}

	txt.text="Transparency fading from blue"
	txt.stroke=LColor.new(LColor::Blue)
	screen.draw
	100.times { 
		txt.stroke.alpha-=0.01
		screen.draw
		sleep(0.015)
	}
end
