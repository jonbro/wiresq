//
//  BaseInstruction.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/4/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "BaseInstruction.h"

@implementation BaseInstruction
@synthesize instructionNodes, allInstructions, editorScreen, scrollPane, childInstructions, prevInstruction, nextInstruction;

-(id)init
{
	self = [super init];
	instructionNodes = [[NSMutableDictionary alloc] initWithCapacity:2];
	childInstructions = [[NSMutableArray alloc]initWithCapacity:0];
	return self;
}

-(void)touchMoved:(TouchEvent*)_tEvent
{
	frame.origin.x += _tEvent.pos.x - _tEvent.prevTouch.x_pos;
	frame.origin.y += _tEvent.pos.y - _tEvent.prevTouch.y_pos;
	// disconnect from the previous instruction
	if(prevInstruction != nil){
		[superview removeChildInstruction:self];
		[prevInstruction release];
		prevInstruction = nil;
		[scrollPane addSubview:self];		
	}	
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
-(void)removeChildInstruction:(BaseInstruction*)_instruction
{
	if(_instruction == nextInstruction){
		[childInstructions removeObject:_instruction];
		[nextInstruction release];
		[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 4)] forKey:@"bottomNode"];
		[self addSubview:[instructionNodes objectForKey:@"bottomNode"]];
		nextInstruction = nil;
	}
}
-(id)processTurtle:(Turtle*)_turtle
{
	return self.nextInstruction;
}
-(void)setPrevious:(BaseInstruction*)_prevInstruction
{
	[prevInstruction release];
	prevInstruction = [_prevInstruction retain];
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
// returns the height of this instruction + all of its sub nodes
-(int)getHeight
{
	if(nextInstruction == nil){
		return frame.size.height - 7; // this is because of the little nubbin on the bottom, only applies to single nodes
	}else{
		return frame.size.height - 7 + [nextInstruction getHeight];
	}
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
		if([nodeName isEqualToString:@"topNode"]){
			subframe.origin.y = frame.origin.y-4;
			subframe.origin.x = frame.origin.x;
		}
		if([nodeName isEqualToString:@"bottomNode"]){
			subframe.origin.y = frame.origin.y+frame.size.height;
			subframe.origin.x = frame.origin.x;
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
@end
