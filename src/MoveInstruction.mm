//
//  MoveInstruction.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "MoveInstruction.h"
#import "ofMain.h"
#import "colorScheme.h"
#ifdef TARGET_OPENGLES
	#include "glu.h"
#endif
#import "globals.h"

@implementation MoveInstruction

@synthesize amount, direction, pos;
-(id)init
{
	self = [super init];
	currentRotation = 0;
	
	magnitudePicker = [[GLValuePickerView alloc] initWithFrame:CGRectMake(0, 380, 320, 100)];
	magnitudePicker._delegate = self;
	interstate11.loadFont("ProFont.ttf", 11);
	showingEditor = false;
	return self;
}
-(id)initWithFrame:(CGRect)_frame
{
	self = [self init];
	frame = _frame;
	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y-4, frame.size.width, 4)] forKey:@"topNode"];
	[self addSubview:[instructionNodes objectForKey:@"topNode"]];
	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 4)] forKey:@"bottomNode"];
	[self addSubview:[instructionNodes objectForKey:@"bottomNode"]];
	return self;
}
-(void)activateEditor
{
	[editorScreen removeEditors];
	showingEditor = true;
	[editorScreen addSubview:magnitudePicker];
}
-(void)removeEditor
{
	if(showingEditor){
		[editorScreen removeSubview:magnitudePicker];
		showingEditor = false;
	}
}
-(void)render
{
	glPushMatrix();
	glTranslatef(frame.origin.x+89-interstate11.stringWidth([[amount stringValue] UTF8String]), frame.origin.y+27, 0);
	ofSetColor(0x000000);
	interstate11.drawString([[amount stringValue] UTF8String], 0, 0);
	glPopMatrix();
	[super render];
}
-(void)touchDoubleTap:(TouchEvent*)_tEvent
{
	if(!showingEditor){
		[self activateEditor];
	}
}
-(void)pickerView:(GLValuePickerView *)pickerView didSelectValue:(NSInteger)_value
{
	if(pickerView == magnitudePicker){
		[amount release];
		amount = [[NSNumber numberWithInt:_value]retain];
	}
}
@end