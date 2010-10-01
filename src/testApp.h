#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "Button.h"
#include "MultiButton.h"
#include "defines.h"
#include "RootModel.h"
#include "MixerController.h"
#include "MainController.h"
class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	
	void play(double * output);

	void audioRequested(float * output, int bufferSize, int nChannels);
	ofAudioEventArgs audioEventArgs;
	
	
	Button saveLoad;
	
	RootModel rootModel;
	MainController mainController;
	MixerController mixer;
	int sx, sy;
	
};


