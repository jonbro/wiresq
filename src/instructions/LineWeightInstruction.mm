//
//  LineWeightInstruction.m
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/18/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "LineWeightInstruction.h"


@implementation LineWeightInstruction

-(void)render{
	drawRectSprite(0, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, 0, 0);
	drawRectSprite(0, frame.origin.x+6, frame.origin.y+12, 26, 19, 26, 53);
	[super render];
}
-(id)processTurtle:(Turtle*)_turtle
{
	if([_turtle hasOverride]){
		[_turtle setLineWidth:[_turtle overRideVal]/10.0];
	}else{
		[_turtle setLineWidth:[amount floatValue]/10.0];
	}
	return nextInstruction;
}

@end
