//
//  GLColorPickerView.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/18/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "GLColorPickerView.h"

@implementation GLColorPickerView
@synthesize _delegate;
-(id)init
{
	self = [super init];
	pickerImage.loadImage("color_picker.png");
	pickerImage.setImageType(OF_IMAGE_COLOR_ALPHA);	
	c = [[Color alloc] init];
	return self;
}
-(void)touchMoved:(TouchEvent *)_t
{
	[c setColorH:_t.pos.x/frame.size.width*360 S:1.0 L:(_t.pos.y-frame.origin.y)/frame.size.height];

	if(_delegate && [_delegate respondsToSelector:@selector(pickerView: didSelectColor:)] == YES){
		[_delegate pickerView:self didSelectColor:c];
	}
}
-(void)render
{
	pickerImage.draw(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
	[super render];
}
@end
