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

@interface BaseInstruction : CustomEventResponder {
	NSMutableDictionary	*instructionNodes;
	NSMutableArray		*allInstructions;
}

@property(retain) NSMutableArray* allInstructions;
@property(readonly) NSMutableDictionary* instructionNodes;

-(void)findNearestInstructionNode;
-(void)updateNodePositions;
@end