
#include "testApp.h"
#include "glHelper.h"
#import	"TouchEvent.h"

//--------------------------------------------------------------
void testApp::setup(){	
	ofBackground(50, 50, 50);
	ofSetBackgroundAuto(true);
	ofxMultiTouch.addListener(this);

	glEnableClientState( GL_VERTEX_ARRAY );  // this should be in OF somewhere.  
	glPointSize(60);
	glEnable(GL_POINT_SMOOTH);
	[glHelper setupLighting];
	main_t = [[Turtle alloc]init];
	main_screen = [[EditorScreen alloc]init];
}


//--------------------------------------------------------------
void testApp::update(){
	[main_t update];
	[main_screen update];
}

//--------------------------------------------------------------
void testApp::draw(){
	[main_t render];
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
	[main_screen touchDownX:x Y:y ID:touchId];
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.touchId = touchId;
	[Events touchDown:t_event];
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"touchDown" object:[t_event retain]];
}
//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	[main_screen touchMoveX:x Y:y ID:touchId];
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.touchId = touchId;
	[Events touchMoved:t_event];
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"touchMove" object:[t_event retain]];	
}
//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	[main_screen touchUpX:x Y:y ID:touchId];
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.touchId = touchId;
	[Events touchUp:t_event];
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"touchUp" object:[t_event retain]];	
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	printf("touch %i double tap at (%i,%i)\n", touchId, x,y);
}


