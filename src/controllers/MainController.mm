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

	toFileOps.setPosAndSize(282, 445, 38, 35);
	toFileOps.disableAllEvents();
	toExtra.loadImage("images/to_extra.png");
	
	fileOpsView = [[FileOpsViewController alloc]init];
	fileOpsView.rootModel = rootModel;
	
}
void MainController::draw(ofEventArgs &e)
{
	ofSetColor(0x404040);
	ofRect(0, 0, 320, 480);
	ofSetColor(0xffffff);
	ofPushMatrix();
		ofTranslate(0, synthListOffset.y, 0);
		ofPushMatrix();
			ofTranslate(synthListOffset.x+146, 0, 0);
			scroller.draw();
		ofPopMatrix();
		topBar.draw();
		toExtra.draw(toFileOps.x, toFileOps.y);
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
		ofPushMatrix();
		ofTranslate(0, synthListOffset.y, 0);
		synthList.draw();		
		ofPopMatrix();
	}
	ofPopMatrix();
	if (rootModel->currentScreen == SCREEN_SPEED) {
		ofPushMatrix();
		ofTranslate(0, synthListOffset.y, 0);
		ofTranslate(0, -100, 0);
		speedControl.draw();
		ofPopMatrix();
	}	
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
	if (rootModel->currentScreen == SCREEN_EDIT) {
		synthEdit.update();
	}
	speedControl.update();
}
void MainController::touchDown(ofTouchEventArgs &touch)
{
	float startY = touch.y;
	doubleOnScroller = false;
	if (rootModel->currentScreen == SCREEN_SPEED) {
		touch.y -= synthListOffset.y;
	}
	if (toFileOps.hitTest(touch)) {

		UIView *currentView = ofxiPhoneGetGLView();

		// get the the underlying UIWindow, or the view containing the current view view
		UIView *theWindow = [currentView superview];
		
		// remove the current view and replace with myView1
		[currentView removeFromSuperview];
		[theWindow addSubview:fileOpsView.view];
		
		// set up an animation for the transition between the views
		CATransition *animation = [CATransition animation];
		[animation setDuration:0.5];
		[animation setType:kCATransitionPush];
		[animation setSubtype:kCATransitionFromRight];
		[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
		[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];		
	}else {
		if (rootModel->currentScreen == SCREEN_EDIT) {
			synthEdit.touchDown(touch);
		}else if (rootModel->currentScreen == SCREEN_LIST || rootModel->currentScreen == SCREEN_SCROLL || rootModel->currentScreen == SCREEN_SPEED) {
			if (rootModel->currentScreen == SCREEN_LIST && synthList.hitTest(touch)){
				if (topBar.toSynthControl.hitTest(touch)) {
					topBar.touchDown(touch);
				}else {
					synthList.touchDown(touch);
				}
			}else{
				if (topBar.hitTest(touch)) {
					topBar.touchDown(touch);
				}else if (scroller.hitTest(touch)) {
					scroller.touchDown(touch);
					doubleOnScroller = true;
				}
			}
			// remove the speed offset
		}else if (rootModel->currentScreen == SCREEN_NOTE) {
			// remove the speed offset
			touch.y = startY;
			notePopControl.touchDown(touch);
		}
		touch.y = startY;
		if (ofGetElapsedTimeMillis() - lastTouchTime < 200 && lastTouch == touch.id && doubleOnScroller == true) {
			this->touchDoubleTap(touch);
		}
		lastTouchTime = ofGetElapsedTimeMillis();
		lastTouch = touch.id;		
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
		synthList.touchMoved(touch);
	}
	touch.y = startY;
	if (rootModel->currentScreen == SCREEN_NOTE) {
		notePopControl.touchMoved(touch);
	}
}
void MainController::touchUp(ofTouchEventArgs &touch)
{ 
	scroller.touchUp(touch);
	if (rootModel->currentScreen == SCREEN_LIST) {
		synthList.touchUp(touch);
	}
	if (rootModel->currentScreen == SCREEN_NOTE) {
		notePopControl.touchUp(touch);
	}		
}
void MainController::touchDoubleTap(ofTouchEventArgs &touch)
{
	if (rootModel->currentScreen == SCREEN_SCROLL || rootModel->currentScreen == SCREEN_LIST) {
		scroller.touchDoubleTap(touch);
	}
}
void MainController::changeScreen(string screen){
	synthEdit.DisableSliders();
	speedControl.DisableSliders();
	if(screen=="synth_list"){
		rootModel->currentScreen = SCREEN_LIST;
		synthListOffsetTarget.set(0, 0, 0);
	}else if (screen == "scroller") {
		rootModel->currentScreen = SCREEN_SCROLL;
		synthListOffsetTarget.set(-146, 0, 0);
	}else if (screen == "synth_edit") {
		rootModel->currentScreen = SCREEN_EDIT;
		printf("setting edit page to synth num: %i\n", rootModel->currentSynth);
		synthEdit.synth = &rootModel->synthData[rootModel->currentSynth];
		synthEdit.setSliders();
		synthEdit.EnableSliders();
		synthListOffsetTarget.set(320, 0, 0);
	}else if(screen == "speed"){
		if (rootModel->currentScreen != SCREEN_SPEED) {
			rootModel->currentScreen = SCREEN_SPEED;
			speedControl.EnableSliders();
			synthListOffsetTarget.set(-146, 100, 0);
			rootModel->linkingSynths = false;
			topBar.toSynthControl.setPosAndSize(0, 438, 42, 44);
			topBar.atSynthList = false;			
		}else {
			rootModel->currentScreen = SCREEN_SCROLL;
			synthListOffsetTarget.set(-146, 0, 0);
		}
	}else if(screen == "note_pop"){
		rootModel->currentScreen = SCREEN_NOTE;
		notePopControl.showTime = ofGetElapsedTimeMillis();
		notePopControl.initDisplay();
	}
}
