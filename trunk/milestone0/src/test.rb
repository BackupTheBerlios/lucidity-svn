require 'message'
require 'screen'
require 'lobject'
require 'lconf'
screen_name=ARGV[0]
scr=Screen.new
screens=LObject.new('milestone0/screens')
screens.registerWaitingObject(screen_name,scr)
