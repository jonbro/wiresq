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

@interface MoveInstruction : CustomEventResponder <GLPickerViewDelegate, GLPickerViewDataSource> {
	NSNumber*			amount;
	NSMutableString*	direction;
	float				currentRotation;
	ofTrueTypeFont		interstate;
	Vector2d*			pos;
	GLPickerView		*directionPicker;
	GLValuePickerView	*magnitudePicker;
	NSMutableArray		*directionOptions;
	bool				showingEditor;
}

@property (copy) NSNumber*			amount;
@property (copy) NSMutableString*	direction;
@property (retain) Vector2d*		pos;

-(void)processTurtle:(id)_turtle;
-(void)render;
-(void)activateEditor;
-(void)touchDown:(TouchEvent*)_tEvent;
-(void)touchUpX:(float)x Y:(float)y ID:(float)touchID;

@end