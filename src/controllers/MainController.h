#pragma once

#import <UIKit/UIKit.h>

#import "ofMain.h"
#include "scrollView.h"
#include "TopBarController.h"
#include "RootModel.h"
#include "Button.h"
#include "SynthListController.h"
#include "SynthEditController.h"
#include "defines.h"
#include "speedController.h"
#include "NotePopController.h"
#include "FileOpsViewController.h"
#include "ofxiPhoneExtras.h"


class MixerController;

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
	int lastTouch, lastTouchTime;
	bool doubleOnScroller;
	RootModel *rootModel;
	Button toFileOps;
	ScrollView scroller;
	TopBarController topBar;
	SynthListController synthList;
	SynthEditController synthEdit;
	NotePopController notePopControl;
	MixerController *mixer;
	SpeedController speedControl;
	FileOpsViewController *fileOpsView;
};