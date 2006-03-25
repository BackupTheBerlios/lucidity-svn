require 'rubygems'
require_gem 'lclipboard'
puts "Please write some text to add to the clipboard. When done press enter"
str=gets
clip=LClipboard.new
clip.copy(str)
