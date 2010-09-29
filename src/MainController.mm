#include "MainController.h"

void MainController::setup()
{
	ofAddListener(ofEvents.touchDown, this, &MainController::touchDown);
	ofAddListener(ofEvents.touchUp, this, &MainController::touchUp);
	ofAddListener(ofEvents.touchMoved, this, &MainController::touchMoved);	
	ofAddListener(ofEvents.update, this, &MainController::update);
	ofAddListener(ofEvents.draw, this, &MainController::draw);

	topBar.setPosAndSize(0, 0, 320, 44);
	topBar.rootModel = rootModel;
	topBar.setup();
	topBar.disableAppEvents();
	
	scroller.setPosAndSize(0, 44, 320, 436);
	scroller.rootModel = rootModel;
	scroller.disableAllEvents();
}
void MainController::draw(ofEventArgs &e)
{
	ofSetColor(0x404040);
	ofRect(0, 0, 320, 480);
	ofSetColor(0xffffff);
	scroller.draw();
	topBar.draw();	
}
void MainController::update(ofEventArgs &e)
{
	scroller.update();
	topBar.update();
}

void MainController::touchDown(ofTouchEventArgs &touch)
{
	// only pass down events that fail hit tests otherwise
	if (topBar.hitTest(touch) == false) {
		scroller.touchDown(touch);
	}
	topBar.touchDown(touch);
}
void MainController::touchMoved(ofTouchEventArgs &touch)
{
	// only pass down events that fail hit tests otherwise
	if (topBar.hitTest(touch) == false) {
		scroller.touchMoved(touch);
	}
}
void MainController::touchUp(ofTouchEventArgs &touch)
{ 
	scroller.touchUp(touch);
}
void MainController::touchDoubleTap(ofTouchEventArgs &touch)
{
}
