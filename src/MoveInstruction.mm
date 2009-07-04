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

@implementation MoveInstruction

@synthesize amount, direction, pos;
-(id)init
{
	self = [super init];
	currentRotation = 0;
	directionOptions = [[NSMutableArray alloc] initWithObjects:@"FRWRD", @"BCKWRD", @"LFT", @"RGHT", nil];
	
	directionPicker = [[GLPickerView alloc] initWithFrame:CGRectMake(0, 380, 100, 100)];
	directionPicker._delegate = self;
	directionPicker._dataSource = self;
	
	magnitudePicker = [[GLValuePickerView alloc] initWithFrame:CGRectMake(100, 380, 220, 100)];
	
	showingEditor = false;
	return self;
}
-(void)processTurtle:(Turtle*)_turtle
{
	if([direction isEqual:@"forward"]){
		[_turtle.pos add:[Vector2d mult:_turtle.dir amount:[amount floatValue]]];
	}else if([direction isEqual:@"left"]){
		[_turtle.dir rotate:[amount floatValue]];
	}
}
-(void)activateEditor
{
	showingEditor = true;
	[self addSubview:directionPicker];
	[self addSubview:magnitudePicker];
}
-(void)render
{
	[colorScheme drawColor2];
	ofRect(frame.origin.x , frame.origin.y, frame.size.height, frame.size.width);
	[super render];
}
-(NSString*)pickerView:(GLPickerView*)pickerView titleForRow:(NSInteger)row
{
	return [directionOptions objectAtIndex:row];
}
-(NSInteger)numberOfRowsInPickerView:(GLPickerView*)pickerView
{
	return [directionOptions count];
}
-(void)touchDown:(TouchEvent*)_tEvent
{
	[self activateEditor];
}
-(void)touchUpX:(float)x Y:(float)y ID:(float)touchID
{
}

@end