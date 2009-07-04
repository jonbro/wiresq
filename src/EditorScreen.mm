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
	displayMenu = false;
	touchingInstruction = false;
	fingerPos = [[Vector2d alloc] initWithX:0 Y:0];
	fingerDownPos = [[Vector2d alloc] initWithX:0 Y:0];
	fingerCounter = 0;
	frame = CGRectMake(0, 0, 320, 480);
	proFont.loadFont("ProFont.ttf", 14);
	
	newNodeButton = [[GLButton alloc] initWithFrame:CGRectMake(6, 6, 45, 45)];
	[newNodeButton setColor:0x19954a];
	[newNodeButton setFontColor:0xFFFFFF];
	[newNodeButton setTitle:@"+"];
	
	[self addSubview:newNodeButton];
	
	newMovementButton = [[GLButton alloc] initWithFrame:CGRectMake(6, 54, 150, 45)];
	[newMovementButton setColor:0x277fb1];
	[newMovementButton setFontColor:0xFFFFFF];
	[newMovementButton setTitle:@"MOVEMENT"];
		
	newControlButton = [[GLButton alloc] initWithFrame:CGRectMake(6, 102, 150, 45)];
	[newControlButton setColor:0xd8b330];
	[newControlButton setFontColor:0xFFFFFF];
	[newControlButton setTitle:@"CONTROL"];
		
	instructions = [[NSMutableArray alloc]init];
	return self;
}
-(void)render
{
	[super render];
}
-(void)update
{
	[super update];
}

@end
