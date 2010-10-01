
#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	ofEnableAlphaBlending();

	mainController.rootModel = &rootModel;
	mainController.setup();
	
	mixer.rootModel = &rootModel;
	mixer.setup();

	ofSoundStreamSetup(2,0,this,44100,256, 4);
	//saveLoad.setPosAndSize(320-40, 480-40, 40, 40);
	rootModel.load();

}

void testApp::audioRequested(float * output, int bufferSize, int nChannels) {
	for(int i = 0; i < bufferSize; i++) {
		output[i*2] = 0;
		output[i*2+1] = 0;
	}
	mixer.audioRequested(output, bufferSize, nChannels);
}

//--------------------------------------------------------------
void testApp::update() {
}

//--------------------------------------------------------------
void testApp::draw() {
}

//--------------------------------------------------------------
void testApp::exit() {
	printf("save from test app\n");
	rootModel.save();
}


//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
	/*
	if(saveLoad.hitTest(touch)){
		rootModel.save();
		rootModel.load();
	}
	*/
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
}


//--------------------------------------------------------------
void testApp::lostFocus() {
}

//--------------------------------------------------------------
void testApp::gotFocus() {
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning() {
	printf("memory warning\n");

}

