#pragma once

#include "ofMain.h"
#include "Button.h"
#include "ofPointUtils.h"

class MultiButton : public Button{
public:
	MultiButton();
	virtual void touchDown(ofTouchEventArgs &touch);
	void draw();
	void addState(int _state);
	vector<int> states;
	int maxStates;
	int state;
};