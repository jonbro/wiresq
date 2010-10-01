#pragma once
#include "ofMain.h"
#include "ofxMSAInteractiveObject.h"
#import <Foundation/Foundation.h>


class Slider : public ofxMSAInteractiveObject {
public:
	void setup();
	void draw();
	void update();
	void addListeners();
	void removeListeners();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	

	int currentTouch;
	bool hasTouch;
	
	ofPoint lastPos;
	
	float value;
	float displayValue;
	ofTrueTypeFont displayFont;
	NSNumber *data;
	bool useData;
	bool horizontal;

};