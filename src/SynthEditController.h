#pragma once

#import "ofMain.h"
#import "ofxMSAInteractiveObject.h"
#import "Button.h"
#import "Slider.h"
#import "RootModel.h"
#import "SynthModel.h"
#import "RootModel.h"
#import "Button.h"

#define NUMSYNTHS 8

class SynthEditController : public ofxMSAInteractiveObject{
public:
	void setup();
	void draw();
	void update();
	void touchDown(ofTouchEventArgs &touch);
	void setSliders();
	ofImage background, slideBg, slideLeftCap, slideLoop, slideRightCap, slideFull, exitButtonImg;
	ofTrueTypeFont interstate, interstateLrg;
	Button exitButton;
	Slider slideControl[7];
	SynthModel *synth;
	RootModel *rootModel;
	bool exitNow;
};