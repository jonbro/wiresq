//
//  connectionNode.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/5/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "BaseInstruction.h"

@interface ConnectionNode : CustomEventResponder {
	BaseInstruction *incomingInstruction;
}

@property (retain) BaseInstruction* incomingInstruction;

@end