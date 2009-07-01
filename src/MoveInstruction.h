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

@interface MoveInstruction : NSObject <GLPickerViewDelegate, GLPickerViewDataSource> {
	NSNumber*			amount;
	NSMutableString*	direction;
	float				currentRotation;
	ofTrueTypeFont		interstate;
	Vector2d*			pos;
	GLPickerView		*directionPicker;
	NSMutableArray		*directionOptions;
}

@property (copy) NSNumber*			amount;
@property (copy) NSMutableString*	direction;
@property (retain) Vector2d*		pos;

-(void)processTurtle:(id)_turtle;
-(void)render;
-(void)renderEditor;
-(void)activateEditor;
-(void)touchDownX:(float)x Y:(float)y ID:(float)touchID;
-(void)touchMoveX:(float)x Y:(float)y ID:(float)touchID;
-(void)touchUpX:(float)x Y:(float)y ID:(float)touchID;

@end