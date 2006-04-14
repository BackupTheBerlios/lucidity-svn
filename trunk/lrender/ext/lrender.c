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

extern void Init_lrenderDisplayVirtualScreen();
extern void Init_lrenderCreateScreen();
extern void Init_lrenderCreateVirtualScreen();
extern void Init_lrenderUpdateScreen();
extern void Init_lrenderPaintScreen();
extern void Init_lrenderCreateRawSurface();
extern void Init_lrenderDestroyRawSurface();
extern void Init_lrenderCreateCairoContext();
extern void Init_lrenderSetCairoContext();
extern void Init_lrenderSetPathOptions();
extern void Init_lrenderFinalizePath();
extern void Init_lrenderDrawText();
extern void Init_lrenderDrawLine();
extern void Init_lrenderUpdateSDLSurface();

void Init_lrender()
{
	Init_lrenderDisplayVirtualScreen();
	Init_lrenderCreateScreen();
	Init_lrenderCreateVirtualScreen();
	Init_lrenderUpdateScreen();
	Init_lrenderPaintScreen();
	Init_lrenderCreateRawSurface();
	Init_lrenderDestroyRawSurface();
	Init_lrenderCreateCairoContext();
	Init_lrenderSetCairoContext();
	Init_lrenderSetPathOptions();
	Init_lrenderFinalizePath();
	Init_lrenderDrawText();
	Init_lrenderDrawLine();
	Init_lrenderUpdateSDLSurface();
}
