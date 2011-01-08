/*
 *  CircleButton.cpp
 *  KLANGKRAFTER
 *
 *  Created by jonbroFERrealz on 5/17/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "CircleButton.h"
#include "ofGraphics.h"

static float	torusPts[OF_MAX_CIRCLE_PTS*4];
static float	torusPtsScaled[OF_MAX_CIRCLE_PTS*4];

static bool 	bSetupTorus		= false;
void 			setupTorus();
static int		numTorusPts		= 0;

//----------------------------------------------------------
void setupTorus(){
	int res = 30;
	
	if (res > 1 && res != numTorusPts){
		numTorusPts = res;
		
		float angle = 0.0f;
		float angleAdder = M_TWO_PI / (float)res;
		int k = 0;
		for (int i = 0; i < numTorusPts+2; i++){
			torusPts[k] = cos(angle);
			torusPts[k+1] = sin(angle);
			angle += angleAdder;
			k+=2;
		}
		bSetupTorus = true;
	}
}
bool CircleButton::hitTest(ofTouchEventArgs &touch){
	if(
	   ofDist(touch.x, touch.y, x, y)<radius
	   && ofDist(touch.x, touch.y, x, y)>centerRadius
	){
		return true;
	}
	return false;
}
void CircleButton::draw()
{
	if(hasTouch){
		ofSetHexColor(touchColor);
	}else{
		ofSetHexColor(color);
	}
	// cache the points for the current resolution
	
	if (!bSetupTorus) setupTorus();
	int k = 0;
	for(int i = 0; i < numTorusPts*4+4; i+=4){
		torusPtsScaled[i]   = x + torusPts[k] * radius;
		torusPtsScaled[i+1] = y + torusPts[k+1] * radius;
		torusPtsScaled[i+2]   = x + torusPts[k] * centerRadius;
		torusPtsScaled[i+3] = y + torusPts[k+1] * centerRadius;
		k+=2;
	}
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glVertexPointer(2, GL_FLOAT, 0, &torusPtsScaled[0]);
	glDrawArrays( GL_TRIANGLE_STRIP, 0, numTorusPts*2+2);
}
