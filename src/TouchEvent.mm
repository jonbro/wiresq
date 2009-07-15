//
//  TouchEvent.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/3/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "TouchEvent.h"


@implementation TouchEvent
@synthesize x_pos, y_pos, touchId, prevTouch, pos;
-(TouchEvent*)initWithTouchEvent:(TouchEvent*)_tEvent
{
	self = [super init];
	self.x_pos = _tEvent.x_pos;
	self.y_pos = _tEvent.y_pos;
	self.touchId = _tEvent.touchId;
	self.pos = _tEvent.pos;
	self.prevTouch = _tEvent.prevTouch;
	return self;
}
@end
