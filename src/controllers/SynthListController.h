#pragma once

#import "ofMain.h"
#import "ofxMSAInteractiveObject.h"
#import "Button.h"
#import "RootModel.h"
#import "SynthEditController.h"
#import "ofxColor.h"
#import "synthLink.h"

#define NUMSYNTHS 8

class MainController;

class SynthListController : public ofxMSAInteractiveObject{
public:
	void setup();
	void draw();
	void drawConnectors();
	void update();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	
	virtual bool hitTest(ofTouchEventArgs &touch);

	ofImage background;
	ofImage synthItem[2];
	Button synthSelect[NUMSYNTHS];
	int numSynths;
	bool editing, hasTempPoint;
	RootModel *rootModel;
	MainController *mainController;
	ofPoint	tempPoint;
	bool fingerStartedInView[16];
};