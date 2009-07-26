//
//  GLValuePickerView.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/3/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "GLValuePickerView.h"


@implementation GLValuePickerView
@synthesize _delegate;
-(id)init
{
	self = [super init];
	exponent = 3;
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
-(void)pickerView:(GLPickerView *)pickerView didSelectRow:(NSInteger)row
{
	if(_delegate && [_delegate respondsToSelector:@selector(pickerView: didSelectValue:)] == YES){
		//calculate value
		int value = 0;
		for(int i=0;i<exponent;i++){
			value = value + [[subPickers objectAtIndex:i] selected] * pow(10, exponent-i-1);
		}
		//send to parent
		[_delegate pickerView:self didSelectValue:value];
	}
}

@end
