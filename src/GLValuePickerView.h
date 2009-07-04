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

@interface GLValuePickerView : CustomEventResponder <GLPickerViewDelegate, GLPickerViewDataSource> {
	NSMutableArray *subPickers;
	int				exponent;
}

@end
