/*
 *  SynthEditController
 *  ww
 *
 *  Created by jonbroFERrealz on 9/25/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "SynthEditController.h"
#include "MainController.h"

void SynthEditController::setup()
{
	background.loadImage("images/synth_edit_bg.png");
	background.setImageType(OF_IMAGE_COLOR_ALPHA);
	
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

	exitButtonImg.loadImage("images/from_synths.png");
	exitButtonImg.setImageType(OF_IMAGE_COLOR_ALPHA);

	interstate.loadFont("OpenDin.ttf", 14);
	interstateLrg.loadFont("OpenDin.ttf", 28);
	float offset = 65;
	for (int i=0; i<7; i++) {
		slideControl[i].setup();
		slideControl[i].setPosAndSize(65, (slideBg.getHeight()+10)*i+offset, slideBg.getWidth(), slideBg.getHeight());
		slideControl[i].horizontal = true;
		slideControl[i].disableAppEvents();
	}
	exitButton.setup();
	exitButton.disableAppEvents();
	exitButton.setPosAndSize(244, 415, 40, 40);
	exitNow = false;
}
void SynthEditController::DisableSliders(){
	for (int i=0; i<7; i++) {
		slideControl[i].removeListeners();
	}
}
void SynthEditController::EnableSliders(){
	for (int i=0; i<7; i++) {
		slideControl[i].addListeners();
		slideControl[i].disableAppEvents();
	}
}
void SynthEditController::update(){
	// pass the data back to the synth
	synth->Attack = slideControl[0].value;
	synth->Hold = slideControl[1].value;
	synth->Decay = slideControl[2].value;
	synth->Pitch = slideControl[3].value;
	synth->Cutoff = slideControl[5].value;
	synth->Res = slideControl[6].value;
}
void SynthEditController::setSliders()
{
	slideControl[0].value = synth->Attack;
	slideControl[1].value = synth->Hold;
	slideControl[2].value = synth->Decay;
	slideControl[3].value = synth->Pitch;
	slideControl[5].value = synth->Cutoff;
	slideControl[6].value = synth->Res;	
}
void SynthEditController::draw()
{
	string settings[7] = {"ATK", "HLD", "REL", "PTC", "STN", "CUT", "RES"};
	ofSetColor(0xffffff);
	background.draw(0, 0);
	// draw all of the custom controllers
	for (int i=0; i<7; i++) {
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
	exitButtonImg.draw(exitButton.x, exitButton.y);
	ofSetColor(0xFFFFFF);
	interstateLrg.drawString("syn "+ofToString(rootModel->currentSynth, 0), 65, 40);
}
void SynthEditController::touchDown(ofTouchEventArgs &touch){
	if (exitButton.hitTest(touch)) {
		mainController->changeScreen("synth_list");
	}
}
void SynthEditController::touchMoved(ofTouchEventArgs &touch){
	
}
