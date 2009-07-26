//
//  connectionNode.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/5/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "BaseInstruction.h"

@class BaseInstruction;

@interface ConnectionNode : CustomEventResponder {
	BaseInstruction *incomingInstruction;
}

@property (assign) BaseInstruction* incomingInstruction;

-(void)attachIncomingInstruction;

@end