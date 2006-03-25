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
require 'lobject'
require 'lclipboard'
require 'milestone0/user'

# A client (present in the lower part of milestone 0)
class Client 
	#new instance of a client.
	def initialize(nick,myScreenName)
		@screens=LObject.new('milestone0/screens')
		@users=LObject.new('milestone0/users')

		@nick = nick
		@myScreen=@screens.getObject(myScreenName)

		@clip=LClipboard.new
		@tempClip=LClipboard.new('tempclip')

		@myUser='user'+rand(10000).to_s
		@users.registerObject(@myUser,User.new(@nick))
		@myUserObject=@users.getObject(@myUser)

		sleep(0.5)
		who
		begin
			puts "Lucidity Milestone 0. Local chat application"
			puts "User: #{@nick}@" + `hostname`
			line=$stdin.gets
			line.strip
			processLine(line)
		end while line !~ /^\/quit/ 
		Process.kill("SIGINT",Process.ppid)
	end

	#process a line and run certain actions.
	def processLine(line)
		if line=~ /^\/who/
			self.who
		elsif line =~ /^\/nick/ 
			self.changeNick(line.gsub(/^\/nick/,"").strip!)
		elsif line =~ /^\/list/
			self.list
		elsif line =~ /^\/copy\s/
			self.copy(line.gsub(/^\/copy\s/,"").strip!)	
		elsif line =~ /^\/copy_last/
			self.copyLast
		elsif line =~ /^\/clear/
			self.clear
		elsif line =~ /^\/paste/
			self.paste(line.gsub(/^\/paste/,"").strip!)
		else sendMessage(line)
		end
	end

	# display a line to the local screen only
	def localDisplay(line)
		@myScreen.displayMessage(@nick,line) 
	end

	# display a line to all users
	def globalDisplay(line)
		@screens.each { |obj| obj.displayMessage(@nick,line) }
	end

	# show who's online
	def who
		who_string="/who "
		@users.each { |user| 
			who_string = who_string + user.name + ' ' 
		}
		localDisplay(who_string)
	end

	# let other people know you've joined
	def join
		globalDisplay("/join")
	end

	#change your nickname
	def changeNick(newNick)
		globalDisplay("/nick " + newNick) 
		#--
		# there's a slight bug here. if something bad happens
		# the above line could be displayed without the nick 
		# actually being changed
		#
		# it can be changed but for now this works, and I've done it
		# like this to keep things simple.
		#
		#--
		# TODO: make sure a null nick is handled
		#	(here or in the client?)
		@nick=newNick
		@myUserObject.name=newNick
	end

	# list clipboard contents
	def list
		localDisplay("/list")
	end

	# copy text to the clipboard
	def copy(text)
		@clip.copy(text)
		globalDisplay("/copy " + text) if(text != nil)	
	end

	# clear clipboard contents
	def clear
		@clip.clear!
		globalDisplay("/clear")
	end

	# paste one of the items in the clipboard
	def paste(id)
		if id=="" 
			@myScreen.displayErrorMessage("Usage: paste <id>")
		else	
			num = id.to_i
			@tempClip.clear!
			sendMessage(@clip.paste(num))
		end
	end	

	# copy the last line to the clipboard
	def copyLast
		@clip.copy(@tempClip.paste(0)) if @tempClip.length==1
		globalDisplay("/copy_last")
	end

	# send a message to everyone (also copy it to the temp clipboard)
	# --
	# TODO: some things shouldn't get copied there (e.g.: /quit)
	def sendMessage(line)
		@tempClip.clear!
		@tempClip.copy(line)
		globalDisplay(line) 
	end
end

Client.new(ARGV[0],ARGV[1])
