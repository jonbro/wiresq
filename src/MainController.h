#pragma once

#import "ofMain.h"
#include "scrollView.h"
#include "TopBarController.h"
#include "RootModel.h"

class MainController{
public:
	void setup();
	void draw(ofEventArgs &e);
	void update(ofEventArgs &e);

	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	
	RootModel *rootModel;
	ScrollView scroller;
	TopBarController topBar;	
};