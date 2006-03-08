require 'lclipboard'
clip=LClipboard.new
clip.each { |x| 
	print x, ": ", clip.paste(x) ,"\n"
}
