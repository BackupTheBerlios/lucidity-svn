class Screen 
	def displayMessage(user,line)
		line.strip!
		if line =~ /^\/quit/	
			msg=QuitMessage.new(user,line.gsub(/^\/quit/,"").strip!)
		elsif line =~ /^\/me/		
			msg=MeMessage.new(user,line.gsub(/^\/me/,"").strip!)
		elsif line =~ /^\/nick/
			msg=NickMessage.new(user,line.gsub(/^\/nick/,"").strip!)
		elsif line =~ /^\/join/
			msg=JoinMessage.new(user,"")
		elsif line =~ /^\/who/
			msg=WhoMessage.new(user,line.gsub(/^\/who/,"").strip!)
		else
			msg=ChatMessage.new(user,line)
		end
		puts msg
	end
end
