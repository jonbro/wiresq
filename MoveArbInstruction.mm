//
//  MoveArbInstruction.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/22/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "MoveArbInstruction.h"


@implementation MoveArbInstruction
-(void)render
{
	drawRectSprite(0, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, 0, 0);
	drawRectSprite(0, frame.origin.x+12, frame.origin.y+18, 27, 12, 52, 54);
	[super render];
}
-(id)processTurtle:(Turtle*)_turtle
{
	[_turtle processArb:[amount intValue]];
	return nextInstruction;
}

@end
