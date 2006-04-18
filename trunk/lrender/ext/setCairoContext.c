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
#include "include/setCairoContext.h"
static VALUE setCairoContext(VALUE self, VALUE cr_object, VALUE other_object)
{
        VALUE x_object=rb_iv_get(other_object,"@realX");
        VALUE y_object=rb_iv_get(other_object,"@realY");

        VALUE red_object=rb_iv_get(other_object,"@red");
        VALUE green_object=rb_iv_get(other_object,"@green");
        VALUE blue_object=rb_iv_get(other_object,"@blue");
        VALUE alpha_object=rb_iv_get(other_object,"@alpha");
	VALUE anti_alias_object=rb_iv_get(other_object,"@antiAlias");

        int x=NUM2INT(x_object);
        int y=NUM2INT(y_object);
	int anti_alias=NUM2INT(anti_alias_object);

        double red=NUM2DBL(red_object);
        double green=NUM2DBL(green_object);
        double blue=NUM2DBL(blue_object);
        double alpha=NUM2DBL(alpha_object);

        cairo_t *cr=(cairo_t *) cr_object;
        cairo_set_source_rgba(cr,red,green,blue,alpha);
	switch(anti_alias) {
		case LRENDER_ANTIALIAS_DEFAULT:
		        cairo_set_antialias(cr,CAIRO_ANTIALIAS_DEFAULT);
		break;
		case LRENDER_ANTIALIAS_NONE:
			cairo_set_antialias(cr,CAIRO_ANTIALIAS_NONE);
		break;
		case LRENDER_ANTIALIAS_GRAY:
			cairo_set_antialias(cr,CAIRO_ANTIALIAS_GRAY);
		break;
		case LRENDER_ANTIALIAS_SUBPIXEL:
			cairo_set_antialias(cr,CAIRO_ANTIALIAS_SUBPIXEL);
		break;
		default:
		break;
	}

        cairo_save(cr);
        cairo_move_to(cr,x,y);
//
/*
        cairo_select_font_face(cr,"Sans",0,0);
        cairo_set_font_size(cr,25);
        cairo_show_text(cr,"Hello world");
        cairo_restore(cr);
*/
//
	return Qnil;
}
void Init_setCairoContext()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"setCairoContext",setCairoContext,2);
}
