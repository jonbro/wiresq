//
//  repeatInstruction.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/13/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "RepeatInstruction.h"
#import "MoveInstruction.h"
#import "ofMain.h"
#import "colorScheme.h"
#ifdef TARGET_OPENGLES
	#include "glu.h"
#endif
#import "globals.h"


@implementation RepeatInstruction

@synthesize counter;

-(id)init
{
	self = [super init];
	counterPicker = [[GLValuePickerView alloc] initWithFrame:CGRectMake(0, 380, 320, 100)];
	counterPicker._delegate = self;
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

	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x+20, frame.origin.y+47, frame.size.width, 4)] forKey:@"innerNode"];
	[self addSubview:[instructionNodes objectForKey:@"innerNode"]];
	
	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 4)] forKey:@"bottomNode"];
	[self addSubview:[instructionNodes objectForKey:@"bottomNode"]];
	
	return self;
}
-(void)pickerView:(GLValuePickerView *)pickerView didSelectValue:(NSInteger)_value
{
	if(pickerView == counterPicker){
		[counter release];
		counter = [[NSNumber numberWithInt:_value]retain];
	}
}
-(void)attachInstruction:(BaseInstruction*)incomingInstruction toNode:(ConnectionNode*)_node
{
	if(_node == [instructionNodes objectForKey:@"innerNode"]){
		[innerInstruction release];
		innerInstruction = [incomingInstruction retain];
		[self addSubview:innerInstruction];
		[childInstructions addObject:innerInstruction];
		[self removeSubview:[instructionNodes objectForKey:@"innerNode"]];
		[instructionNodes removeObjectForKey:@"innerNode"];
		[self updateSubPositions];
		_node.incomingInstruction = nil;
	}else{
		[super attachInstruction:incomingInstruction toNode:_node];
	}
}
-(void)updateSubPositions
{
	int innerHeight = [innerInstruction getHeight];
	frame.size.height = innerHeight+78;
	[super updateSubPositions];
	CGRect nextInstructionFrame = innerInstruction.frame;
	nextInstructionFrame.origin.x = frame.origin.x + 19;
	nextInstructionFrame.origin.y = frame.origin.y + 46;
	[innerInstruction setFrame:nextInstructionFrame];
	[innerInstruction updateSubPositions];
	[innerInstruction updateNodePositions];
}
-(void)updateNodePositions
{
	CGRect innerNodeFrame = [[instructionNodes objectForKey:@"innerNode"] frame];
	innerNodeFrame.origin.x = frame.origin.x + 20;
	innerNodeFrame.origin.y = frame.origin.y + 47;	
	[[instructionNodes objectForKey:@"innerNode"] setFrame:innerNodeFrame];
	[super updateNodePositions];
}

-(void)render
{
	drawRectSprite(1, frame.origin.x, frame.origin.y, 137, 55, 0, 0);
	if(innerInstruction != nil){
		int innerHeight = [innerInstruction getHeight];
		frame.size.height = innerHeight+78;
		drawRectSprite(1, frame.origin.x, frame.origin.y+55, 137, 6, 0, 55, 137, innerHeight-10);
		drawRectSprite(1, frame.origin.x, frame.origin.y+55+innerHeight-10, 137, 34, 0, 61);
	}else{
		drawRectSprite(1, frame.origin.x, frame.origin.y+55, 137, 40, 0, 55);		
	}
	[super render];
}
@end
