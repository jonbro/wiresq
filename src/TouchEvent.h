//
//  TouchEvent.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 6/3/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import <Foundation/Foundation.h>


@interface TouchEvent : NSObject {
	float	x_pos;
	float	y_pos;
	CGAffineTransform currentTransform;
	CGPoint pos;
	int		touchId;
	TouchEvent *prevTouch;
}

@property float x_pos;
@property float y_pos;
@property int touchId;
@property CGPoint pos;
@property CGAffineTransform currentTransform;
@property (retain) TouchEvent* prevTouch;

-(TouchEvent*)initWithTouchEvent:(TouchEvent*)_tEvent;

@end
