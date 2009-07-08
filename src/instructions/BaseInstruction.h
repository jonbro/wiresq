//
//  BaseInstruction.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/4/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "CGPointUtils.h"
#import "ConnectionNode.h"

@class ConnectionNode;

@interface BaseInstruction : CustomEventResponder {
	NSMutableDictionary		*instructionNodes;
	NSMutableArray			*allInstructions;
	NSMutableArray			*childInstructions;
	CustomEventResponder	*editorScreen;
	ConnectionNode			*nearestNode;
}

@property(retain) NSMutableArray*			allInstructions;
@property(retain) NSMutableArray*			childInstructions;
@property(retain) CustomEventResponder*		editorScreen;
@property(readonly) NSMutableDictionary*	instructionNodes;

-(void)findNearestInstructionNode;
-(void)removeChildInstruction:(BaseInstruction*)_instruction;
-(void)updateNodePositions;
-(void)attachInstruction:(BaseInstruction*)incomingInstruction toNode:(NSObject*)_node;
-(void)updateSubPositions;

@end