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
#include "include/drawText.h"

static VALUE drawText(VALUE self,VALUE text,VALUE cr_object)
{
	VALUE string_object=rb_iv_get(text,"@text");
	VALUE size_object=rb_iv_get(text,"@realSize");
	VALUE font_object=rb_iv_get(text,"@font");
	VALUE bold_object=rb_iv_get(text,"@bold");
	VALUE italic_object=rb_iv_get(text,"@italic");
	VALUE oblique_object=rb_iv_get(text,"@oblique");
	cairo_t *cr=(cairo_t *) cr_object;

	int size=NUM2INT(size_object);
	int slant=0;
	int weight=0;

	if (bold_object==Qtrue) weight=CAIRO_FONT_WEIGHT_BOLD;
	if (bold_object==Qtrue) weight=CAIRO_FONT_WEIGHT_NORMAL;

	if (italic_object==Qtrue && oblique_object==Qfalse) 
		slant=CAIRO_FONT_SLANT_ITALIC;
	if (italic_object==Qfalse && oblique_object==Qtrue) 
		slant=CAIRO_FONT_SLANT_OBLIQUE;
	if (italic_object==Qfalse && oblique_object==Qfalse)
		slant=CAIRO_FONT_SLANT_NORMAL;

	cairo_select_font_face(cr, StringValuePtr(font_object),slant,weight);
	cairo_set_font_size(cr,size);
	cairo_show_text(cr,StringValuePtr(string_object));
	cairo_restore(cr);
	return Qnil;
}

void Init_lrenderDrawText()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"drawText",drawText,2);
}
