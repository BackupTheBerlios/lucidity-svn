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
#include "include/updateSDLSurface.h"

static VALUE updateSDLSurface(VALUE self, VALUE screen, VALUE width_object, VALUE height_object, VALUE raw_surface)
{
	VALUE screen_object=rb_iv_get(screen,"@screen");

	int width=NUM2INT(width_object);
	int height=NUM2INT(height_object);
	SDL_Surface *sdl_surface=SDL_CreateRGBSurfaceFrom(
			(void *) raw_surface, 
			width,
			height,
			32,
			width*4,
			0x00ff0000,0x0000ff00,0x000000ff,0xff000000);
	SDL_BlitSurface(sdl_surface,
			NULL,
			(SDL_Surface *) screen_object,
			NULL);
//	SDL_UpdateRect(screen_object,0,0,0,0);
	SDL_FreeSurface(sdl_surface);
	return (VALUE) Qnil;
}

void Init_lrenderUpdateSDLSurface()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"updateSDLSurface",updateSDLSurface,4);
}
