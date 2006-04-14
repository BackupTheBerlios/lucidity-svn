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
#include "include/finalizePath.h"

static VALUE finalizePath(VALUE self, VALUE cr_object, VALUE path_object)
{
	cairo_t *cr=(cairo_t *) cr_object;
	VALUE close_path=rb_iv_get(path_object,"@closed");
	VALUE fill_path=rb_iv_get(path_object,"@filled");

	VALUE fillRed_object=rb_iv_get(path_object,"@fillRed");
	VALUE fillGreen_object=rb_iv_get(path_object,"@fillGreen");
	VALUE fillBlue_object=rb_iv_get(path_object,"@fillBlue");
	VALUE fillAlpha_object=rb_iv_get(path_object,"@fillAlpha");

	double fillRed=NUM2DBL(fillRed_object);
	double fillGreen=NUM2DBL(fillGreen_object);
	double fillBlue=NUM2DBL(fillBlue_object);
	double fillAlpha=NUM2DBL(fillAlpha_object);

	if (close_path==Qtrue) cairo_close_path(cr);
	if (fill_path==Qtrue) {
		cairo_stroke_preserve(cr);
		cairo_set_source_rgba(cr,fillRed,fillGreen,fillBlue,fillAlpha);
		cairo_fill(cr);
	}
	else {
		cairo_stroke(cr);
	}
	cairo_restore(cr);
	return Qnil;
}

void Init_lrenderFinalizePath()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"finalizePath",finalizePath,2);
}
