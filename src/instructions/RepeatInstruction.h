//
//  repeatInstruction.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/13/09.
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
#import "DrawSprite.h"

@class BaseInstruction;

@interface RepeatInstruction : BaseInstruction <GLValuePickerViewDelegate> {
	BaseInstruction		*innerInstruction;
	GLValuePickerView	*counterPicker;
	bool				showingEditor, isCounting;
	NSNumber*			counter;
	NSNumber*			tmpCounter;
}

@property (retain) NSNumber*			counter;

@end
