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

class SpeedController : public ofxMSAInteractiveObject{
public:
	void setup();
	void draw();
	void update();
	ofImage background, slideBg, slideLeftCap, slideLoop, slideRightCap, slideFull, exitButtonImg;
	ofTrueTypeFont interstate;
	Slider slideControl[2];
	RootModel *rootModel;
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void setSliders();
};