require './lclipboard.rb'
f=File.open('x.txt')
id = f.copy
puts id
puts LClipboard.paste(id)
LClipboard.delete!(id)
