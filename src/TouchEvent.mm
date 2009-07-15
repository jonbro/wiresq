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
	self.pos = _tEvent.pos;
	self.x_pos = _tEvent.pos.x;
	self.y_pos = _tEvent.pos.y;
	self.touchId = _tEvent.touchId;
	self.prevTouch = _tEvent.prevTouch;
	return self;
}
@end
