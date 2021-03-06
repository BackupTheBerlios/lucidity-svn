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
#include "include/createCairoContext.h"

static VALUE createCairoContext(VALUE self, VALUE display, VALUE screen, VALUE width_object, VALUE height_object)
{
	int width=NUM2INT(width_object);
	int height=NUM2INT(height_object);
	
	Display *dpy=(Display *) display;
	cairo_surface_t *surface = cairo_xlib_surface_create(
			(Display *) display,
			(Window) NUM2ULONG(screen),
	                DefaultVisual(dpy,DefaultScreen(dpy)),
			width,
			height);
	cairo_t *cr=cairo_create(surface);

	XFlush(dpy);


	return (VALUE) cr;
}

void Init_createCairoContext()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"createCairoContext",createCairoContext,4);
}
