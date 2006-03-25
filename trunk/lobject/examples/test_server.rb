require 'rubygems'
require_gem 'lobject'
class TestServer
	def print(message)
		puts message 
	end
end
x=TestServer.new
app=LObject.new('test_app')
app.registerObject('x',x)
