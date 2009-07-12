//
//  MoveInstruction.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "turtle.h"
#import "Vector2d.h"
#import "ofMain.h"
#import "GLPickerView.h"
#import "GLValuePickerView.h"
#import "BaseInstruction.h"
#import "connectionNode.h"

@interface MoveInstruction : BaseInstruction <GLPickerViewDelegate, GLPickerViewDataSource, GLValuePickerViewDelegate> {
	NSNumber*			amount;
	NSMutableString*	direction;
	float				currentRotation;
	Vector2d*			pos;
	GLValuePickerView	*magnitudePicker;
	NSMutableArray		*directionOptions;
	bool				showingEditor;
}

@property (retain) NSNumber*			amount;
@property (copy) NSMutableString*	direction;
@property (retain) Vector2d*		pos;

-(void)processTurtle:(id)_turtle;
-(void)setPrevious:(BaseInstruction*)_prevInstruction;
-(void)render;
-(void)activateEditor;

@end