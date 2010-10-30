/*
 *  SynthListController.mm
 *  ww
 *
 *  Created by jonbroFERrealz on 9/25/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "SynthListController.h"
#include "MainController.h"

void SynthListController::setup()
{
	background.loadImage("images/synth_list_bg.png");
	background.setImageType(OF_IMAGE_COLOR_ALPHA);

	synthItem[0].loadImage("images/synth_list_item.png");
	synthItem[0].setImageType(OF_IMAGE_COLOR_ALPHA);
	
	synthItem[1].loadImage("images/synth_list_item_hilight.png");
	synthItem[1].setImageType(OF_IMAGE_COLOR_ALPHA);

	numSynths=NUMSYNTHS;
	rootModel->currentSynth=0;

	int lastY = 6;
	for (int i=0; i<numSynths; i++) {
		synthSelect[i].setPosAndSize(0, lastY+2, synthItem[0].getWidth(), synthItem[0].getHeight());
		lastY+=2+synthItem[0].getHeight();
		synthSelect[i].disableAllEvents();
	}
}
void SynthListController::update()
{
}
void SynthListController::draw()
{
	ofSetColor(0xffffff);
	background.draw(0, 0);
	int lastY = 6;
	for (int i=0; i<numSynths; i++) {
		ofSetColor(rootModel->synthData[i].color.red*255.0, rootModel->synthData[i].color.green*255.0, rootModel->synthData[i].color.blue*255.0);
		if (i==rootModel->currentSynth) {
			synthItem[1].draw(0, lastY+2);
		}else{
			synthItem[0].draw(0, lastY+2);
		}
		lastY+=2+synthItem[0].getHeight();
	}
}
void SynthListController::drawConnectors(){
	int lastY = 6+(rootModel->currentSynth*(2+synthItem[0].getHeight()));
	ofSetColor(rootModel->synthData[rootModel->currentSynth].color.red*255.0, rootModel->synthData[rootModel->currentSynth].color.green*255.0, rootModel->synthData[rootModel->currentSynth].color.blue*255.0);
	ofNoFill();
	ofSetLineWidth(2);
	ofPoint partOne;
	for(int i=0;i<rootModel->synthLinks.size();i++){
		SynthLink *link = &rootModel->synthLinks[i];
		if (link->synth == rootModel->currentSynth) {
			float additionalSynthxOff = (link->linkNumber%4)*40/8.0*2+mainController->scroller.offset.x;
			float additionalSynthyOff = (link->linkNumber/4)*40/8.0*2+mainController->scroller.offset.y;
			partOne.set(link->x*40+2+additionalSynthxOff, link->y*40+2+44+additionalSynthyOff);
			ofCurve(0, lastY+2+synthItem[0].height/2.0, synthItem[0].width, lastY+2+synthItem[0].height/2.0, partOne.x+2.5+146, fmax(partOne.y+2.5, 47), partOne.x+40+146, fmax(partOne.y+2.5, 47));
		}
	}
	if (hasTempPoint) {
		partOne = tempPoint;
		ofCurve(0, lastY+2+synthItem[0].height/2.0, synthItem[0].width, lastY+2+synthItem[0].height/2.0, partOne.x+2.5+146, fmax(partOne.y+2.5, 47), partOne.x+40+146, fmax(partOne.y+2.5, 47));
	}
}
bool SynthListController::hitTest(ofTouchEventArgs &touch)
{
	if (touch.x > x && touch.x < width+x
		&& touch.y > y && touch.y < height+y) {
		return true;
	}
	return false;
}
void SynthListController::touchDown(ofTouchEventArgs &touch)
{
	bool second = false;
	fingerStartedInView[touch.id] = true;
	for (int i=0; i<numSynths; i++) {
		if(synthSelect[i].hitTest(touch)){
			if (rootModel->currentSynth == i) {
				second = true;
			}
			rootModel->currentSynth = i;
		}
	}
	if (second) {
		synthSelect[rootModel->currentSynth].width /= 2;
		printf("selecting synth num:%i\n", rootModel->currentSynth);
		if (synthSelect[rootModel->currentSynth].hitTest(touch)) {
			mainController->changeScreen("synth_edit");
			fingerStartedInView[touch.id] = false;
		}
		synthSelect[rootModel->currentSynth].width *= 2;
	}
}
void SynthListController::touchMoved(ofTouchEventArgs &touch)
{
	if (rootModel->currentScreen == SCREEN_LIST) {
		touch.x-=146;
	}	
	if (fingerStartedInView[touch.id] && mainController->scroller.hitTest(touch)) {
		hasTempPoint = true;
		tempPoint.set(touch.x, touch.y, 0);
	}else {
		hasTempPoint = false;
	}
	if (rootModel->currentScreen == SCREEN_LIST) {
		touch.x+=146;
	}	
}
void SynthListController::touchUp(ofTouchEventArgs &touch)
{
	// check to see if it is outside of this view
	if (fingerStartedInView[touch.id] && !hitTest(touch) && mainController->scroller.hitTest(touch)) {
		mainController->scroller.linkCell(touch);
	}
	fingerStartedInView[touch.id] = false;
	hasTempPoint = false;
}