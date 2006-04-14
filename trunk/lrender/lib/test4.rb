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
def test4(screen,txt)
	txt.text="Test 4. Fonts"
	screen.draw
	sleep 2
	oldfont=txt.font.dup
	oldsize=txt.size
	txt.size=0.1
	txt.text="URW Palladio L"
	txt.font="URW Palladio L"
	screen.draw
	sleep 2

	txt.text="Bitstream Vera Sans"
	txt.font="Bitstream Vera Sans"
	screen.draw
	sleep 2

	txt.text="Nimbus Sans L"
	txt.font="Nimbus Sans L"
	screen.draw
	sleep 2

	txt.text="Nimbus Roman No9 L"
	txt.font="Nimbus Roman No9 L"
	screen.draw
	sleep 2

	txt.text="Century Schoolbook L"
	txt.font="Century Schoolbook L"
	screen.draw
	sleep 2

	txt.text="東風明朝"
	txt.font="Kochi Mincho"
	screen.draw
	sleep 2

	txt.font="FreeSerif"

	txt.text="Bold text"
	txt.bold=true
	screen.draw
	sleep 2
	txt.bold=false

	txt.text="Italic text"
	txt.italic=true
	screen.draw
	sleep 2
	txt.italic=false
	txt.font=oldfont
	txt.size=oldsize
end
