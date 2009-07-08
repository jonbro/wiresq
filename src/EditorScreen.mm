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
	[newMovementButton setTitle:@"MOVEMENT"];
		
	newControlButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 102, 150, 45)]retain];
	newControlButton._delegate = self;
	[newControlButton setColor:0xd8b330];
	[newControlButton setFontColor:0xFFFFFF];
	[newControlButton setTitle:@"CONTROL"];
	
	displayMenu = false;
	
	instructions = [[NSMutableArray alloc]init];
	
	StartInstruction *s_in = [[StartInstruction alloc]initWithFrame:CGRectMake(160, 240, 80, 40)];
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
			displayMenu = true;
			[newNodeButton setTitle:@"-"];
		}else{
			[self removeSubview:newControlButton];
			[self removeSubview:newMovementButton];
			displayMenu = false;
			[newNodeButton setTitle:@"+"];
		}
	}
	if(_button == newMovementButton){
		displayMenu = false;
		[self removeSubview:newControlButton];
		[self removeSubview:newMovementButton];
		[newNodeButton setTitle:@"+"];
		MoveInstruction *instruction = [[MoveInstruction alloc]initWithFrame:CGRectMake(newNodePoint.x, newNodePoint.y, 40, 40)];
		instruction.amount = [NSNumber numberWithInt:20];
		instruction.direction = [NSMutableString stringWithString:@"forward"];
		instruction.allInstructions = instructions;
		instruction.editorScreen = self;
		[instructions addObject:instruction];
		[self addSubview:instruction];		
	}
}
-(void)touchDoubleTap:(TouchEvent*)_tEvent;
{
	newNodePoint = CGPointMake(_tEvent.x_pos, _tEvent.y_pos);
}
@end
