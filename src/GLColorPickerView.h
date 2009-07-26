//
//  GLColorPickerView.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/18/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
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
