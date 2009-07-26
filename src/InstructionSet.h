//
//  InstructionSet.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 5/26/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstructionSet : NSObject {
	NSMutableArray* instructions;
}

@property (retain) NSMutableArray* instructions;

-(void)processInstruction:(int)_instructionCounter withTurtle:(id)_turtle;
@end
