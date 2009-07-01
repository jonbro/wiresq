//
//  InstructionSet.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstructionSet : NSObject {
	NSMutableArray* instructions;
}

@property (retain) NSMutableArray* instructions;

-(void)processInstruction:(int)_instructionCounter withTurtle:(id)_turtle;
-(void)renderEditor;
-(void)activateEditor;
@end
