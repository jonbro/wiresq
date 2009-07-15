
#include "testApp.h"
#include "glHelper.h"
#import	"TouchEvent.h"
#import "globals.h"

extern ofxMSAShape3D *myShape;

//--------------------------------------------------------------
void testApp::setup(){	
	ofBackground(50, 50, 50);
	ofSetBackgroundAuto(true);
	ofxMultiTouch.addListener(this);
	ofEnableAlphaBlending();

	glEnableClientState( GL_VERTEX_ARRAY );  // this should be in OF somewhere.  
	glPointSize(60);
	glEnable(GL_POINT_SMOOTH);
	[glHelper setupLighting];
	main_screen = [[EditorScreen alloc]init];
	[Events setFirstResponder:main_screen];

	// load in our textures
	
}


//--------------------------------------------------------------
void testApp::update(){
	[main_screen update];
}

//--------------------------------------------------------------
void testApp::draw(){
	[main_screen render];	
}

void testApp::exit() {
	printf("exit()\n");
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
	// this will never get called 
	
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
	ofEnableSmoothing();
}

//--------------------------------------------------------------
void testApp::mouseReleased(){
//	printf("mouseReleased\n");
	printf("frameRate: %.3f, frameNum: %i\n", ofGetFrameRate(), ofGetFrameNum());
}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){
	
}

//--------------------------------------------------------------
void testApp::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.pos = CGPointMake(x, y);
	t_event.touchId = touchId;
	[Events touchDown:t_event];
}
//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.pos = CGPointMake(x, y);
	t_event.touchId = touchId;
	[Events touchMoved:t_event];
}
//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.pos = CGPointMake(x, y);
	t_event.touchId = touchId;
	[Events touchUp:t_event];
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.pos = CGPointMake(x, y);
	t_event.touchId = touchId;
	[Events touchDoubleTap:t_event];
}


