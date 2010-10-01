/*
 *  CircleButton.h
 *  KLANGKRAFTER
 *
 *  Created by jonbroFERrealz on 5/17/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */
#pragma once
#include "Button.h"

class CircleButton : public Button {
public:
	void draw();
	bool hitTest(ofTouchEventArgs &touch);
	int radius, centerRadius;
	int color, touchColor;
};