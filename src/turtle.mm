//
//  turtle.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "turtle.h"
#import "ofGraphics.h"

@implementation Turtle
@synthesize iset;
-(id)init
{
	self = [super init];
	iset = [[InstructionSet alloc] init];
	currentInstruction = [NSNumber numberWithInt:0];
	pos = [[Vector2d alloc] init];
	pos.x = 160.0;
	pos.y = 240.0;
	return self;
}
-(void)update
{
	
}
-(void)render
{
	ofSetColor(255, 255, 255);
	ofCircle(pos.x,pos.y, 10);
}

@end
