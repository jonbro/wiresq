//
//  GLButton.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/4/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "ofMain.h"

@protocol GLButtonDelegate;

@interface GLButton : CustomEventResponder {
	id<GLButtonDelegate>	_delegate;
	NSString	*title;
	int			color, fontColor;
	ofTrueTypeFont	font;
}
@property(nonatomic, assign) id<GLButtonDelegate> _delegate;

-(void)setTitle:(NSString *)_title;
-(void)setFont:(ofTrueTypeFont)_font;
-(void)setColor:(int)_color;
-(void)setFontColor:(int)_fontColor;
@end

@protocol GLButtonDelegate
@optional
-(void)buttonDidPress:(GLButton *)button;
-(void)buttonDidRelease:(GLButton *)button;
@end
