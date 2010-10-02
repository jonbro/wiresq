/*
 *  speedController.mm
 *  ww
 *
 *  Created by jonbroFERrealz on 9/30/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "speedController.h"

void SpeedController::setup()
{
	slideBg.loadImage("images/slider_bg.png");
	slideBg.setImageType(OF_IMAGE_COLOR_ALPHA);
	
	slideLeftCap.loadImage("images/slider_cap_left.png");
	slideLeftCap.setImageType(OF_IMAGE_COLOR_ALPHA);
	
	slideLoop.loadImage("images/slider_loop.png");
	slideLoop.setImageType(OF_IMAGE_COLOR_ALPHA);
	
	slideRightCap.loadImage("images/slider_cap_right.png");
	slideRightCap.setImageType(OF_IMAGE_COLOR_ALPHA);
	
	slideFull.loadImage("images/slider_full.png");
	slideFull.setImageType(OF_IMAGE_COLOR_ALPHA);
	float offset = 10;
	for (int i=0; i<2; i++) {
		slideControl[i].setup();
		slideControl[i].setPosAndSize(65, (slideBg.getHeight()+10)*i+offset, slideBg.getWidth(), slideBg.getHeight());
		slideControl[i].horizontal = true;
		slideControl[i].disableAppEvents();
	}
	DisableSliders();
	interstate.loadFont("OpenDin.ttf", 14);
	setSliders();
}
// passes the data back to the model
void SpeedController::update()
{
	rootModel->bpm = slideControl[0].value*259.0+1;	
	rootModel->clockMult = slideControl[1].value*15.0+1;	
}
void SpeedController::DisableSliders(){
	for (int i=0; i<2; i++) {
		slideControl[i].removeListeners();
	}
}
void SpeedController::EnableSliders(){
	for (int i=0; i<2; i++) {
		slideControl[i].addListeners();
		slideControl[i].disableAppEvents();
	}
}
void SpeedController::setSliders()
{
	slideControl[0].value = (rootModel->bpm-1)/259.0;	
	slideControl[1].value = (rootModel->clockMult-1)/15.0;	
}
void SpeedController::draw()
{
	ofSetColor(0x4f565a);
	ofRect(0, 0, 320, 200);
	string settings[7] = {"BPM", "CLK"};
	ofSetColor(0xffffff);
	// draw all of the custom controllers
	for (int i=0; i<2; i++) {
		ofSetColor(0, 0, 0);
		interstate.drawString(settings[i], slideControl[i].x-interstate.stringWidth(settings[i])-10, interstate.getLineHeight()+slideControl[i].y+3);
		ofSetColor(0xFFFFFF);
		if (slideControl[i].value*slideControl[i].width > slideControl[i].width-3) {
			slideFull.draw(slideControl[i].x, slideControl[i].y);
		}else{
			slideBg.draw(slideControl[i].x, slideControl[i].y);
			if (slideControl[i].value > 0) {
				slideLeftCap.draw(slideControl[i].x, slideControl[i].y);
				slideLoop.draw(slideControl[i].x+4, slideControl[i].y+1, slideControl[i].value*slideControl[i].width-4, slideControl[i].height-2);
				slideRightCap.draw(slideControl[i].x+slideControl[i].value*slideControl[i].width, slideControl[i].y+1);
			}
		}
	}
}
void SpeedController::touchDown(ofTouchEventArgs &touch){
}
void SpeedController::touchMoved(ofTouchEventArgs &touch){
	
}
