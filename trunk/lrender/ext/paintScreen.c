/*
 * Copyright (C) 2006 Eugen Minciu
 *
 * This file is part of Lucidity.
 *
 * Lucidity is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * Lucidity is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Lucidity; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#include <ruby.h>
#include <cairo.h>
#include <cairo-xlib.h>

#include "lrender.h"
#include "include/paintScreen.h"

static VALUE paintScreen(VALUE self, VALUE display, VALUE screen)
{
	Window w=(Window ) NUM2ULONG(screen);
	Display *dpy=(Display *) display;
	XClearWindow(dpy,w);
	return Qnil;
}
void Init_paintScreen()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"paintScreen",paintScreen,2);
}
