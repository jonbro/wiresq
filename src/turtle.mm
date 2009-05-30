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

@implementation Turtle

@synthesize pos, dir;

-(id)init
{
	self = [super init];
	in_set = [[InstructionSet alloc] init];
	currentInstruction = [NSNumber numberWithInt:0];
	pos = [[Vector2d alloc] init];
	pos.x = 160.0;
	pos.y = 240.0;
	
	// add some new instructions to teh turtlezzzz :D
	
	
	return self;
}
-(void)update
{
	[iset processInstruction:[currentInstruction intValue] withTurtle:self];
	currentInstruction++;
}
-(void)render
{
	ofSetColor(255, 255, 255);
	ofCircle(pos.x,pos.y, 10);
}

@end
