#pragma once
#import "ofMain.h"
#import "Button.h"
#import "ofxMSAInteractiveObject.h"
#import "MSAShape3D.h"
#import "glu.h"

class NotePopController : public ofxMSAInteractiveObject{
public:
	void setup();
	void draw();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);

	void drawRect(int x, int y, int width, int height, int inputWidth, int inputHeight, int offset_x, int offset_y, int texture);
	void drawRect(int x, int y, int width, int height, int offset_x, int offset_y, int texture);
	
	Button leftPane, rightPane;
	bool fingerDown1;
	int fingerNumber1;
	float fingerPos1;
	
	float sliderOffset1;
	
	ofImage bg, fg, notes, octaves;
	MSA::Shape3D myShape;
};