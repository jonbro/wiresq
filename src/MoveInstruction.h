//
//  MoveInstruction.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 5/26/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import <Foundation/Foundation.h>
#import "turtle.h"
#import "Vector2d.h"
#import "ofMain.h"
#import "GLPickerView.h"
#import "GLValuePickerView.h"
#import "BaseInstruction.h"
#import "connectionNode.h"

@class BaseInstruction;

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

-(void)setPrevious:(BaseInstruction*)_prevInstruction;
-(void)render;
-(void)activateEditor;

@end