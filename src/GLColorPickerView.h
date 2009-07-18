//
//  GLColorPickerView.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/18/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ofMain.h"
#import "Events.h"
#import "TouchEvent.h"
#import "CustomEventResponder.h"
#import "Color.h"

@protocol GLColorPickerViewDelegate;

@interface GLColorPickerView : CustomEventResponder {
	ofImage pickerImage;
	Color *c;
	id<GLColorPickerViewDelegate>	_delegate;
}

@property(nonatomic, assign) id<GLColorPickerViewDelegate> _delegate;

@end

@protocol GLColorPickerViewDelegate
@optional
-(void)pickerView:(GLColorPickerView *)pickerView didSelectColor:(Color *)_color;
@end
