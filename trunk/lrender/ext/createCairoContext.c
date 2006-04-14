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
#include <SDL/SDL.h>

#include "lrender.h"
#include "include/createCairoContext.h"

static VALUE createCairoContext(VALUE self, VALUE raw_surface,VALUE width_object, VALUE height_object)
{
	int width=NUM2INT(width_object);
	int height=NUM2INT(height_object);
	
	int stride=width*4;
	cairo_surface_t *surface = cairo_image_surface_create_for_data(
			(unsigned char *) raw_surface,
			CAIRO_FORMAT_ARGB32,
			width,
			height,
			stride);
	cairo_t *cr=cairo_create(surface);
	return (VALUE) cr;
}

void Init_lrenderCreateCairoContext()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"createCairoContext",createCairoContext,3);
}
