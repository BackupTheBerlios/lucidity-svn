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

require 'lclipboard'
# a chat message
class ChatMessage
	def initialize(user,message)
		@user, @message = user, message
	end
	def to_s
		"<#{@user}>: #{@message}"
	end
end

# a quit message
class QuitMessage < ChatMessage
	def to_s
		"<<< Quits: #{@user} [#{@message}]"
	end
end

# a /me message
class MeMessage < ChatMessage
	def to_s
		"* #{@user} #{@message}"
	end
end

# a /nick message
class NickMessage < ChatMessage
	def to_s
		"- #{@user} is now known as #{@message}"
	end
end

# a /join message
class JoinMessage < ChatMessage
	def to_s
		">>> Joins #{@user}"
	end
end

# a /who message
class WhoMessage < ChatMessage
	def to_s
		"* Existing users: #{@message}"
	end
end

# a /list message
class ListMessage < ChatMessage
	def to_s
		clip=LClipboard.new
		str=Array.new
		tmp = 'Number of elements in clipboard: ' + clip.length.to_s
		str << tmp
		str << '---'
		i=0
		clip.each { |node| 
			tmp = i.to_s + ': ' + clip.paste(node) 
			str << tmp
			i+=1
		}
		str
	end
end	

# a /clear message
class ClearMessage < ChatMessage
	def to_s
		"!!! #{@user} cleared the clipboard"
	end
end

# a /copy_last message
class CopyLastMessage < ChatMessage
	def to_s
		"+ #{@user} copied the last message to the clipboard."
	end
end

#a /copy message
class CopyMessage < ChatMessage
	def to_s
		"+ #{@user} copied '#{@message}' to the clipboard."
	end
end
