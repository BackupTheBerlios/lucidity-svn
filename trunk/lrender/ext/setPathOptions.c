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
#include "include/setPathOptions.h"

static VALUE setPathOptions(VALUE self, VALUE cr_object, VALUE path_object)
{
        cairo_t *cr=(cairo_t *) cr_object;
	VALUE cap_object=rb_iv_get(path_object,"@lineCap");
	VALUE join_object=rb_iv_get(path_object,"@lineJoin");
	VALUE fillRule_object=rb_iv_get(path_object,"@fillRule");
	VALUE width_object=rb_iv_get(path_object,"@lineWidth");
	VALUE dash_object=rb_iv_get(path_object,"@dash");

        int cap=NUM2INT(cap_object);
	int join=NUM2INT(join_object);
	int fillRule=NUM2INT(fillRule_object);
	double width=NUM2DBL(width_object);
	double dash;

        switch(cap) {
		case LRENDER_LINE_CAP_BUTT:
			cairo_set_line_cap(cr,CAIRO_LINE_CAP_BUTT);
		break;
		
		case LRENDER_LINE_CAP_ROUND:
			cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND);
		break;
		
		case LRENDER_LINE_CAP_SQUARE:
			cairo_set_line_cap(cr,CAIRO_LINE_CAP_SQUARE);
		break;

		default:
		break;
	}
	switch(join) {
		case LRENDER_LINE_JOIN_MITER:
			cairo_set_line_join(cr,CAIRO_LINE_JOIN_MITER);
		break;

		case LRENDER_LINE_JOIN_ROUND:
			cairo_set_line_join(cr,CAIRO_LINE_JOIN_ROUND);
		break;

		case LRENDER_LINE_JOIN_BEVEL:
			cairo_set_line_join(cr,CAIRO_LINE_JOIN_BEVEL);
		break;

		default:
		break;
	}
	switch(fillRule) {
		case LRENDER_FILL_RULE_WINDING:
			cairo_set_fill_rule(cr,CAIRO_FILL_RULE_WINDING);
		break;

		case LRENDER_FILL_RULE_EVEN_ODD:
			cairo_set_fill_rule(cr,CAIRO_FILL_RULE_EVEN_ODD);
		break;

		default:
		break;
	}
	if (dash_object!=Qnil) {
		dash=NUM2DBL(dash_object);
		cairo_set_dash(cr,&dash,1,0.0);
	}
	cairo_set_line_width(cr,width);
	return Qnil;
}
void Init_setPathOptions()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"setPathOptions",setPathOptions,2);
}
