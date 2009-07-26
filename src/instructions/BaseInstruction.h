//
//  BaseInstruction.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/4/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "CGPointUtils.h"
#import "ConnectionNode.h"
#import "turtle.h"

@class ConnectionNode;
@class Turtle;

@interface BaseInstruction : CustomEventResponder {
	NSMutableDictionary		*instructionNodes;
	NSMutableArray			*allInstructions;
	NSMutableArray			*childInstructions;
	CustomEventResponder	*editorScreen;
	CustomEventResponder    *scrollPane;
	ConnectionNode			*nearestNode;
	BaseInstruction		*nextInstruction;
	BaseInstruction		*prevInstruction;
}
@property (retain) BaseInstruction*	prevInstruction;
@property (retain) BaseInstruction*	nextInstruction;
@property(retain) NSMutableArray*			allInstructions;
@property(retain) NSMutableArray*			childInstructions;
@property(retain) CustomEventResponder*		editorScreen;
@property(retain) CustomEventResponder*		scrollPane;
@property(readonly) NSMutableDictionary*	instructionNodes;

-(void)findNearestInstructionNode;
-(void)removeChildInstruction:(BaseInstruction*)_instruction;
-(void)updateNodePositions;
-(void)removeTopNode;
-(void)setPrevious:(BaseInstruction*)_prevInstruction;
-(void)removeEditor;
-(int)getHeight;
-(id)processTurtle:(Turtle*)_turtle;
-(void)attachNextInstruction:(BaseInstruction*)incomingInstruction;
-(void)attachInstruction:(BaseInstruction*)incomingInstruction toNode:(NSObject*)_node;
-(void)updateSubPositions;

@end