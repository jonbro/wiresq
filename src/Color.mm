//
//  Color.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/18/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "Color.h"

@implementation Color
@synthesize red, green, blue, hue, saturation, lightness;
-(void)setHue:(float)_h
{
	hue = _h;
	[self setColorH:hue S:saturation L:lightness];
}
-(void)colorWithColor:(Color*)_color
{
	self.red = _color.red;
	self.green = _color.blue;
	self.blue = _color.blue;

	self.hue = _color.hue;
	self.saturation = _color.saturation;
	self.lightness = _color.lightness;

}
-(void)setColorH:(float)_h S:(float)_s L:(float)_l
{
	hue = _h;
	saturation = _s;
	lightness = _l;
	
	float base_line = ((255.0 * lightness) * (1.0 - saturation));
	float top_val = (255.0 * _l);
	
	float differential = top_val - base_line;
	
	if ((hue > 300) || (hue < 60))
	{
		// red is the dominant colour.
		red = top_val;
		if (hue > 300)
		{
			// towards blue
			blue = ((((360.0 - hue)/60.0) * differential)+base_line);
			green = base_line;
		} 
		else
		{
			// towards green
			green = (((hue/60.0) * differential)+base_line);
			blue = base_line;
		}
	}
	else if ((hue >=60) && (hue <= 180))
	{
		// green is the dominant colour
		green = top_val;
		if (hue < 120)
		{
			// toward red
			red = ((((120.0 - hue)/60.0) * differential)+base_line);
			blue = base_line;
		} 
		else
		{
			// toward blue
			blue = ((((hue - 120.0)/60.0) * differential)+base_line);
			red = base_line;
		}
	} 
	else
	{
		// blue is the dominant colour
		blue = top_val;
		if (hue < 240)
		{
			// toward green
			green = ((((240.0 - hue)/60.0) * differential)+base_line);
			red = base_line;
		} 
		else
		{
			// toward red
			red = ((((hue  - 240.0)/60.0) * differential)+base_line);
			green = base_line;
		}
	}	
}

@end
