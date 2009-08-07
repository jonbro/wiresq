//
//  ColorInstruction.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/18/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "turtle.h"
#import "Vector2d.h"
#import "ofMain.h"
#import "GLColorPickerView.h"
#import "BaseInstruction.h"
#import "connectionNode.h"
#import "DrawSprite.h"
#import "Color.h"

@class BaseInstruction;

@interface ColorInstruction : BaseInstruction <GLColorPickerViewDelegate> {
	Color				*colorValue;
	GLColorPickerView	*colorPicker;
	bool				showingEditor;
}

-(void)activateEditor;

@end
