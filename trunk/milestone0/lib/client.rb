require 'lobject'
require 'user.rb'
# Create/Open placeholders for screens and users
screens=LObject.new('milestone0/screens')
users=LObject.new('milestone0/users')

# Set up some variables based on command-line options
name,myscreen = ARGV

#run a /who query upon entry, to show who else is online.
who_string="/who "
users.each { |user| who_string = who_string + user.getValue + ' ' }
#sleep a little
sleep(0.5)
screens.getObject(myscreen).displayMessage(name,who_string)

#join the chat and register
line="/join"
screens.each { |obj| obj.displayMessage(name,line) }

myUser='user'+rand(10000).to_s
users.registerObject(myUser,User.new(name))
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
		name=line.gsub(/^\/nick/,"").strip
		users.registerObject(myUser,User.new(name))
		screens.each { |obj| obj.displayMessage(old_name,line) }
	# or if we're running a /who query
	elsif line =~ /^\/who/
		who_string="/who "
		users.each { |user| who_string = who_string + user.getValue + ' ' }
		screens.getObject(myscreen).displayMessage(name,who_string)
	# if none of the above, just show everybody the message you just typed
	else
		screens.each { |obj| obj.displayMessage(name,line) }
	end
end while line !~ /^\/quit/
#after quit, kill the parrent process, this obviously needs to change.
Process.kill("SIGINT",Process.ppid)
