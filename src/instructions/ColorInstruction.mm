//
//  ColorInstruction.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/18/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "ColorInstruction.h"
#import "globals.h"

@implementation ColorInstruction
-(id)init
{
	self = [super init];
	colorPicker = [[[GLColorPickerView alloc] initWithFrame:CGRectMake(0, 400, 320, 80)] retain];
	colorPicker._delegate = self;
	showingEditor = false;
	
	colorValue = [[Color alloc] init];
	colorValue.red = 0;
	colorValue.green = 0;
	colorValue.blue = 0;

	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y-4, frame.size.width, 4)] forKey:@"topNode"];
	[self addSubview:[instructionNodes objectForKey:@"topNode"]];
	[instructionNodes setObject:[[ConnectionNode alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 4)] forKey:@"bottomNode"];
	[self addSubview:[instructionNodes objectForKey:@"bottomNode"]];
	
	return self;
}
-(void)render
{
	drawRectSprite(0, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height, 0, 0);
	drawRectSprite(0, frame.origin.x+6, frame.origin.y+12, 26, 26, 0, 53);
	// draw the current color
	ofSetColor(colorValue.red, colorValue.green, colorValue.blue);
	ofRect(frame.origin.x+61, frame.origin.y+16, 10, 10);
	[super render];
}
-(id)processTurtle:(Turtle*)_turtle
{
	[_turtle.currentColor colorWithColor:colorValue];
	return nextInstruction;
}
-(void)pickerView:(GLColorPickerView *)pickerView didSelectColor:(Color *)_color;
{
	colorValue = _color;
}
-(void)activateEditor
{
	[editorScreen removeEditors];
	showingEditor = true;
	[editorScreen addSubview:colorPicker];
}
-(void)removeEditor
{
	if(showingEditor){
		[editorScreen removeSubview:colorPicker];
		showingEditor = false;
	}
}
-(void)touchDoubleTap:(TouchEvent*)_tEvent
{
	if(!showingEditor){
		[self activateEditor];
	}
}

@end
