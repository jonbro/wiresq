//
//  repeatInstruction.m
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/13/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
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
	tmpCounter = 0;
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
-(void)removeChildInstruction:(BaseInstruction*)_instruction
{
	if(_instruction == innerInstruction){
		[childInstructions removeObject:_instruction];
		[innerInstruction release];
		[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x+20, frame.origin.y+47, frame.size.width, 4)] forKey:@"innerNode"];
		[self addSubview:[instructionNodes objectForKey:@"innerNode"]];
		innerInstruction = nil;
	}
	[super removeChildInstruction:_instruction];
}

-(id)processTurtle:(Turtle*)_turtle
{
	tmpCounter = 0;
	int thisCounter = [counter intValue];
	if([_turtle hasOverride]){
		thisCounter = [_turtle overRideVal];
	}
	while(tmpCounter < thisCounter){
		tmpInnerInstruction = [innerInstruction processTurtle:_turtle];
		while(tmpInnerInstruction != nil){
			tmpInnerInstruction = [tmpInnerInstruction processTurtle:_turtle];
		}
		tmpCounter++;
	}
	return nextInstruction;
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
		if(innerInstruction != nil){
			[incomingInstruction attachNextInstruction:innerInstruction];
		}
		[innerInstruction release];
		innerInstruction = [incomingInstruction retain];
		[innerInstruction removeTopNode];
		[self addSubview:innerInstruction];
		[innerInstruction setPrevious:self];
		[childInstructions addObject:innerInstruction];
		[self updateSubPositions];
		_node.incomingInstruction = nil;
	}else{
		[super attachInstruction:incomingInstruction toNode:_node];
	}
}
-(void)activateEditor
{
	[editorScreen removeEditors];
	showingEditor = true;
	[editorScreen addSubview:counterPicker];
}
-(void)removeEditor
{
	if(showingEditor){
		[editorScreen removeSubview:counterPicker];
		showingEditor = false;
	}
}
-(void)updateSubPositions
{
	int innerHeight = [innerInstruction getHeight];
	frame.size.height =  55+innerHeight-10+34;
	[super updateSubPositions];
	CGRect nextInstructionFrame = innerInstruction.frame;
	nextInstructionFrame.origin.x = frame.origin.x + 19;
	nextInstructionFrame.origin.y = frame.origin.y + 46;
	[innerInstruction setFrame:nextInstructionFrame];
	[self updateNodePositions];
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
-(void)touchDoubleTap:(TouchEvent*)_tEvent
{
	if(!showingEditor){
		[self activateEditor];
	}
}
-(void)render
{
	drawRectSprite(1, frame.origin.x, frame.origin.y, 137, 55, 0, 0);
	if(innerInstruction != nil){
		int innerHeight = [innerInstruction getHeight];
		frame.size.height = 55+innerHeight-10+34;
		drawRectSprite(1, frame.origin.x, frame.origin.y+55, 137, 6, 0, 55, 137, innerHeight-10);
		drawRectSprite(1, frame.origin.x, frame.origin.y+55+innerHeight-10, 137, 34, 0, 61);
	}else{
		drawRectSprite(1, frame.origin.x, frame.origin.y+55, 137, 40, 0, 55);		
	}
	glPushMatrix();
	glTranslatef(frame.origin.x+123-interstate11.stringWidth([[counter stringValue] UTF8String]), frame.origin.y+27, 0);
	ofSetColor(0x000000);
	interstate11.drawString([[counter stringValue] UTF8String], 0, 0);
	glPopMatrix();
	[super render];
}
@end
