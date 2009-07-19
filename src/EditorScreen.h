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
#import "MoveUpInstruction.h"
#import "MoveLeftInstruction.h"
#import "MovePitchInstruction.h"
#import "ColorInstruction.h"
#import "ColorShiftInstruction.h"
#import "RepeatInstruction.h"
#import "LineWeightInstruction.h"

#import "StartInstruction.h"
#import "GLButton.h"
#import "GLScrollView.h"
#import "CGPointUtils.h"
#import "turtle.h"
#import "GLColorPickerView.h"

@interface EditorScreen : CustomEventResponder <GLButtonDelegate> {
	InstructionSet *in_set;
	NSMutableArray *instructions;
	GLScrollView	*editPane;
	GLButton		*newNodeButton, *newMovementButton, *newLeftMovementButton, *newPitchMovementButton, *newControlButton, *newColorButton, *newColorShiftButton, *newLineWidthButton, *runButton;
	StartInstruction *s_in;
	CGPoint			newNodePoint;
	Turtle			*_turtle;
	id				currentInstruction;
	bool			displayMenu;
	ofTrueTypeFont	proFont;
}
-(void)render;
-(void)update;
-(void)removeEditors;
-(void)removeMenu;
@end
