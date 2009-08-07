//
//  InstructionSet.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "InstructionSet.h"
#import "turtle.h"

@implementation InstructionSet

@synthesize instructions;

-(id)init
{
	self = [super init];
	instructions = [[NSMutableArray alloc]initWithCapacity:1];
	return self;
}
-(void)processInstruction:(int)_instructionCounter withTurtle:(Turtle*)_turtle
{
	_instructionCounter = fmod(_instructionCounter, (int)[instructions count]);
	[[instructions objectAtIndex:_instructionCounter]processTurtle:_turtle];
}
@end
