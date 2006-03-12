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
class Screen 
	def displayErrorMessage(message)
		puts "ERROR: " + message
	end
	def displayMessage(user,line)
		line.strip!
		if line =~ /^\/quit/	
			msg=QuitMessage.new(user,line.gsub(/^\/quit/,"").strip!)
		elsif line =~ /^\/me/		
			msg=MeMessage.new(user,line.gsub(/^\/me/,"").strip!)
		elsif line =~ /^\/nick/
			msg=NickMessage.new(user,line.gsub(/^\/nick/,"").strip!)
		elsif line =~ /^\/join/
			msg=JoinMessage.new(user,"")
		elsif line =~ /^\/who/
			msg=WhoMessage.new(user,line.gsub(/^\/who/,"").strip!)
		elsif line =~ /^\/list/
			msg=ListMessage.new(user,line.gsub(/^\/list/,"").strip!)
		elsif line =~ /^\/clear/
			msg=ClearMessage.new(user,"")
		elsif line =~ /^\/copy_last/
			msg=CopyLastMessage.new(user,"")
		elsif line =~ /^\/copy/
			msg=CopyMessage.new(user,line.gsub(/^\/copy/,"").strip!)
		else
			msg=ChatMessage.new(user,line)
		end

		if msg.is_a?(ListMessage)
			msg.to_s.each { |l| puts l }
		else
			puts msg
		end
	end
end
