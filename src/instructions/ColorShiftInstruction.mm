//
//  ColorShiftInstruction.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/18/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "ColorShiftInstruction.h"


@implementation ColorShiftInstruction

-(void)render
{
	drawRectSprite(0, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, 0, 0);
	drawRectSprite(0, frame.origin.x+6, frame.origin.y+12, 26, 26, 0, 53);
	[super render];
}
-(id)processTurtle:(Turtle*)_turtle
{
	[_turtle.currentColor setHue:(int)(_turtle.currentColor.hue+[amount floatValue])%360];
	return nextInstruction;
}

@end
