require 'rubygems'
require_gem 'lclipboard'
clip=LClipboard.new
puts clip.length
clip.each { |x| 
	print x, ": ", clip.paste(x) ,"\n"
}
