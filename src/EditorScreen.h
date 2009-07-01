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

@interface EditorScreen : CustomEventResponder {
	InstructionSet *in_set;
	NSMutableArray *instructions;
	id				currentInstruction;
	int				fingerTimer;
	bool			displayMenu;
	bool			touchingInstruction;
	Vector2d*		fingerPos;
	Vector2d*		fingerDownPos;
	int				fingerCounter;
	ofTrueTypeFont	interstate;
}
-(void)render;
-(void)update;
-(void)touchDownX:(float)x Y:(float)y ID:(float)touchID;
-(void)touchMoveX:(float)x Y:(float)y ID:(float)touchID;
-(void)touchUpX:(float)x Y:(float)y ID:(float)touchID;
@end
