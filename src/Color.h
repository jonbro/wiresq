//
//  Color.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/18/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import <Foundation/Foundation.h>


@interface Color : NSObject {
	float red, green, blue;
	float hue, saturation, lightness;
}

@property float red;
@property float green;
@property float blue;
@property float hue;
@property float saturation;
@property float lightness;

-(void)setColorH:(float)_h S:(float)_s L:(float)_l;
-(void)colorWithColor:(Color*)_color;
@end
