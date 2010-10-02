#pragma once

#include "defines.h" 

#include "ofxMSAInteractiveObject.h"
#include "Button.h"
#include "RootModel.h"

class MainController;

class ScrollView : public ofxMSAInteractiveObject{
public:
	ScrollView();
	void draw();
	void update();
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	bool hitTest(ofTouchEventArgs &touch);

	void setCell(ofTouchEventArgs &touch);

	int currentTouch, numFingers;
	bool hasTouch;
	
	ofPoint offset;
	ofPoint fingerStart[16];
	ofPoint fingerCurrent[16];
	ofPoint fingerCenterStart, fingerCenterCurrent;
	ofPoint lastChanged;
	float timeChanged, timeScrolled;
	float fingerDistStart, fingerDistCurrent;
	
	RootModel *rootModel;
	MainController *mainController;
	bool state;
	bool fingerStartedInView[16];
};