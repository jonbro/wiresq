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

@synthesize amount, direction, pos, prevInstruction;
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
	[self addSubview:[instructionNodes objectForKey:@"topNode"]];
	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 4)] forKey:@"bottomNode"];
	[self addSubview:[instructionNodes objectForKey:@"bottomNode"]];
	return self;
}
-(void)updateSubPositions
{
	[self updateNodePositions];
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
	ofRect(frame.origin.x , frame.origin.y, frame.size.width, frame.size.height);
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
-(void)touchMoved:(TouchEvent*)_tEvent
{
	if(superview != editorScreen){
		[(BaseInstruction*)superview removeChildInstruction:self];
		[prevInstruction release];
		prevInstruction = nil;
		[editorScreen addSubview:self];		
	}
	[super touchMoved:_tEvent];
}
-(void)removeChildInstruction:(BaseInstruction*)_instruction
{
	if(_instruction == nextInstruction){
		[childInstructions removeObject:_instruction];
		[nextInstruction release];
		[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 4)] forKey:@"bottomNode"];
		[self addSubview:[instructionNodes objectForKey:@"bottomNode"]];
		nextInstruction = nil;
	}
}
-(void)attachInstruction:(BaseInstruction*)incomingInstruction
{
	[nextInstruction release];
	nextInstruction = [incomingInstruction retain];
	[incomingInstruction setPrevious:self];
	[self addSubview:nextInstruction];
	[childInstructions addObject:nextInstruction];
	[self removeSubview:[instructionNodes objectForKey:@"bottomNode"]];
	[instructionNodes removeObjectForKey:@"bottomNode"];
	[self updateSubPositions];
}
-(void)setPrevious:(BaseInstruction*)_prevInstruction
{
	[prevInstruction release];
	prevInstruction = [_prevInstruction retain];
}
-(void)attachInstruction:(BaseInstruction*)incomingInstruction toNode:(ConnectionNode*)_node
{
	if(_node == [instructionNodes objectForKey:@"bottomNode"]){
		[self attachInstruction:incomingInstruction];
	}else if(_node == [instructionNodes objectForKey:@"topNode"]){
		CGRect incomingInstructionFrame = incomingInstruction.frame;
		incomingInstructionFrame.origin.x = frame.origin.x;
		incomingInstructionFrame.origin.y = frame.origin.y - incomingInstructionFrame.size.height;
		[incomingInstruction setFrame:incomingInstructionFrame];
		if(prevInstruction != nil){
			[prevInstruction attachInstruction:incomingInstruction];
		}
		[incomingInstruction attachInstruction:self];
	}
	_node.incomingInstruction = nil;
}
@end