//
//  BaseInstruction.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/4/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "BaseInstruction.h"
#import "ConnectionNode.h"


@implementation BaseInstruction
@synthesize instructionNodes, allInstructions;

-(id)init
{
	self = [super init];
	instructionNodes = [[NSMutableDictionary alloc] initWithCapacity:2];
	return self;
}

-(void)touchMoved:(TouchEvent*)_tEvent
{
	frame.origin.x += _tEvent.x_pos - _tEvent.prevTouch.x_pos;
	frame.origin.y += _tEvent.y_pos - _tEvent.prevTouch.y_pos;
	[self updateNodePositions];
	[self findNearestInstructionNode];
}
-(void)findNearestInstructionNode
{
	CGFloat lowestDistance = 0;
	ConnectionNode *nearestNode;
	bool firstFound = false;
	for(BaseInstruction *instruction in allInstructions){
		if(instruction != self){
			for(NSString *nodeName in instruction.instructionNodes){
				ConnectionNode *node = [instruction.instructionNodes objectForKey:nodeName];
				node.incomingInstruction = nil;
				if(!firstFound){
					nearestNode = node;
					lowestDistance = ccpDistance(node.frame.origin, self.frame.origin);
					firstFound = true;
				}else{
					if(lowestDistance > ccpDistance(node.frame.origin, self.frame.origin)){
						nearestNode = node;
						lowestDistance = ccpDistance(node.frame.origin, self.frame.origin);					
					}
				}
			}
		}
	}
	if(firstFound && lowestDistance < 50){
		nearestNode.incomingInstruction = self;
	}
}
-(void)updateNodePositions
{
	// placeholder...
}
@end
