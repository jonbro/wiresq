//
//  ForeverLoop.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/4/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "ForeverLoop.h"

@implementation ForeverLoop
-(void)render
{
	[colorScheme drawColor2];
	ofRect(frame.origin.x , frame.origin.y, frame.size.height, frame.size.width);
	[super render];	
}
@end
