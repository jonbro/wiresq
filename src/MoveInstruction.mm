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
-(id)initWithFrame:(CGRect)_frame
{
	self = [self init];
	frame = _frame;
	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y-4, frame.size.width, 4)] forKey:@"topNode"];
	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 4)] forKey:@"bottomNode"];
	[self addSubview:[instructionNodes objectForKey:@"topNode"]];
	[self addSubview:[instructionNodes objectForKey:@"bottomNode"]];
	return self;
}
-(void)updateNodePositions
{
	for(NSString *nodeName in instructionNodes){
		CGRect subframe = [[instructionNodes objectForKey:nodeName] frame];
		subframe.origin.x = frame.origin.x;
		if([nodeName isEqualToString:@"topNode"]){
			subframe.origin.y = frame.origin.y-4;
		}
		if([nodeName isEqualToString:@"bottomNode"]){
			subframe.origin.y = frame.origin.y+frame.size.height;
		}
		[[instructionNodes objectForKey:nodeName] setFrame:subframe];
	}	
}
-(void)updateSubPositions
{
	CGRect nextInstructionFrame = nextInstruction.frame;
	nextInstructionFrame.origin.x = frame.origin.x;
	nextInstructionFrame.origin.y = frame.origin.y + frame.size.height;
	[nextInstruction setFrame:nextInstructionFrame];
	[nextInstruction updateSubPositions];
	[nextInstruction updateNodePositions];
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
}
-(void)touchUpX:(float)x Y:(float)y ID:(float)touchID
{
}
-(void) attachInstruction:(BaseInstruction*)incomingInstruction toNode:(ConnectionNode*)_node
{
	if(_node == [instructionNodes objectForKey:@"bottomNode"]){
		if(nextInstruction == nil){
			nextInstruction = [incomingInstruction retain];
			[self addSubview:nextInstruction];
			[childInstructions addObject:nextInstruction];
			[self removeSubview:[instructionNodes objectForKey:@"bottomNode"]];
			[instructionNodes removeObjectForKey:@"bottomNode"];
		}
	}
	[self updateSubPositions];
}
@end