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
#include "include/displayVirtualScreen.h"

static VALUE displayVirtualScreen(VALUE self, VALUE virtualScreen, VALUE realScreen)
{
	SDL_BlitSurface((SDL_Surface *) virtualScreen,
			NULL,
			(SDL_Surface *) realScreen,
			NULL);
	SDL_UpdateRect((SDL_Surface *) realScreen,0,0,0,0);
	return (VALUE) Qnil;
}

void Init_lrenderDisplayVirtualScreen()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"displayVirtualScreen",displayVirtualScreen,2);
}
