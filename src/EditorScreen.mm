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

	editPane = [[[GLScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)]retain];	
	[self addSubview:editPane];

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
	
	newColorButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 198, 150, 45)]retain];
	newColorButton._delegate = self;
	[newColorButton setColor:0x277fb1];
	[newColorButton setFontColor:0xFFFFFF];
	[newColorButton setTitle:@"COLOR"];
	
	
	newColorShiftButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 246, 150, 45)]retain];
	newColorShiftButton._delegate = self;
	[newColorShiftButton setColor:0x277fb1];
	[newColorShiftButton setFontColor:0xFFFFFF];
	[newColorShiftButton setTitle:@"COLOR SHIFT"];

	newLineWidthButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 294, 150, 45)]retain];
	newLineWidthButton._delegate = self;
	[newLineWidthButton setColor:0x277fb1];
	[newLineWidthButton setFontColor:0xFFFFFF];
	[newLineWidthButton setTitle:@"WEIGHT"];
	
	newPitchMovementButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 342, 150, 45)]retain];
	newPitchMovementButton._delegate = self;
	[newPitchMovementButton setColor:0x277fb1];
	[newPitchMovementButton setFontColor:0xFFFFFF];
	[newPitchMovementButton setTitle:@"PITCH"];
	
	runButton = [[[GLButton alloc] initWithFrame:CGRectMake(54, 6, 100, 45)]retain];
	runButton._delegate = self;
	[runButton setColor:0x19954a];
	[runButton setFontColor:0xFFFFFF];
	[runButton setTitle:@"SAVE"];

	[self addSubview:runButton];
		
	displayMenu = false;
	
	instructions = [[NSMutableArray alloc]init];
		
	
	s_in = [[StartInstruction alloc]initWithFrame:CGRectMake(160, 240, 80, 40)];
	s_in.editorScreen = self;
	
	[editPane addSubview:s_in];
	[instructions addObject:s_in];
	
	
	newNodePoint = CGPointMake(160, 240);
	return self;
}
-(void)render
{	
	[_turtle runFirstInstruction:s_in];
	[super render];
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
			[self addSubview:newColorButton];
			[self addSubview:newColorShiftButton];
			[self addSubview:newLineWidthButton];
			[self addSubview:newPitchMovementButton];
			displayMenu = true;
			[newNodeButton setTitle:@"-"];
		}else{
			[self removeMenu];
		}
	}
	if(_button == newMovementButton){
		[self removeMenu];
		
		MoveUpInstruction *instruction = [[MoveUpInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 101, 53)];
		instruction.amount = [NSNumber numberWithInt:0];
		instruction.direction = [NSMutableString stringWithString:@"forward"];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		instruction.scrollPane = editPane;
		
		[instructions addObject:instruction];
		[editPane addSubview:instruction];		
	}
	if(_button == newLeftMovementButton){
		[self removeMenu];
		
		MoveLeftInstruction *instruction = [[MoveLeftInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 101, 53)];
		instruction.amount = [NSNumber numberWithInt:0];
		instruction.direction = [NSMutableString stringWithString:@"left"];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		instruction.scrollPane = editPane;
		
		[instructions addObject:instruction];
		[editPane addSubview:instruction];		
	}
	if(_button == newControlButton){
		[self removeMenu];
		
		RepeatInstruction *instruction = [[RepeatInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 137, 94)];
		instruction.counter = [NSNumber numberWithInt:0];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		instruction.scrollPane = editPane;
		[instructions addObject:instruction];
		[editPane addSubview:instruction];		
	}

	if(_button == newColorButton){
		[self removeMenu];
		
		ColorInstruction *instruction = [[ColorInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 101, 53)];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		instruction.scrollPane = editPane;
		[instructions addObject:instruction];
		[editPane addSubview:instruction];		
	}
	
	if(_button == newColorShiftButton){
		[self removeMenu];
		ColorShiftInstruction *instruction = [[ColorShiftInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 101, 53)];
		instruction.amount = [NSNumber numberWithInt:0];
		instruction.direction = [NSMutableString stringWithString:@"left"];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		instruction.scrollPane = editPane;
		[instructions addObject:instruction];
		[editPane addSubview:instruction];		
	}

	if(_button == newLineWidthButton){
		[self removeMenu];
		LineWeightInstruction *instruction = [[LineWeightInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 101, 53)];
		instruction.amount = [NSNumber numberWithInt:1];
		instruction.direction = [NSMutableString stringWithString:@"left"];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		instruction.scrollPane = editPane;
		[instructions addObject:instruction];
		[editPane addSubview:instruction];		
	}
	
	if(_button == newPitchMovementButton){
		[self removeMenu];
		MovePitchInstruction *instruction = [[MovePitchInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 101, 53)];
		instruction.amount = [NSNumber numberWithInt:1];
		instruction.direction = [NSMutableString stringWithString:@"left"];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		instruction.scrollPane = editPane;
		[instructions addObject:instruction];
		[editPane addSubview:instruction];		
	}
	
	
	if(_button == runButton){
		[_turtle save:s_in];
	}
}
-(void)removeMenu
{
	displayMenu = false;
	[self removeSubview:newControlButton];
	[self removeSubview:newMovementButton];
	[self removeSubview:newLeftMovementButton];
	[self removeSubview:newColorButton];
	[self removeSubview:newColorShiftButton];
	[self removeSubview:newLineWidthButton];
	[self removeSubview:newPitchMovementButton];
	[newNodeButton setTitle:@"+"];	
}
-(void)touchDoubleTap:(TouchEvent*)_tEvent
{
	_tEvent.currentTransform = editPane.currentTranslation;
	newNodePoint = CGPointMake(_tEvent.pos.x, _tEvent.pos.y);
}
@end
