//
//  MoveLeftInstrution.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/12/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "MoveLeftInstruction.h"


@implementation MoveLeftInstruction
-(void)render
{
	drawRectSprite(0, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, 0, 0);
	drawRectSprite(0, frame.origin.x+12, frame.origin.y+18, 15, 13, 101, 0);
	[super render];
}
-(id)processTurtle:(Turtle*)_turtle
{
	if([_turtle hasOverride]){
		_turtle.dir3->rotate(0, 0, [_turtle overRideVal]);		
	}else{
		_turtle.dir3->rotate(0, 0, [amount floatValue]);
	}
	[_turtle.dir rotate:[amount floatValue]];
	return nextInstruction;
}

@end
