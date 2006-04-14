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
#include "include/createVirtualScreen.h"

static VALUE createVirtualScreen(VALUE self, VALUE width_object, VALUE height_object)
{
	int width=NUM2INT(width_object);
	int height=NUM2INT(height_object);

	SDL_Surface *virtualScreen;
	virtualScreen=SDL_CreateRGBSurface(
			SDL_HWSURFACE /*| SDL_SRCCOLORKEY | SDL_SRCALPHA*/,
			width,
			height,
			32,
			0x00ff0000,0x0000ff00,0x000000ff,0xff000000);

	if (virtualScreen==NULL)
		virtualScreen=SDL_CreateRGBSurface(
				SDL_SWSURFACE | SDL_SRCCOLORKEY | SDL_SRCALPHA,
				width,
				height,
				32,
				0x00ff0000,0x0000ff00,0x000000ff,0xff000000);

	return (VALUE) virtualScreen;
}

void Init_lrenderCreateVirtualScreen()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"createVirtualScreen",createVirtualScreen,2);
}
