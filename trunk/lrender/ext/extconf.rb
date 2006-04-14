require 'mkmf'
have_library("SDL")
$CFLAGS=$CFLAGS+' '+`pkg-config --cflags cairo`
$LDFLAGS=$LDFLAGS+' '+`pkg-config --libs cairo`
create_makefile("lrender")
