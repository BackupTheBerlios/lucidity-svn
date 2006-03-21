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

require 'lconf'
# A clipboard.
# 
# The really cool thing about this clipboard is that it allows you to access
# the clipboard items as an array of items as simple as 
#
#  clip.items
# 
# Where clip is a regular clipboard
#
# All operations in this API are implemented in this fashion and I encourage
# you to tell me if you think such functions should be removed.
#
# Right now they are useful because they implemented the require 
# reload and commit operations themselves
#
# Just remember these 2 things if you manually use items:
# 1. Before any sort of operation you must call LClipboard#reload
# 2. After any operation that writes you must  call LClipboard#commit
class LClipboard
	attr_writer :items 
	DefaultClipboard='clipboard'
	DefaultLocation='lclipboard'

	# reload items from a clipboard.
	# This allows one program to see another program's modifications
	# to the clipboard items
	def reload
		@opt=Option.open(@cfg,@name)
		@items=@opt.value
	end

	# commit changes to a clipboard
	# This enables other functions to imediately see modifications to
	# the clipboard
	def commit
		@opt.write
	end

	# Create a new clipboard or open an existing clipboard
	#
	# If no name is given it defaults to DefaultClipboard 
	#
	# This means one application can have more then one clipboard
	# (a local clipboard and a global clipboard, for example).
	#
	# The clipboard is persistent. Its contents are preserved
	# even after a reboot.
	#
	# A clipboard can hold as many items (objects) as you wish.
	#
	# Here's an example
	#
	#  require 'lclipboard'
	#  clip=LClipboard.new('test')
	#  clip2=LClipboard.new
	def initialize(name=DefaultClipboard)
		@name=name
		@cfg=LocalConfig.new(DefaultLocation)
		if Option.exist?(@cfg,name)
			reload
		else 
			@items=[]
			@opt=Option.new(@cfg,name,@items)
		end
	end
	
	# Copy an object to the current clipboard.
	#
	# Uses LConf (which uses YAML) so complex objects can be stored.
	#
	# Here's an example:
	#
	#  require 'lclipboard'
	#  clip=LClipboard.new
	#  clip.copy('whatever')
	#
	# The object 'whatever' is now in the clipboard.
	#
	def copy(object)
		reload
		@items << object
		#--
		# multiple processes using the same clipboard
		# require changes to be imediately written.
		commit
	end

	# Paste an object from the clipboard. 
	# (you get the id of an object either when calling LClipboard#copy
	# or LClipboard#each)
	#
	# Here's a small example:
	#
	#  require 'lclipboard'
	#  clip=LClipboard.new
	#  id=clip.copy('whatever')
	#  puts clip.paste(id)
	def paste(id)
		reload
		@items[id]
	end

	# Delete an object from the clipboard.
	#
	# At this point, deleting an object won't shift the following object's
	# id's. 
	#
	# Don't rely on ids being ordered as some could always be miising
	#
	# Just substitute 
	#  puts clip.paste(id)
	# with
	#  clip.delete(id)
	#
	# in the LClipboard#paste example and you'll be deleting 
	# the item instead of printing it.
	def delete!(id)
		reload
		@items.delete_at(id)
		@opt.write
	end

	# Iterate through each object in the clipboard and yield each one.
	#
	# Here's an example
	#
	#  require 'lclipboard'
	#  clip=LClipboard.new
	#  clip.each
	def each
		reload
		0.upto(self.length-1) { |i| yield i }
	end

	# Returns the number of times in the clipboard.
	# (0 for an empty clipboard, so there should be no problem).
	#
	#  require 'lclipboard'
	#  clip=LClipboard.new
	#  puts clip.length
	def length
		reload
		return @items.length
	end

	# Clear the clipboard, removes all clipboard items
	# 
	# Here's a reduced example:
	#
	#  require 'lclipboard'
	#  LClipboard.new.clear!
	def clear!
		reload
		@items.clear
		commit
	end
end
