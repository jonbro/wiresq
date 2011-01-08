/*
 *  MultiButton.cpp
 *  emptyUniversalExample
 *
 *  Created by jonbroFERrealz on 8/20/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "MultiButton.h"
MultiButton::MultiButton()
{
	maxStates = 0;
}
void MultiButton::touchDown(ofTouchEventArgs &touch)
{
	if (this->hitTest(touch)) {
		hasTouch = true;
		currentTouch = touch.id;
		state = (state+1)%maxStates;
		printf("state: %i\n", state);
	} else {
		hasTouch = false;
	}
}
void MultiButton::addState(int _state)
{
	states.push_back(_state);
	maxStates++;
}
void MultiButton::draw()
{
	ofFill();
	ofSetHexColor(states[state]);
	ofRect(x, y, width, height);
}
