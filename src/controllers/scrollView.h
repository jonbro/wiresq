#pragma once

#include "defines.h" 

#include "ofxMSAInteractiveObject.h"
#include "Button.h"
#include "RootModel.h"
#include "synthLink.h"
#include <deque>

class MainController;

class ScrollView : public ofxMSAInteractiveObject{
public:
	ScrollView();
	void setup();
	void draw();
	void update();
	void commitSet();
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	bool hitTest(ofTouchEventArgs &touch);

	void setCell(ofTouchEventArgs &touch);
	void linkCell(ofTouchEventArgs &touch);

	int currentTouch, numFingers;
	bool hasTouch, waitingForCommit;
	
	ofPoint offset, mainOffset;
	ofPoint fingerStart[16];
	ofPoint fingerCurrent[16];
	ofPoint fingerCenterStart, fingerCenterCurrent;
	ofPoint lastChanged;
	ofImage triggerDisplay;
	float timeChanged, timeScrolled;
	float fingerDistStart, fingerDistCurrent;
	
	deque<SynthLink> triggersToDisplay;
	int numLinks[NUMCELLSX][NUMCELLSY];
	RootModel *rootModel;
	MainController *mainController;
	bool state;
	bool fingerStartedInView[16];
};