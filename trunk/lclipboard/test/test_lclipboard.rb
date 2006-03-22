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

require 'test/unit'
require 'lclipboard'

class TestLClipboard < Test::Unit::TestCase
	def testLClipboard_new 
		assert_nothing_raised {
			@clip=LClipboard.new
		}
	end

	def testLClipboard_copy
		@clip=LClipboard.new
		@clip.copy('test_value')
		assert_equal(@clip.items[@clip.items.length-1],'test_value')
	end

	def testLClipboard_paste
		@clip=LClipboard.new
		@clip.items[0]='test_value2'
		@clip.commit
		assert_equal(@clip.paste(0),'test_value2')
	end
	def testLClipboard_delete!
		@clip=LClipboard.new
		@clip.items[0]='test_value3'
		@clip.commit
		assert_nothing_raised { @clip.delete!(0) }
	end
	def testLClipboard_clear!
		@clip=LClipboard.new
		assert_nothing_raised { @clip.clear! }
		assert_equal(@clip.items.length,0)
	end
	def testLClipboard_each_length
		@clip=LClipboard.new
		@clip.clear!
		@clip.items << 1
		@clip.items << 2
		@clip.commit
		@i=0
		@clip.each { @i+=1 }
		assert_equal( @i,2)
		assert_equal( @clip.length,2)
	end
end
