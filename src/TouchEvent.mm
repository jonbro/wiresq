//
//  TouchEvent.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/3/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "TouchEvent.h"


@implementation TouchEvent
@synthesize x_pos, y_pos, touchId, prevTouch, pos, currentTransform;
-(id)init
{
	self = [super init];
	currentTransform = CGAffineTransformIdentity;
	return self;
}
-(TouchEvent*)initWithTouchEvent:(TouchEvent*)_tEvent
{
	self = [self init];
	self.pos = _tEvent.pos;
	self.touchId = _tEvent.touchId;
	self.currentTransform = _tEvent.currentTransform;
	self.prevTouch = _tEvent.prevTouch;
	return self;
}
-(CGPoint)pos
{
//	return pos;
	return CGPointApplyAffineTransform(pos, CGAffineTransformInvert(currentTransform));
}
@end
