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

# Create/Open placeholders for screens and users
screens=LObject.new('milestone0/screens')
users=LObject.new('milestone0/users')

def run_who(name,users,myScreen)
	who_string="/who "
	users.each { |user| who_string = who_string + user.getName + ' ' }
	myScreen.displayMessage(name,who_string)
end

# Set up some variables based on command-line options
name,myScreenName = ARGV
myScreen=screens.getObject(myScreenName)

clip=LClipboard.new
tempClip=LClipboard.new('tempclip')

#sleep a little
sleep(0.5)
#run a /who query upon entry, to show who else is online.
run_who(name,users,myScreen)

#join the chat and register
screens.each { |obj| obj.displayMessage(name,"/join") }

myUser='user'+rand(10000).to_s
users.registerObject(myUser,User.new(name))
myUserObject=users.getObject(myUser)
# while we've not quit
begin 
	# write the according text and read a line.
	puts "Lucidity Milestone 0. Local chat application"
	puts "User: #{name}@" + `hostname`
	line=$stdin.gets
	line.strip

	# take special action if we've changed nick.
	if line =~ /^\/nick/
		old_name=name.dup
		name=line.gsub(/^\/nick/,"").strip!
		myUserObject.setName(name)
		screens.each { |obj| obj.displayMessage(old_name,line) }
	# or if we're running a /who query
	elsif line =~ /^\/who/
		run_who(name,users,myScreen)
	# if none of the above, just show everybody the message you just typed
	elsif line =~ /^\/list/
		myScreen.displayMessage(name,line) 
	elsif line =~ /^\/copy_last/
		clip.copy(tempClip.paste(0)) if tempClip.length==1
		screens.each { |obj| obj.displayMessage(name,line) }
	elsif line =~ /^\/copy/
		text=line.gsub(/^\/copy/,"").strip
		clip.copy(text)
		screens.each { |obj| obj.displayMessage(name,line) }
	elsif line =~ /^\/paste/
		num=line.gsub(/^\/paste/,"").strip
		if num=="" 
			myScreen.displayErrorMessage("Usage: paste <id>")
		else	
			num = num.to_i
			tempClip.clear!
			tempClip.copy(clip.paste(num))
			screens.each { |obj| obj.displayMessage(name,clip.paste(num)) }
		end
	else
		tempClip.clear!
		tempClip.copy(line)
		screens.each { |obj| obj.displayMessage(name,line) }
	end
end while line !~ /^\/quit/
#after quit, kill the parrent process, this obviously needs to change.
Process.kill("SIGINT",Process.ppid)
