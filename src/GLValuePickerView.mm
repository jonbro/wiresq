//
//  GLValuePickerView.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/3/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "GLValuePickerView.h"


@implementation GLValuePickerView
-(id)init
{
	self = [super init];
	exponent = 4;
	subPickers = [[NSMutableArray alloc] initWithCapacity:exponent];
	return self;
}
-(id)initWithFrame:(CGRect)_frame
{
	self = [self init];
	frame = _frame;
	for(int i=0;i<exponent;i++){
		CGRect subViewFrame = CGRectMake(frame.origin.x + i * frame.size.width / exponent, frame.origin.y, frame.size.width / exponent, frame.size.height);
		GLPickerView *tmpView = [[GLPickerView alloc] initWithFrame:subViewFrame];
		tmpView._delegate = self;
		tmpView._dataSource = self;
		[self addSubview:tmpView];
		[subPickers addObject:tmpView];
	}
	return self;
}
-(NSString*)pickerView:(GLPickerView*)pickerView titleForRow:(NSInteger)row
{
	return [[NSNumber numberWithInt:row] stringValue];
}
-(NSInteger)numberOfRowsInPickerView:(GLPickerView*)pickerView
{
	return 10;
}
@end
