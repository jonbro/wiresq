#include "MainController.h"
#include "MixerController.h"

void MainController::setup()
{
	ofAddListener(ofEvents.touchDown, this, &MainController::touchDown);
	ofAddListener(ofEvents.touchUp, this, &MainController::touchUp);
	// ofAddListener(ofEvents.touchDoubleTap, this, &MainController::touchDoubleTap);
	ofAddListener(ofEvents.touchMoved, this, &MainController::touchMoved);	
	ofAddListener(ofEvents.update, this, &MainController::update);
	ofAddListener(ofEvents.draw, this, &MainController::draw);

	topBar.setPosAndSize(0, 0, 320, 44);
	topBar.rootModel = rootModel;
	topBar.mainController = this;
	topBar.setup();
	topBar.disableAppEvents();
	
	scroller.setPosAndSize(0, 44, 320, 436);
	scroller.setup();
	scroller.rootModel = rootModel;
	scroller.mainController = this;
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
	speedControl.setPosAndSize(0, -100, 320, 100);
	speedControl.rootModel = rootModel;
	
	notePopControl.setup();
	notePopControl.rootModel = rootModel;
	notePopControl.mainController = this;
	lastTouch = 0;
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
			ofTranslate(0, -100, 0);
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
	if (rootModel->currentScreen == SCREEN_NOTE) {
		notePopControl.draw();
	}
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
	if (ofGetElapsedTimeMillis() - lastTouchTime < 200 && lastTouch == touch.id) {
		this->touchDoubleTap(touch);
	}
	lastTouchTime = ofGetElapsedTimeMillis();
	lastTouch = touch.id;
	float startY = touch.y;
	if (rootModel->currentScreen == SCREEN_SPEED) {
		touch.y -= synthListOffset.y;
	}	
	if (rootModel->currentScreen == SCREEN_EDIT) {
		synthEdit.touchDown(touch);
	}else if (topBar.hitTest(touch) == false && !speedControl.hitTest(touch)) {
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
	if (rootModel->currentScreen == SCREEN_NOTE) {
		notePopControl.touchDown(touch);
	}
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
	}else if ((topBar.hitTest(touch) == false || rootModel->currentScreen == SCREEN_LIST) && rootModel->currentScreen != SCREEN_NOTE && !speedControl.hitTest(touch)) {
		scroller.touchMoved(touch);
	}
	touch.y = startY;
	if (rootModel->currentScreen == SCREEN_NOTE) {
		notePopControl.touchMoved(touch);
	}	
}
void MainController::touchUp(ofTouchEventArgs &touch)
{ 
	scroller.touchUp(touch);
	if (rootModel->currentScreen == SCREEN_NOTE) {
		notePopControl.touchUp(touch);
	}		
}
void MainController::touchDoubleTap(ofTouchEventArgs &touch)
{
	if (rootModel->currentScreen == SCREEN_SCROLL) {
		scroller.touchDoubleTap(touch);
	}
}
void MainController::changeScreen(string screen){
	synthEdit.DisableSliders();
	if(screen=="synth_list"){
		rootModel->currentScreen = SCREEN_LIST;
		synthListOffsetTarget.set(0, 0, 0);
	}else if (screen == "scroller") {
		rootModel->currentScreen = SCREEN_SCROLL;
		synthListOffsetTarget.set(-146, 0, 0);
	}else if (screen == "synth_edit") {
		rootModel->currentScreen = SCREEN_EDIT;
		synthEdit.setSliders();
		synthEdit.EnableSliders();
		synthEdit.synth = &rootModel->synthData[rootModel->currentSynth];
		synthListOffsetTarget.set(320, 0, 0);
	}else if(screen == "speed"){
		if (rootModel->currentScreen != SCREEN_SPEED) {
			rootModel->currentScreen = SCREEN_SPEED;
			speedControl.EnableSliders();
			synthListOffsetTarget.set(-146, 100, 0);			
		}else {
			rootModel->currentScreen = SCREEN_SCROLL;
			synthListOffsetTarget.set(-146, 0, 0);
			speedControl.DisableSliders();
		}
	}else if(screen == "note_pop"){
		rootModel->currentScreen = SCREEN_NOTE;
		notePopControl.showTime = ofGetElapsedTimeMillis();
		notePopControl.initDisplay();
	}
}
