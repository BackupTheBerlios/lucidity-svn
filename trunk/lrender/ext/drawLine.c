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
#include "include/drawLine.h"

static VALUE drawLine(VALUE self,VALUE line,VALUE cr_object)
{
	VALUE destX_object=rb_iv_get(line,"@realDestX");
	VALUE destY_object=rb_iv_get(line,"@realDestY");

	cairo_t *cr=(cairo_t *) cr_object;

	int destX=NUM2DBL(destX_object);
	int destY=NUM2DBL(destY_object);

	cairo_line_to(cr,destX,destY);
	return Qnil;
}

void Init_drawLine()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"drawLine",drawLine,2);
}
