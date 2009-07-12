//
//  turtle.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "turtle.h"
#import "ofGraphics.h"
#import "InstructionSet.h"
#import "ofxiPhone.h"

@implementation Turtle

@synthesize pos, dir;

-(id)init
{
	self = [super init];
	in_set = [[InstructionSet alloc] init];
	currentInstruction = 0;

	pos = [[Vector2d alloc] init];
	pos.x = 160.0;
	pos.y = 240.0;

	dir = [[Vector2d alloc] init];
	dir.x = 0;
	dir.y = 1;
	
	return self;
}
-(void)update
{
	
}
-(void)render
{
	
}
-(void)runFirstInstruction:(BaseInstruction*)_currentInstruction
{
	pos.x = 160.0;
	pos.y = 240.0;
	// blank the background
	ofSetColor(0xFFFFFF);
	ofRect(0, 0, 320, 480);
	// run all of the instructions
	[self runInstruction:_currentInstruction];
	// save to the photo library
	iPhoneScreenGrab(self);
}
-(void)runInstruction:(BaseInstruction*)_currentInstruction
{
	currentInstruction = _currentInstruction;
	while(currentInstruction != nil)
	{
		currentInstruction = [currentInstruction processTurtle:self];
		ofSetColor(0x000000);
		ofCircle(pos.x,pos.y, 10);
	}
}
@end
