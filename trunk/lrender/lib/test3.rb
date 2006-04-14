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
def test3(screen,txt)
	txt.text="Test 3. Scrolls"
	screen.draw
	sleep 2

	txt.text="Scroll down"
	100.times {
		txt.y=txt.y+0.005
		screen.draw
		sleep(0.015)
	}

	txt.text="Scroll right"
	100.times {
		txt.x=txt.x+0.005
		screen.draw
		sleep(0.015)
	}

	txt.text="Scroll up"
	100.times {
		txt.y=txt.y-0.005
		screen.draw
		sleep(0.015)
	}

	txt.text="Scroll left"
	100.times {
		txt.x=txt.x-0.005
		screen.draw
		sleep(0.015)
	}
end
