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
	[newMovementButton setColor:0x277fb1];
	[newMovementButton setFontColor:0xFFFFFF];
	[newMovementButton setTitle:@"MOVEMENT"];
		
	newControlButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 102, 150, 45)]retain];
	[newControlButton setColor:0xd8b330];
	[newControlButton setFontColor:0xFFFFFF];
	[newControlButton setTitle:@"CONTROL"];
	
	displayMenu = false;
	
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
}
@end
