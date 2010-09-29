#include "Slider.h"
void Slider::setup(){
	addListeners();
	static bool loaded = false;
	if (!loaded)
		//displayFont.loadFont("avenirLT65Medium.ttf", 16);
	loaded = true;
	value = 1;
	displayValue = 1;
	useData = false;
	data = [[NSNumber alloc] initWithInt:0];
}
void Slider::draw(){
	// draw the outside
	ofSetColor(0, 0, 0);
	ofRect(x, y, width, height);
	// draw the inside
	ofSetColor(100, 100, 100);
	printf("drawing: horizontal: %s\n", horizontal?"true":"false");
	if (horizontal == true) {
		ofRect(width*value+x+1, y+1.0, width-width*value-2, height-2);
		ofSetColor(255, 255, 255);		
	}else {
		ofRect(x+1, height*value+y+1.0, width-2, height-height*value-2);
		ofSetColor(255, 255, 255);		
	}
	//displayFont.drawString(ofToString(displayValue, 2), x+1, height*value+y+1.0);
}
void Slider::update(){
}
void Slider::addListeners(){
	ofAddListener(ofEvents.touchDown, this, &Slider::touchDown);
	ofAddListener(ofEvents.touchUp, this, &Slider::touchUp);
	ofAddListener(ofEvents.touchMoved, this, &Slider::touchMoved);	
	enableAppEvents();	
}
void Slider::removeListeners(){
	ofRemoveListener(ofEvents.touchDown, this, &Slider::touchDown);
	ofRemoveListener(ofEvents.touchUp, this, &Slider::touchUp);
	ofRemoveListener(ofEvents.touchMoved, this, &Slider::touchMoved);
	disableAppEvents();	
}
void Slider::touchDown(ofTouchEventArgs &touch){
	if (touch.x > x && touch.x < width+x
		&& touch.y > y && touch.y < height+y) {
		hasTouch = true;
		currentTouch = touch.id;
		if (horizontal) {
			value = ofClamp((touch.x - x)/width, 0.0, 1.0);
		}else {
			value = ofClamp((touch.y - y)/height, 0.0, 1.0);
		}
		if (useData) {
			data = [NSNumber numberWithFloat:value];
		}
	}	
}
void Slider::touchMoved(ofTouchEventArgs &touch){
	if (hasTouch && currentTouch == touch.id) {
		if (horizontal) {
			value = ofClamp((touch.x - x)/width, 0.0, 1.0);
		}else{
			value = ofClamp((touch.y - y)/height, 0.0, 1.0);
		}
		if (useData) {
			data = [NSNumber numberWithFloat:value];
		}
	}	
}
void Slider::touchUp(ofTouchEventArgs &touch){
	if(currentTouch == touch.id){
		hasTouch = false;
	}	
}