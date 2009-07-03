//
//  Events.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "Events.h"

static CustomEventResponder *firstResponder;
static NSMutableDictionary *currentButtonForTouch;
static NSMutableDictionary *startTouch;

@implementation Events
+(void)setFirstResponder:(CustomEventResponder*)button
{
	if(!currentButtonForTouch){
		currentButtonForTouch = [[[NSMutableDictionary alloc] init]retain];
		startTouch = [[[NSMutableDictionary alloc] init] retain];
	}else{
		[firstResponder release];
	}
	firstResponder = [button retain];
}
+(void)touchDown:(TouchEvent*)_tEvent
{
	if(firstResponder){
		[self manageTouchDown:_tEvent forButton:firstResponder];
	}
}
+(bool)manageTouchDown:(TouchEvent *)_tEvent forButton:(CustomEventResponder *)_repsonder
{
	bool subViewHits = NO;
	if([[_repsonder subviews]count]>0){
		for (CustomEventResponder *button in [_repsonder subviews]) {
			if([self manageTouchDown:_tEvent forButton:button]){
				subViewHits = YES;
			}
		}
	}
	if(!subViewHits){
		if([_repsonder insideX:_tEvent.x_pos Y:_tEvent.y_pos] && [_repsonder respondsToSelector:@selector(touchDown:)] == YES) {
			[currentButtonForTouch setObject:_repsonder forKey:[NSNumber numberWithInt:_tEvent.touchId]];
			[startTouch setObject:_tEvent forKey:[NSNumber numberWithInt:_tEvent.touchId]];
			[_repsonder touchDown:_tEvent];
			return true;
		}
	}
	return subViewHits;
}
+(void)touchUp:(TouchEvent*)_tEvent
{
	if([currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]] != nil){
		[[currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]] touchUp:_tEvent];
		[currentButtonForTouch removeObjectForKey:[NSNumber numberWithInt:_tEvent.touchId]];
	}
}
+(void)touchMoved:(TouchEvent*)_tEvent
{
	if([currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]]!=nil
	   && [[currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]]respondsToSelector:@selector(touchMoved:)] == YES){
		[_tEvent.prevTouch release];
		_tEvent.prevTouch = [[startTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]]retain];
		[startTouch setObject:_tEvent forKey:[NSNumber numberWithInt:_tEvent.touchId]];
		[[currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]] touchMoved:_tEvent];
	}
}
+(void)touchDoubleTap:(TouchEvent*)_tEvent
{}
@end
