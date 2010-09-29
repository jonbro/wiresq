#pragma once

#include "ofMain.h"
#include "ofxMSAInteractiveObject.h"
#include "ofPointUtils.h"

class Button : public ofxMSAInteractiveObject{
public:
	Button();
	void draw();
	void update();
	void setup();
	void addListeners();
	void removeListeners();

	virtual void touchDown(ofTouchEventArgs &touch);
	virtual void touchMoved(ofTouchEventArgs &touch);
	virtual void touchUp(ofTouchEventArgs &touch);
	virtual bool hitTest(ofTouchEventArgs &touch);
	
	int currentTouch;
	int color, colorTouch;
	bool hasTouch;
	
	bool state;
};