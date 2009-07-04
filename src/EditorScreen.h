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

@interface EditorScreen : CustomEventResponder {
	InstructionSet *in_set;
	NSMutableArray *instructions;
	GLButton		*newNodeButton, *newMovementButton, *newControlButton;
	id				currentInstruction;
	int				fingerTimer;
	bool			displayMenu;
	bool			touchingInstruction;
	Vector2d*		fingerPos;
	Vector2d*		fingerDownPos;
	int				fingerCounter;
	ofTrueTypeFont	proFont;
}
-(void)render;
-(void)update;
@end
