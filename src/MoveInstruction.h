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

@interface MoveInstruction : BaseInstruction <GLPickerViewDelegate, GLPickerViewDataSource> {
	NSNumber*			amount;
	NSMutableString*	direction;
	float				currentRotation;
	ofTrueTypeFont		interstate;
	Vector2d*			pos;
	GLPickerView		*directionPicker;
	GLValuePickerView	*magnitudePicker;
	NSMutableArray		*directionOptions;
	bool				showingEditor;
	BaseInstruction		*nextInstruction;
	BaseInstruction		*prevInstruction;
}

@property (copy) NSNumber*			amount;
@property (retain) BaseInstruction*	prevInstruction;
@property (copy) NSMutableString*	direction;
@property (retain) Vector2d*		pos;

-(void)processTurtle:(id)_turtle;
-(void)setPrevious:(BaseInstruction*)_prevInstruction;
-(void)attachInstruction:(BaseInstruction*)incomingInstruction;
-(void)render;
-(void)activateEditor;

@end