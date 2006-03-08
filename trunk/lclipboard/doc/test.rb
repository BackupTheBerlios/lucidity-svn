require 'lclipboard'
str="Some String"
clip=LClipboard.new
clip.copy(str)
clip.each { |x| 
	print x, ": ", clip.paste(x) ,"\n"
}
