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

#ifndef LRENDER_H
#define LRENDER_H

#define LRENDER_ANTIALIAS_DEFAULT 	0
#define LRENDER_ANTIALIAS_NONE 		1
#define LRENDER_ANTIALIAS_GRAY		2
#define LRENDER_ANTIALIAS_SUBPIXEL	3

#define LRENDER_LINE_CAP_BUTT		0
#define LRENDER_LINE_CAP_ROUND		1
#define LRENDER_LINE_CAP_SQUARE		2

#define LRENDER_FILL_RULE_WINDING	0
#define LRENDER_FILL_RULE_EVEN_ODD	1

#define LRENDER_LINE_JOIN_MITER		0
#define LRENDER_LINE_JOIN_ROUND		1
#define LRENDER_LINE_JOIN_BEVEL		2

static VALUE cLRender;
#endif
