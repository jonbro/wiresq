//
//  repeatInstruction.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/13/09.
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
#import "DrawSprite.h"

@class BaseInstruction;

@interface RepeatInstruction : BaseInstruction <GLValuePickerViewDelegate> {
	BaseInstruction		*innerInstruction;
	BaseInstruction		*tmpInnerInstruction;
	GLValuePickerView	*counterPicker;
	bool				showingEditor, isCounting;
	NSNumber*			counter;
	int					tmpCounter;
}

@property (retain) NSNumber*			counter;

@end
