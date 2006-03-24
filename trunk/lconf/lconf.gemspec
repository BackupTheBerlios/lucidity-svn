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

require 'rubygems'
SPEC = Gem::Specification.new do |s|
	s.name 		= "lconf"
	s.version 	= "0.0.2"
	s.author 	= "Eugen Minciu"
	s.email		= "minciue@gmail.com"
	s.homepage	= "http://lucidity.berlios.de"
	s.platform	= Gem::Platform::RUBY
	s.summary	= "Lucidity configuration storage library"
	candidates 	= Dir.glob("{docs,lib,tests}/**/*")
	s.files		= candidates.delete_if do |item|
				item.include?("svn")
			end
	s.require_path 	= "lib"
	s.autorequire	= "lconf"
	s.test_file	= "test/test_lconf.rb"
	s.has_rdoc	= true
end
