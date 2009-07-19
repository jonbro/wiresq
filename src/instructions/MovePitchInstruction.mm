//
//  MoveLeftInstrution.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/12/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "MovePitchInstruction.h"


@implementation MovePitchInstruction
-(void)render
{
	drawRectSprite(0, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, 0, 0);
	[super render];
}
-(id)processTurtle:(Turtle*)_turtle
{
	_turtle.dir3->rotate(0.0, [amount floatValue], 0.0);
	[_turtle.dir rotate:[amount floatValue]];
	return nextInstruction;
}

@end
