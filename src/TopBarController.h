#pragma once

#import "ofMain.h"
#import "ofxMSAInteractiveObject.h"
#import "RootModel.h"
#import "Button.h"
#import "SynthListController.h"

class TopBarController : public ofxMSAInteractiveObject{
public:
	void setup();
	void update();
	void draw();
	void touchDown(ofTouchEventArgs &touch);
	bool hitTest(ofTouchEventArgs &touch);
	
	ofImage stateImages[4];
	ofImage background, toSynthImage;
	ofImage playImages[2];
	
	Button stateControl, playControl, toSynthControl;
	RootModel *rootModel;
	SynthListController	synthList;
	
	bool atSynthList;
};