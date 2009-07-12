//
//  MoveUpInstruction.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/12/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "MoveUpInstruction.h"
#import "globals.h"


@implementation MoveUpInstruction

-(void)render
{
	[super render];
	drawRectSprite(0, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, 0, 0);
	drawRectSprite(0, frame.origin.x+12, frame.origin.y+18, 15, 13, 101, 15);
}

@end