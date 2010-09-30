#pragma once

#import "ofMain.h"
#import "ofxMSAInteractiveObject.h"
#import "Button.h"
#import "RootModel.h"
#import "SynthEditController.h"
#import "ofxColor.h"

#define NUMSYNTHS 8

class MainController;

class SynthListController : public ofxMSAInteractiveObject{
public:
	void setup();
	void draw();
	void drawConnectors();
	void update();
	void touchDown(ofTouchEventArgs &touch);
	virtual bool hitTest(ofTouchEventArgs &touch);

	ofImage background;
	ofImage synthItem[2];
	Button synthSelect[NUMSYNTHS];
	int numSynths;
	bool editing;
	RootModel *rootModel;
	MainController *mainController;
};