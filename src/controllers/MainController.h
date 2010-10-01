#pragma once

#import "ofMain.h"
#include "scrollView.h"
#include "TopBarController.h"
#include "RootModel.h"
#include "SynthListController.h"
#include "SynthEditController.h"
#include "defines.h"
#include "MixerController.h"
#include "speedController.h"

class MainController{
public:
	void setup();
	void draw(ofEventArgs &e);
	void update(ofEventArgs &e);

	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	
	void changeScreen(string screen);
	ofPoint synthListOffset, synthListOffsetTarget;

	RootModel *rootModel;

	ScrollView scroller;
	TopBarController topBar;
	SynthListController synthList;
	SynthEditController synthEdit;
	MixerController *mixer;
	SpeedController speedControl;
};