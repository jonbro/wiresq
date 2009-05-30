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
	currentInstruction = 0;
	pos = [[Vector2d alloc] init];
	pos.x = 160.0;
	pos.y = 240.0;

	dir = [[Vector2d alloc] init];
	dir.x = 0;
	dir.y = 1;
	
	// add some new instructions to teh turtlezzzz :D
	MoveInstruction *m_instruction1 = [[MoveInstruction alloc]init];
	m_instruction1.amount = [NSNumber numberWithInt:20];
	m_instruction1.direction = [NSMutableString stringWithString:@"forward"];
	
	MoveInstruction *m_instruction2 = [[MoveInstruction alloc]init];
	m_instruction2.amount = [NSNumber numberWithInt:20];
	m_instruction2.direction = [NSMutableString stringWithString:@"left"];

	[in_set.instructions addObject:m_instruction1];
	[in_set.instructions addObject:m_instruction2];
	
	
	return self;
}
-(void)update
{
	[in_set processInstruction:currentInstruction withTurtle:self];
	currentInstruction++;
}
-(void)render
{
	ofSetColor(255, 255, 255);
	ofCircle(pos.x,pos.y, 10);
}

@end
