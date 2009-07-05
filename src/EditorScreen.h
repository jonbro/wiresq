//
//  EditorScreen.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstructionSet.h"
#import "Vector2d.h"
#import "ofMain.h"
#import "MoveInstruction.h"
#import "GLButton.h"
#import "CGPointUtils.h"

@interface EditorScreen : CustomEventResponder <GLButtonDelegate> {
	InstructionSet *in_set;
	NSMutableArray *instructions;
	GLButton		*newNodeButton, *newMovementButton, *newControlButton;
	CGPoint			newNodePoint;
	id				currentInstruction;
	bool			displayMenu;
	ofTrueTypeFont	proFont;
}
-(void)render;
-(void)update;
@end
