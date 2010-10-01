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
	topBar.mainController = this;
	topBar.setup();
	topBar.disableAppEvents();
	
	scroller.setPosAndSize(0, 44, 320, 436);
	scroller.rootModel = rootModel;
	scroller.disableAllEvents();
	
	synthList.rootModel = rootModel;
	synthListOffset.set(-184, 0, 0);
	synthListOffsetTarget.set(-146, 0, 0);
	synthList.setPosAndSize(0, 0, 184, 480);
	synthList.mainController = this;
	synthList.setup();
	synthList.disableAllEvents();
	rootModel->currentScreen = SCREEN_SCROLL;
	
	synthEdit.rootModel = rootModel;
	synthEdit.synth = &rootModel->synthData[0];
	synthEdit.mainController = this;
	synthEdit.setup();
	synthEdit.disableAllEvents();
	
	speedControl.setup();
	speedControl.rootModel = rootModel;
}
void MainController::draw(ofEventArgs &e)
{
	ofSetColor(0x404040);
	ofRect(0, 0, 320, 480);
	ofSetColor(0xffffff);
	ofPushMatrix();
		ofTranslate(0, synthListOffset.y, 0);
		if (rootModel->currentScreen == SCREEN_SPEED) {
			ofPushMatrix();
			ofTranslate(0, -200, 0);
			speedControl.draw();
			ofPopMatrix();
		}
		ofPushMatrix();
			ofTranslate(synthListOffset.x+146, 0, 0);
			scroller.draw();
		ofPopMatrix();
		topBar.draw();
	ofPopMatrix();
	ofPushMatrix();
	ofTranslate(synthListOffset.x, 0, 0);
	if (rootModel->currentScreen == SCREEN_LIST) {
		synthList.drawConnectors();
	}
	if (rootModel->currentScreen == SCREEN_LIST || rootModel->currentScreen == SCREEN_EDIT) {
		ofPushMatrix();
		ofTranslate(-320, 0, 0);
		synthEdit.draw();
		ofPopMatrix();
	}
	if (fabs(synthListOffset.x+146.0)>1) {
		synthList.draw();		
	}
	ofPopMatrix();
}
void MainController::update(ofEventArgs &e)
{
	scroller.update();
	topBar.update();
	synthListOffset.x = ofLerp(synthListOffset.x, synthListOffsetTarget.x, 0.2);
	synthListOffset.y = ofLerp(synthListOffset.y, synthListOffsetTarget.y, 0.2);
	synthList.update();
	synthEdit.update();
	speedControl.update();
}
void MainController::touchDown(ofTouchEventArgs &touch)
{
	float startY = touch.y;
	if (rootModel->currentScreen == SCREEN_SPEED) {
		touch.y -= synthListOffset.y;
	}	
	if (rootModel->currentScreen == SCREEN_EDIT) {
		synthEdit.touchDown(touch);
	}else if (topBar.hitTest(touch) == false) {
		if (rootModel->currentScreen == SCREEN_LIST) {
			if(!synthList.hitTest(touch)){
				scroller.touchDown(touch);
			}else {
				synthList.touchDown(touch);
			}
		}else {
			scroller.touchDown(touch);
		}
	}
	topBar.touchDown(touch);
	touch.y = startY;
}
void MainController::touchMoved(ofTouchEventArgs &touch)
{
	float startY = touch.y;
	if (rootModel->currentScreen == SCREEN_SPEED) {
		touch.y -= synthListOffset.y;
	}
	// only pass down events that fail hit tests otherwise
	if (rootModel->currentScreen == SCREEN_EDIT) {
		synthEdit.touchMoved(touch);
	}else if (topBar.hitTest(touch) == false || rootModel->currentScreen == SCREEN_LIST) {
		scroller.touchMoved(touch);
	}
	touch.y = startY;
}
void MainController::touchUp(ofTouchEventArgs &touch)
{ 
	scroller.touchUp(touch);
}
void MainController::touchDoubleTap(ofTouchEventArgs &touch)
{
}
void MainController::changeScreen(string screen){
	if(screen=="synth_list"){
		rootModel->currentScreen = SCREEN_LIST;
		synthListOffsetTarget.set(0, 0, 0);
	}else if (screen == "scroller") {
		rootModel->currentScreen = SCREEN_SCROLL;
		synthListOffsetTarget.set(-146, 0, 0);
	}else if (screen == "synth_edit") {
		rootModel->currentScreen = SCREEN_EDIT;
		synthEdit.setSliders();
		synthEdit.synth = &rootModel->synthData[rootModel->currentSynth];
		synthListOffsetTarget.set(320, 0, 0);
	}else if(screen == "speed"){
		if (rootModel->currentScreen != SCREEN_SPEED) {
			rootModel->currentScreen = SCREEN_SPEED;
			speedControl.EnableSliders();
			synthListOffsetTarget.set(-146, 200, 0);			
		}else {
			rootModel->currentScreen = SCREEN_SCROLL;
			synthListOffsetTarget.set(-146, 0, 0);
			speedControl.DisableSliders();
		}
	}

}
