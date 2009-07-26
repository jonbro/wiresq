//
//  StartInstruction.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/7/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "StartInstruction.h"


@implementation StartInstruction
-(id)initWithFrame:(CGRect)_frame
{
	self = [self init];
	frame = _frame;
	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 4)] forKey:@"bottomNode"];
	[self addSubview:[instructionNodes objectForKey:@"bottomNode"]];
	return self;
}
-(void)render
{
	ofSetColor(0xd7b02e);
	ofRect(frame.origin.x , frame.origin.y, frame.size.width, frame.size.height);
	[super render];
}
@end
