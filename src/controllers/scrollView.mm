/*
 *  scrollView.cpp
 *  ww
 *
 *  Created by jonbroFERrealz on 9/24/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "scrollView.h"
#include "MainController.h"

ScrollView::ScrollView(){
	numFingers = 0;
	offset.set(0, 0, 1.0);
}
void ScrollView::setup()
{
	triggerDisplay.loadImage("images/trigger_display.png");
	triggerDisplay.setAnchorPercent(0.5, 0.5);
}
void ScrollView::draw(){
	ofSetColor(0xFFFFFF);
	// standard size is 40 40
	ofPushMatrix();
	float cellSize = 40.0*offset.z;
	//printf("offsetx: %f", offset.x);
	int xOffset = -offset.x/cellSize;
	int yOffset = -offset.y/cellSize;
	ofTranslate(fmod(offset.x, cellSize), fmod(offset.y, cellSize), 0);
	float top = y;
	for (int x=0; x<width/cellSize+1; x++) {
		for (int y=0; y<height/cellSize+1; y++) {
			if ( // make sure we are not drawing outside of the array
				x+xOffset>=0&&
				y+yOffset>=0&&
				x+xOffset<NUMCELLSX&&
				y+yOffset<NUMCELLSY
			) {
				switch (rootModel->world[x+xOffset][y+yOffset][0]) {
					case 1:
						ofSetColor(255, 215, 0);
						break;
					case 2:
						ofSetColor(255, 64, 0);
						break;
					case 3:
						ofSetColor(0, 128, 255);
						break;
					default:
						ofSetColor(0, 0, 0);
						break;
				}
				if (cellSize>10) {
					ofRect(x*cellSize, y*cellSize+top, cellSize-1, cellSize-1);				
				}else{
					ofRect(x*cellSize, y*cellSize+top, cellSize, cellSize);				
				}
			}
		}		
	}
	ofPopMatrix();
	
	// draw the synth links...
	ofPushMatrix();
	ofTranslate(offset.x, offset.y+y, 0);
	for(int i=0;i<rootModel->synthLinks.size();i++){
		SynthLink *link = &rootModel->synthLinks[i];
		numLinks[(int)link->x][(int)link->y] = 0;
	}
	
	for(int i=0;i<rootModel->synthLinks.size();i++){
		
		SynthLink *link = &rootModel->synthLinks[i];
		/*if (link->x+offset.x<width/cellSize+1 && link->y+offset.y<height/cellSize+1) { DONT FEEL LIKE FIGURING OUT THIS CULLING RIGHT NOW*/

		ofSetColor(rootModel->synthData[link->synth].color.red*255.0, rootModel->synthData[link->synth].color.green*255.0, rootModel->synthData[link->synth].color.blue*255.0);
		float additionalSynthxOff = (numLinks[(int)link->x][(int)link->y]%4)*cellSize/8.0*2;
		float additionalSynthyOff = (numLinks[(int)link->x][(int)link->y]/4)*cellSize/8.0*2;
		ofRect((link->x*cellSize+2)+additionalSynthxOff, (link->y*cellSize+2)+additionalSynthyOff, cellSize/8.0, cellSize/8.0);
		link->linkNumber = numLinks[(int)link->x][(int)link->y];
		numLinks[(int)link->x][(int)link->y]++;
	}
	
	deque<SynthLink>::iterator theIterator;

	for( theIterator = triggersToDisplay.begin(); theIterator != triggersToDisplay.end(); ++theIterator ) {
		if (ofGetElapsedTimeMillis() - theIterator->triggerTime < 2000) {
			float timeSinceTrigger = ofGetElapsedTimeMillis() - theIterator->triggerTime;
			float alpha = 1 - timeSinceTrigger/2000.0;
			float size = timeSinceTrigger/2000.0 *200.0;
			
			ofSetColor(rootModel->synthData[theIterator->synth].color.red*255.0, rootModel->synthData[theIterator->synth].color.green*255.0, rootModel->synthData[theIterator->synth].color.blue*255.0, alpha*255.0);
			//ofSetColor(255, 255, 255, alpha*255.0);
			triggerDisplay.draw(theIterator->x*cellSize+cellSize/2.0, theIterator->y*cellSize+cellSize/2.0, size, size);
		}
	}
	for (int i=triggersToDisplay.size(); i<0; i--) {
		if (ofGetElapsedTimeMillis() - theIterator->triggerTime > 2000) {
			triggersToDisplay.erase(triggersToDisplay.begin() + i);
		}
	}
	
	ofPopMatrix();
}
void ScrollView::update(){
	float cellSize = 40.0*offset.z;
	rootModel->scrollOffset = offset;

	if (numFingers == 0 && rootModel->currentScreen != SCREEN_NOTE) {
		if (offset.x>0) {
			offset.x = ofLerp(offset.x, 0.0, 0.3);
		}else if (offset.x<-NUMCELLSX*cellSize+width) {
			offset.x = ofLerp(offset.x, -NUMCELLSX*cellSize+width, 0.3);
		}
		if (offset.y>0) {
			offset.y = ofLerp(offset.y, 0, 0.3);
		}else if (offset.y<-NUMCELLSY*cellSize+height) {
			offset.y = ofLerp(offset.y, -NUMCELLSY*cellSize+height, 0.3);
		}
		if (offset.z<0.2) {
			offset.z = ofLerp(offset.z, 0.2, 0.3);
		}
		if (offset.z>1.8) {
			offset.z = ofLerp(offset.z, 1.8, 0.3);
		}
	}else if(rootModel->currentScreen == SCREEN_NOTE){
		offset.x = ofLerp(offset.x, (-mainController->notePopControl.editTargetX*40+20)+(ofGetWidth()/2-40), 0.3);
		offset.y = ofLerp(offset.y, (-mainController->notePopControl.editTargetY*40+20)+(ofGetHeight()/2-40), 0.3);
	}
	if (ofGetElapsedTimeMillis() - timeChanged > 200 && waitingForCommit) {
		commitSet();
		waitingForCommit = false;
	}
}
bool ScrollView::hitTest(ofTouchEventArgs &touch)
{
	if (touch.x > x && touch.x < width+x
		&& touch.y > y && touch.y < height+y) {
		return true;
	}
	return false;
}
void ScrollView::setCell(ofTouchEventArgs &touch)
{
	if (ofGetElapsedTimeMillis() - timeScrolled > 200) {
		float cellSize = offset.z*40.0;
		if (rootModel->currentScreen == SCREEN_LIST) {
			touch.x-=146;
		}
		int xOffset = (touch.x-offset.x)/cellSize;
		int yOffset = (touch.y-y-offset.y)/cellSize;
		rootModel->world[xOffset][yOffset][0] = rootModel->currentState;
		rootModel->world[xOffset][yOffset][1] = rootModel->currentState;
	}
}
void ScrollView::linkCell(ofTouchEventArgs &touch)
{
	float cellSize = offset.z*40.0;
	if (rootModel->currentScreen == SCREEN_LIST) {
		touch.x-=146;
	}
	int xOffset = (touch.x-offset.x)/cellSize;
	int yOffset = (touch.y-y-offset.y)/cellSize;
	rootModel->setLink(xOffset, yOffset, rootModel->currentSynth);
}
void ScrollView::touchDown(ofTouchEventArgs &touch)
{
	if (rootModel->drawState == 0 || rootModel->currentScreen == SCREEN_LIST) {
		if (rootModel->linkingSynths) {
			lastChanged.set(touch.x, touch.y, rootModel->currentSynth);
			timeChanged = ofGetElapsedTimeMillis();			
		}else {
			lastChanged.set(touch.x, touch.y, 0);
			timeChanged = ofGetElapsedTimeMillis();			
		}		
		waitingForCommit = true;
	}
	fingerStartedInView[touch.id] = true;
	numFingers++;
	fingerStart[touch.id].set(touch.x, touch.y, 0);
	fingerCurrent[touch.id].set(touch.x, touch.y, 0);
	
	fingerCenterCurrent = fingerCenterStart = fingerStart[touch.id];
	fingerDistStart = ofpLength(fingerStart[0]-fingerStart[1]);
}
void ScrollView::commitSet()
{
	ofTouchEventArgs touch;
	touch.x = lastChanged.x;
	touch.y = lastChanged.y;
	setCell(touch);
}
void ScrollView::touchMoved(ofTouchEventArgs &touch)
{
	fingerCurrent[touch.id].set(touch.x, touch.y, 0);
	if (rootModel->drawState == 0 && rootModel->currentScreen == SCREEN_SCROLL) {
		setCell(touch);
	}else if(fingerStartedInView[touch.id]){
		fingerStart[touch.id].set(touch.x, touch.y, 0);
		fingerDistStart = ofpLength(fingerStart[0]-fingerStart[1]);
		fingerCenterCurrent = fingerCurrent[touch.id];
		offset += fingerCenterCurrent - fingerCenterStart;
		fingerDistCurrent = ofpLength(fingerCurrent[0]-fingerCurrent[1]);
		float scaleDiff = 1-fingerDistStart/fingerDistCurrent;
		/*
		 offset.z += scaleDiff; // that last thing should be a function of the current scale
		 
		 ofPoint ScreenCenter, ScreenCentertwo;
		 ScreenCenter.set(ofGetWidth()/2, ofGetHeight()/2, 0);
		 ScreenCenter *= offset.z;
		 ScreenCenter *= 1.0-scaleDiff;
		 /*ScreenCenter -=offset;
		 ScreenCentertwo.set(ofGetWidth(), ofGetHeight(), 0);
		 ScreenCentertwo -=offset;
		 ScreenCenter *= 1.0-scaleDiff;
		 ScreenCenter -= ScreenCentertwo;
		 */
		//offset += ScreenCenter;
		
		//offset.z = ofClamp(offset.z, 0.2, 1.8);
		/*
		 offset.y *= offset.z;
		 offset.x *= offset.z;
		 */
		fingerDistStart = fingerDistCurrent;
		
		fingerCenterStart = fingerCenterCurrent;
		timeScrolled = ofGetElapsedTimeMillis();		
	}

}
void ScrollView::touchDoubleTap(ofTouchEventArgs &touch)
{
	float cellSize = offset.z*40.0;
	if (rootModel->currentScreen == SCREEN_LIST) {
		touch.x-=146;
	}
	printf("doubletapped\n");
	waitingForCommit = false;
	int xOffset = (touch.x-offset.x)/cellSize;
	int yOffset = (touch.y-y-offset.y)/cellSize;
	if (rootModel->currentScreen != SCREEN_LIST) {
		mainController->notePopControl.editTargetX = xOffset;
		mainController->notePopControl.editTargetY = yOffset;
		mainController->changeScreen("note_pop");
	}else {
		// remove the link
		rootModel->removeLink(xOffset, yOffset, rootModel->currentSynth);
	}

}
void ScrollView::touchUp(ofTouchEventArgs &touch)
{
	if (fingerStartedInView[touch.id]) {
		numFingers--;
	}
	fingerStartedInView[touch.id] = false;
}


