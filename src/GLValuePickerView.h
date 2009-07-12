//
//  GLValuePickerView.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/3/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "GLPickerView.h"

@protocol GLValuePickerViewDelegate;

@interface GLValuePickerView : CustomEventResponder <GLPickerViewDelegate, GLPickerViewDataSource> {
	NSMutableArray *subPickers;
	int				exponent;
	id<GLValuePickerViewDelegate>	_delegate;
}

@property(nonatomic, assign) id<GLValuePickerViewDelegate> _delegate;

@end

@protocol GLValuePickerViewDelegate
@optional
-(void)pickerView:(GLValuePickerView *)pickerView didSelectValue:(NSInteger)_value;
@end
