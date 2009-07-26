/*
 *  DrawSprite.h
 *  logo_fighter
 *
 *  Created by Jonathan Brodsky on 7/12/09.
 *  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
 *
 */

#import "ofxMSAShape3D.h"
#import "ofMain.h"
#ifdef TARGET_OPENGLES
	#include "glu.h"
#endif

void drawRectSprite(int tex, int x, int y, int width, int height, int offset_x, int offset_y);
void drawRectSprite(int tex, int x, int y, int width, int height, int offset_x, int offset_y, int scale_width, int scale_height);
