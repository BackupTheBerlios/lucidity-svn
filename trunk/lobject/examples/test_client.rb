require 'rubygems'
require_gem 'lobject'
remote=LObject.new('test_app')
x=remote.getObject('x')
line=gets
x.print(line)
