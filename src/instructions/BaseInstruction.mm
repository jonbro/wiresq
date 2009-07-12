//
//  BaseInstruction.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/4/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "BaseInstruction.h"

@implementation BaseInstruction
@synthesize instructionNodes, allInstructions, editorScreen, childInstructions, prevInstruction;

-(id)init
{
	self = [super init];
	instructionNodes = [[NSMutableDictionary alloc] initWithCapacity:2];
	childInstructions = [[NSMutableArray alloc]initWithCapacity:0];
	return self;
}

-(void)touchMoved:(TouchEvent*)_tEvent
{
	frame.origin.x += _tEvent.x_pos - _tEvent.prevTouch.x_pos;
	frame.origin.y += _tEvent.y_pos - _tEvent.prevTouch.y_pos;
	[self updateNodePositions];
	[self updateSubPositions];
	[self findNearestInstructionNode];
}
-(void)touchUp:(TouchEvent*)_tEvent
{
	if(nearestNode.incomingInstruction == self){
		[nearestNode attachIncomingInstruction];
	}
}
-(void)findNearestInstructionNode
{
	CGFloat lowestDistance = 0;
	bool firstFound = false;
	for(BaseInstruction *instruction in allInstructions){
		if(instruction != self && [childInstructions indexOfObject:instruction] == NSNotFound){
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
-(void)attachNextInstruction:(BaseInstruction*)incomingInstruction
{
	[nextInstruction release];
	nextInstruction = [incomingInstruction retain];
	[incomingInstruction setPrevious:self];
	[self addSubview:nextInstruction];
	[childInstructions addObject:nextInstruction];
	[self removeSubview:[instructionNodes objectForKey:@"bottomNode"]];
	[instructionNodes removeObjectForKey:@"bottomNode"];
	[self updateSubPositions];
}
-(void)attachInstruction:(BaseInstruction*)incomingInstruction toNode:(ConnectionNode*)_node
{
	if(_node == [instructionNodes objectForKey:@"bottomNode"]){
		[self attachNextInstruction:incomingInstruction];
	}else if(_node == [instructionNodes objectForKey:@"topNode"]){
		CGRect incomingInstructionFrame = incomingInstruction.frame;
		incomingInstructionFrame.origin.x = frame.origin.x;
		incomingInstructionFrame.origin.y = frame.origin.y - incomingInstructionFrame.size.height;
		[incomingInstruction setFrame:incomingInstructionFrame];
		if(prevInstruction != nil){
			[prevInstruction attachNextInstruction:incomingInstruction];
		}
		[incomingInstruction attachNextInstruction:self];
	}
	_node.incomingInstruction = nil;
}
-(void)removeEditor
{
}
-(void)updateNodePositions
{
	for(NSString *nodeName in instructionNodes){
		CGRect subframe = [[instructionNodes objectForKey:nodeName] frame];
		subframe.origin.x = frame.origin.x;
		if([nodeName isEqualToString:@"topNode"]){
			subframe.origin.y = frame.origin.y-4;
		}
		if([nodeName isEqualToString:@"bottomNode"]){
			subframe.origin.y = frame.origin.y+frame.size.height;
		}
		[[instructionNodes objectForKey:nodeName] setFrame:subframe];
	}
}
-(void)updateSubPositions
{
	[self updateNodePositions];
	CGRect nextInstructionFrame = nextInstruction.frame;
	nextInstructionFrame.origin.x = frame.origin.x;
	nextInstructionFrame.origin.y = frame.origin.y + frame.size.height - 7;
	[nextInstruction setFrame:nextInstructionFrame];
	[nextInstruction updateSubPositions];
	[nextInstruction updateNodePositions];
}
-(void)removeChildInstruction:(BaseInstruction*)_instruction
{
		// to be overridden in subclasses
}
@end
