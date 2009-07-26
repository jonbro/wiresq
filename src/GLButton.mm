//
//  GLButton.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/4/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "GLButton.h"

@implementation GLButton

@synthesize _delegate;

-(id)init
{
	self = [super init];
	color = 0x000000;
	fontColor = 0xFFFFFF;
	font.loadFont("ProFont.ttf", 14);
	return self;
}
-(void)setTitle:(NSString *)_title
{
	title = [_title retain];
}
-(void)setFont:(ofTrueTypeFont)_font
{
//	font = _font;
}
-(bool)insideX:(float)x Y:(float)y
{
	return (x>frame.origin.x && y>frame.origin.y && x<frame.origin.x+frame.size.width && y<frame.origin.y+frame.size.height);
}
-(void)setColor:(int)_color
{
	color = _color;
}
-(void)setFontColor:(int)_fontColor
{
	fontColor = _fontColor;
}
-(void)render
{
	glPushMatrix();
	ofSetColor(color);
	glTranslatef(frame.origin.x, frame.origin.y, 0);
	ofRect(0, 0, frame.size.width, frame.size.height);
	ofSetColor(fontColor);
	font.drawString([title UTF8String], 10, frame.size.height/2+font.getLineHeight()/2);
	glPopMatrix();
}
-(void)touchDown:(TouchEvent *)_tEvent
{
	[_delegate buttonDidPress:self];
}
@end
