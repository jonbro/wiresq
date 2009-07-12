//
//  EditorScreen.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "EditorScreen.h"
#import "colorScheme.h"
#ifdef TARGET_OPENGLES
	#include "glu.h"
#endif

@implementation EditorScreen
-(id)init
{
	self = [super init];
	frame = CGRectMake(0, 0, 320, 480);
	proFont.loadFont("ProFont.ttf", 14);

	_turtle = [[Turtle alloc]init];
	
	newNodeButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 6, 45, 45)]retain];
	newNodeButton._delegate = self;
	[newNodeButton setColor:0x19954a];
	[newNodeButton setFontColor:0xFFFFFF];
	[newNodeButton setTitle:@"+"];
	
	[self addSubview:newNodeButton];
	
	newMovementButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 54, 150, 45)]retain];
	newMovementButton._delegate = self;
	[newMovementButton setColor:0x277fb1];
	[newMovementButton setFontColor:0xFFFFFF];
	[newMovementButton setTitle:@"UP"];

	newLeftMovementButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 102, 150, 45)]retain];
	newLeftMovementButton._delegate = self;
	[newLeftMovementButton setColor:0x277fb1];
	[newLeftMovementButton setFontColor:0xFFFFFF];
	[newLeftMovementButton setTitle:@"LEFT"];
	
	
	newControlButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 150, 150, 45)]retain];
	newControlButton._delegate = self;
	[newControlButton setColor:0xd8b330];
	[newControlButton setFontColor:0xFFFFFF];
	[newControlButton setTitle:@"CONTROL"];
	
	runButton = [[[GLButton alloc] initWithFrame:CGRectMake(54, 6, 90, 45)]retain];
	runButton._delegate = self;
	[runButton setColor:0x19954a];
	[runButton setFontColor:0xFFFFFF];
	[runButton setTitle:@"RUN"];

	[self addSubview:runButton];
	
	displayMenu = false;
	
	instructions = [[NSMutableArray alloc]init];
	
	s_in = [[StartInstruction alloc]initWithFrame:CGRectMake(160, 240, 80, 40)];
	[self addSubview:s_in];
	[instructions addObject:s_in];
	
	newNodePoint = CGPointMake(160, 240);
	return self;
}
-(void)render
{	
	[super render];
	//render new node point helper
	ofSetColor(255, 0, 0);
	ofRect(newNodePoint.x-3, newNodePoint.y-3, 6, 6);
}
// gets rid of all the on screen editor helpers
-(void)removeEditors
{
	for(BaseInstruction* _instruction in instructions){
		[_instruction removeEditor];
	}
}
-(void)update
{
	[super update];
}
-(void)buttonDidPress:(GLButton *)_button
{
	if(_button == newNodeButton){
		if(!displayMenu){
			[self addSubview:newControlButton];
			[self addSubview:newMovementButton];
			[self addSubview:newLeftMovementButton];
			displayMenu = true;
			[newNodeButton setTitle:@"-"];
		}else{
			[self removeSubview:newControlButton];
			[self removeSubview:newMovementButton];
			[self removeSubview:newLeftMovementButton];
			displayMenu = false;
			[newNodeButton setTitle:@"+"];
		}
	}
	if(_button == newMovementButton){
		displayMenu = false;
		[self removeSubview:newControlButton];
		[self removeSubview:newMovementButton];
		[self removeSubview:newLeftMovementButton];
		[newNodeButton setTitle:@"+"];
		
		MoveUpInstruction *instruction = [[MoveUpInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 101, 53)];
		instruction.amount = [NSNumber numberWithInt:0];
		instruction.direction = [NSMutableString stringWithString:@"forward"];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		
		[instructions addObject:instruction];
		[self addSubview:instruction];		
	}
	if(_button == newLeftMovementButton){
		displayMenu = false;
		[self removeSubview:newControlButton];
		[self removeSubview:newMovementButton];
		[self removeSubview:newLeftMovementButton];
		[newNodeButton setTitle:@"+"];
		
		MoveLeftInstruction *instruction = [[MoveLeftInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 101, 53)];
		instruction.amount = [NSNumber numberWithInt:0];
		instruction.direction = [NSMutableString stringWithString:@"left"];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		
		[instructions addObject:instruction];
		[self addSubview:instruction];		
	}
	if(_button == runButton){
		[_turtle runFirstInstruction:s_in];
	}
}
-(void)touchDoubleTap:(TouchEvent*)_tEvent;
{
	newNodePoint = CGPointMake(_tEvent.x_pos, _tEvent.y_pos);
}
@end
