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

extern void Init_openDisplay();

extern void Init_createScreen();
extern void Init_updateScreen();
extern void Init_paintScreen();

extern void Init_createCairoContext();
extern void Init_setCairoContext();

extern void Init_drawText();
extern void Init_drawLine();

extern void Init_setPathOptions();
extern void Init_finalizePath();

void Init_lrender()
{
	Init_openDisplay();

	Init_createScreen();
	Init_updateScreen();
	Init_paintScreen();

	Init_createCairoContext();
	Init_setCairoContext();

	Init_drawText();
	Init_drawLine();

	Init_setPathOptions();
	Init_finalizePath();
}
