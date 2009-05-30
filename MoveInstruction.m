//
//  MoveInstruction.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "MoveInstruction.h"


@implementation MoveInstruction

@synthesize amount, direction;

-(void)processTurtle:(Turtle*)_turtle
{
	if([direction isEqual:@"forward"]){
		[_turtle.pos add:[Vector2d mult:_turtle.dir amount:[amount floatValue]]];
	}else if([direction isEqual:@"left"]){
		[_turtle.dir rotate:[amount floatValue]];
	}
}

@end