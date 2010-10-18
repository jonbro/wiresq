
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
	ofSetFrameRate(30);
	mixer.rootModel = &rootModel;
	mixer.mainController = &mainController;
	mixer.setup();

	mainController.rootModel = &rootModel;
	mainController.mixer = &mixer;
	mainController.setup();	
	
	ofSoundStreamSetup(2,0,this,44100, 512, 4);
	//saveLoad.setPosAndSize(320-40, 480-40, 40, 40);
	rootModel.load();

}

void testApp::audioRequested(float * output, int bufferSize, int nChannels) {
	memset(output, 0, sizeof(float)*bufferSize*nChannels);
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

