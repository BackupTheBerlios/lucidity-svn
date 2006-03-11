require 'lconf'
cfg=Config.new('milestone0')
puts "Welcome to Lucidity Milestone 0"
puts ""
puts "The first milestone of Lucidity features a local chat application."
puts "This is one instance of this application. It is actually composed of"
puts "two applications, split using the utiliity splitvt"
puts ""
puts "The application in the lower part of the window sends a message."
puts "Then, for each connected window you receive that message, along with"
puts "the user it originated from."
puts ""
puts "Please do not ask me to extend this application in any way."
puts "It's just a testbed for Lucidity's modules."
puts ""
print "Please enter your desired name:"	
name=gets
name.chomp!
screen_name='screen'+rand(10000).to_s
Kernel.exec('splitvt -bottom -s 20 -upper "ruby test.rb '+screen_name+'" -lower "ruby  -- client.rb  ' + name + ' ' + screen_name + '"')
