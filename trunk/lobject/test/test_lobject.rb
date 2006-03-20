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
require 'lobject'

class TestLObject < Test::Unit::TestCase
	def testLObject_new
		assert_nothing_raised{ obj_server=LObject.new('my_program') }
	end
	def testLObject_register_get
		container = LObject.new('test')
		container.registerObject('test_object',10)
		assert_equal(container.getObject('test_object').to_i,10)
	end
	def testLObject_each
		container = LObject.new('test')
		container.registerObject('obj1',1)
		container.registerObject('obj2',2)
		sum=0
		container.each { |x| sum+=x.to_i }
		assert_equal(sum,3)
	end
end
