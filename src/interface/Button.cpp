/*
 *  Button.cpp
 *  hurdy_gurdy
 *
 *  Created by jonbroFERrealz on 1/12/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "Button.h"
Button::Button()
{
	colorTouch = 0x156C4F;
	color = 0x79D7FF;
}
void Button::draw()
{
	ofFill();
	if (state) {
		ofSetHexColor(colorTouch);
	}else {
		ofSetHexColor(color);
	}
	ofRect(x, y, width, height);
}
void Button::update()
{
}
void Button::setup()
{
	ofAddListener(ofEvents.touchDown, this, &Button::touchDown);
	ofAddListener(ofEvents.touchUp, this, &Button::touchUp);
	ofAddListener(ofEvents.touchMoved, this, &Button::touchMoved);	
	enableAppEvents();
}
void Button::removeListeners()
{
	ofRemoveListener(ofEvents.touchDown, this, &Button::touchDown);
	ofRemoveListener(ofEvents.touchUp, this, &Button::touchUp);
	ofRemoveListener(ofEvents.touchMoved, this, &Button::touchMoved);	
	disableAppEvents();	
}
void Button::addListeners(){
	ofAddListener(ofEvents.touchDown, this, &Button::touchDown);
	ofAddListener(ofEvents.touchUp, this, &Button::touchUp);
	ofAddListener(ofEvents.touchMoved, this, &Button::touchMoved);	
	enableAppEvents();	
}
void Button::touchDown(ofTouchEventArgs &touch)
{
	if (this->hitTest(touch)) {
		hasTouch = true;
		currentTouch = touch.id;
		if (state) {
			state = false;
		}else {
			state = true;
		}
	} else {
		hasTouch = false;
	}

}
void Button::touchMoved(ofTouchEventArgs &touch)
{
	//touchDown(touch);
}
void Button::touchUp(ofTouchEventArgs &touch)
{
}
bool Button::hitTest(ofTouchEventArgs &touch)
{
	if (touch.x > x && touch.x < width+x
		&& touch.y > y && touch.y < height+y) {
		return true;
	}
	return false;
}
