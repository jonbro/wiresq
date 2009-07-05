//
//  GLPickerView.m
//  rotator
//
//  Created by jonbroFERrealz on 5/31/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "ofMain.h"
#import "GLPickerView.h"
#import "TouchEvent.h"
#import "glHelper.h"
#import "Events.h"

@implementation GLPickerView

@synthesize _delegate, _dataSource;
-(id)init
{
	self = [super init];
	interstate.loadFont("ProFont.ttf", 14);
	return self;
}
-(void)update
{
	if(!fingerDown){
		selected = min(max(0, (int)round(floatSelected)), (int)[_dataSource numberOfRowsInPickerView:self]-1);
		floatSelected += (selected-floatSelected)/2; 
	}
}
-(void)render
{
	glEnable(GL_LIGHTING);
	glEnable(GL_DEPTH_TEST);
	[glHelper setupLighting];
	
	int slices = 12;
	
	selected = min(max(0, (int)round(floatSelected)), (int)[_dataSource numberOfRowsInPickerView:self]-1);
	
	int startingObject = selected - slices/2;
	
	float radius = frame.size.height/2;
	float theta = (PI / 180) * (360.0/(slices*2.0));
	
	glPushMatrix();
	// translate back to the center of the circle
	// and the proper position to start drawing
	glTranslatef(frame.origin.x, frame.origin.y+radius, -radius);
	//rotate to the back
	glRotatef(180+(360/slices)*(floatSelected-(float)selected), 1.0, 0, 0);
	
	glTranslatef(0, -sin(theta)*radius, radius);	
	for(int i=0; i<slices; i++) {
		int currentObject = startingObject+i;
		glPushMatrix();
		glTranslatef(0, sin(theta)*radius, -radius);
		glRotatef((360.0/slices)*-i, 1.0, 0, 0);
		glTranslatef(0, -sin(theta)*radius, radius);
		if(currentObject == selected){
			ofSetColor(60, 60, 90);
		}else{
			ofSetColor(200, 200, 210);
		}
		ofRect(0, 0, frame.size.width, sin(theta)*radius*2);
		if(currentObject == selected){
			ofSetColor(200, 200, 230);
		}else{
			ofSetColor(0, 0, 0);
		}
		if(currentObject>=0 && currentObject<[_dataSource numberOfRowsInPickerView:self]){
			glTranslatef(10, sin(theta)*radius, 3);
			interstate.drawString([[_delegate pickerView:self titleForRow:currentObject] UTF8String], 0, 0);
		}
		glPopMatrix();
	}
	glPopMatrix();
	glDisable(GL_DEPTH_TEST);
}
-(void)touchUp:(TouchEvent*)_tEvent
{
	fingerDown = false;
}
-(void)touchDown:(TouchEvent*)_tEvent;
{
	fingerStart = _tEvent.y_pos;
	fingerDown = true;
}
- (void)touchMoved:(TouchEvent*)_tEvent
{
	float moveAmt = fingerStart - _tEvent.y_pos;
	fingerStart = _tEvent.y_pos;
	int slices = 12;
	float theta = (PI / 180) * (360.0/(slices*2.0));
	float radius = 80;
	floatSelected += moveAmt/(theta*radius*2);	
}

@end