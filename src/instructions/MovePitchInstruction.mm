//
//  MoveLeftInstrution.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/12/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
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
	if([_turtle hasOverride]){
		_turtle.dir3->rotate([_turtle overRideVal], 0.0, 0.0);
	}else{
		_turtle.dir3->rotate([amount floatValue], 0.0, 0.0);
	}
	[_turtle.dir rotate:[amount floatValue]];
	return nextInstruction;
}

@end
