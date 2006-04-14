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
#include "include/createScreen.h"

static VALUE createScreen(VALUE self, VALUE width_object, VALUE height_object)
{
	int width=NUM2INT(width_object);
	int height=NUM2INT(height_object);

	SDL_Surface *screen;
	SDL_Init(SDL_INIT_VIDEO);
	atexit(SDL_Quit);

	SDL_GL_SetAttribute(SDL_GL_RED_SIZE, 50);
	SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, 50);
	SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, 50);
	SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 32);
	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
	screen=SDL_SetVideoMode(width,height,32,SDL_OPENGL | SDL_NOFRAME);
	if (screen==NULL) {
		fprintf(stderr,"Sorry, your system lacks OpenGL support.\n");
		fprintf(stderr,"Falling back to hardware rendering.\n");
		screen=SDL_SetVideoMode(width,height,32,SDL_HWSURFACE | SDL_DOUBLEBUF | SDL_NOFRAME ); 
	}
	if (screen==NULL) {
		fprintf(stderr,"Sorry, your system lacks hardware rendering support.\n");
		fprintf(stderr,"Falling back to software rendering.\n");
		screen=SDL_SetVideoMode(width,height,32,SDL_SWSURFACE | SDL_DOUBLEBUF | SDL_NOFRAME );
	}
	if (screen==NULL) {
		fprintf(stderr,"Unable to open screen.\n");
		exit(1);
	}
	return (VALUE) screen;
}

void Init_lrenderCreateScreen()
{
	cLRender=rb_define_class("LRender",rb_cObject);
	rb_define_singleton_method(cLRender,"createScreen",createScreen,2);
}
