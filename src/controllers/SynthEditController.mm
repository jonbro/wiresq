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
	
	threeSegment[0].loadImage("images/segment3_1.png");
	threeSegment[0].setImageType(OF_IMAGE_COLOR_ALPHA);
	threeSegment[1].loadImage("images/segment3_2.png");
	threeSegment[1].setImageType(OF_IMAGE_COLOR_ALPHA);
	threeSegment[2].loadImage("images/segment3_3.png");
	threeSegment[2].setImageType(OF_IMAGE_COLOR_ALPHA);
	
	float offset = 65;
	for (int i=0; i<8; i++) {
		if (i==1 || i==4) {
			offset+=24;
		}
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
	for (int i=0; i<8; i++) {
		slideControl[i].removeListeners();
	}
}
void SynthEditController::EnableSliders(){
	for (int i=0; i<8; i++) {
		slideControl[i].addListeners();
		slideControl[i].disableAppEvents();
	}
}
void SynthEditController::update(){
	// pass the data back to the synth
	synth->wavType = (int)ceilf(slideControl[0].value*3.0)-1;
	synth->Attack = slideControl[1].value;
	synth->Hold = slideControl[2].value;
	synth->Decay = slideControl[3].value;
	synth->Cutoff = slideControl[4].value;
	synth->Res = slideControl[5].value;
}
void SynthEditController::setSliders()
{
	slideControl[0].value = (synth->wavType+1)/3.0;
	slideControl[1].value = synth->Attack;
	slideControl[2].value = synth->Hold;
	slideControl[3].value = synth->Decay;
	slideControl[4].value = synth->Cutoff;
	slideControl[5].value = synth->Res;	
}
void SynthEditController::draw()
{
	string settings[8] = {"WAV", "ATK", "HLD", "REL", "CUT", "RES"};
	ofSetColor(0xffffff);
	background.draw(0, 0);
	ofSetColor(0xFFFFFF);
	// draw the three segment control
	interstate.drawString(settings[0], slideControl[0].x-interstate.stringWidth(settings[0])-10, interstate.getLineHeight()+slideControl[0].y+3);
	threeSegment[(int)(slideControl[0].value*2.99)].draw(slideControl[0].x, slideControl[0].y);

	// draw all of the sliders
	for (int i=1; i<6; i++) {
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
	interstateLrg.drawString("syn "+ofToString(rootModel->currentSynth, 0), 65, 41);
	ofSetColor(synth->color.red*255.0, synth->color.green*255.0, synth->color.blue*255.0);
	interstateLrg.drawString("syn "+ofToString(rootModel->currentSynth, 0), 65, 40);
	// draw the synth descriptors
	ofSetColor(0xFFFFFF);
	interstate.drawString("AMP ENVELOPE", 65, 131);
	interstate.drawString("FILTER", 65, 299);

}
void SynthEditController::touchDown(ofTouchEventArgs &touch){
	if (exitButton.hitTest(touch)) {
		mainController->changeScreen("synth_list");
	}
}
void SynthEditController::touchMoved(ofTouchEventArgs &touch){
	
}
