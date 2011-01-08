/*
 *  TopBarController.mm
 *  ww
 *
 *  Created by jonbroFERrealz on 9/25/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "TopBarController.h"
#include "MainController.h"

void TopBarController::setup(){
	background.loadImage("images/topbar.png");
	background.setImageType(OF_IMAGE_COLOR_ALPHA);
	
	stateImages[0].loadImage("images/blank.png");
	stateImages[0].setImageType(OF_IMAGE_COLOR_ALPHA);
	stateImages[1].loadImage("images/wire.png");
	stateImages[1].setImageType(OF_IMAGE_COLOR_ALPHA);
	stateImages[2].loadImage("images/spark.png");
	stateImages[2].setImageType(OF_IMAGE_COLOR_ALPHA);
	stateImages[3].loadImage("images/tail.png");
	stateImages[3].setImageType(OF_IMAGE_COLOR_ALPHA);
	
	stateControl.setPosAndSize(47, 5, 114, 36);
	stateControl.removeListeners();
	
	pencilPan[0].loadImage("images/pencil.png");
	pencilPan[1].loadImage("images/pan.png");
	panControl.setPosAndSize(5, 4, 37, 36);
	panControl.removeListeners();
	
	playImages[0].loadImage("images/play_false.png");
	playImages[0].setImageType(OF_IMAGE_COLOR_ALPHA);
	playImages[1].loadImage("images/play_true.png");
	playImages[1].setImageType(OF_IMAGE_COLOR_ALPHA);

	playControl.setPosAndSize(279, 5, 34, 34);
	playControl.removeListeners();
	
	toSpeed.setPosAndSize(279-40, 4, 34, 34);
	toSpeed.removeListeners();
	
	toSynthImage.loadImage("images/to_synths.png");
	toSynthImage.setImageType(OF_IMAGE_COLOR_ALPHA);
	toSynthControl.setPosAndSize(0, 445, 42, 44);
	toSynthControl.removeListeners();
	atSynthList = false;
	printf("TopBarController::setup loaded\n");
	interstate.loadFont("OpenDin.ttf", 14);
}
bool TopBarController::hitTest(ofTouchEventArgs &touch)
{
	if ((touch.x > x && touch.x < width+x
		&& touch.y > y && touch.y < height+y)
		|| toSynthControl.hitTest(touch)) {
		return true;
	}
	return false;
}

void TopBarController::draw(){
	ofSetColor(255, 255, 255);
	background.draw(0, 0);
	stateImages[rootModel->currentState].draw(stateControl.x, stateControl.y);
	
	pencilPan[rootModel->drawState].draw(panControl.x, panControl.y);
	
	if (rootModel->running) {
		playImages[1].draw(279, 5);
	}else {
		playImages[0].draw(279, 5);
	}
	string bpm_clock = ofToString(rootModel->bpm, 0)+"X"+ofToString(rootModel->clockMult, 0);
	interstate.drawString(bpm_clock, 279-interstate.stringWidth(bpm_clock)-10, 28);
	if (!atSynthList) {
		toSynthImage.draw(0, 445);
	}
}
void TopBarController::update(){
}
void TopBarController::touchDown(ofTouchEventArgs &touch)
{
	if (stateControl.hitTest(touch) && !atSynthList) {
		rootModel->currentState = (rootModel->currentState+1)%4;
	}
	if (panControl.hitTest(touch) && !atSynthList) {
		rootModel->drawState = (rootModel->drawState+1)%2;
	}	
	if (playControl.hitTest(touch)) {
		rootModel->running = !(rootModel->running);
	}
	if (toSpeed.hitTest(touch)) {
		mainController->changeScreen("speed");
	}
	if (toSynthControl.hitTest(touch)){
		atSynthList = !atSynthList;
		if (!atSynthList) {
			rootModel->linkingSynths = false;
			toSynthControl.setPosAndSize(0, 438, 42, 44);
			mainController->changeScreen("scroller");
		}else{
			rootModel->linkingSynths = true;
			toSynthControl.setPosAndSize(150, 438, 42, 44);
			mainController->changeScreen("synth_list");
		}
	}
}