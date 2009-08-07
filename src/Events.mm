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
+(void)touchDoubleTap:(TouchEvent*)_tEvent
{
	if(firstResponder){
		[self manageDoubleTouchDown:_tEvent forButton:firstResponder];
	}	
}
+(bool)manageDoubleTouchDown:(TouchEvent *)_tEvent forButton:(CustomEventResponder *)_responder
{
	bool subViewHits = NO;
	CGAffineTransform tmp = _tEvent.currentTransform;
	if([[_responder subviews]count]>0){
		if([_responder hasTransform]){
			_tEvent.currentTransform = _responder.currentTranslation;
		}
		for (CustomEventResponder *button in [_responder subviews]) {
			if([self manageDoubleTouchDown:_tEvent forButton:button]){
				subViewHits = YES;
			}
		}
	}
	if(!subViewHits){
		_tEvent.currentTransform = tmp;
		if([_responder insideX:_tEvent.pos.x Y:_tEvent.pos.y] && [_responder respondsToSelector:@selector(touchDoubleTap:)] == YES) {
			[currentButtonForTouch setObject:_responder forKey:[NSNumber numberWithInt:_tEvent.touchId]];
			[startTouch setObject:_tEvent forKey:[NSNumber numberWithInt:_tEvent.touchId]];
			[_responder touchDoubleTap:_tEvent];
			return true;
		}
	}
	return subViewHits;
}
+(bool)manageTouchDown:(TouchEvent *)_tEvent forButton:(CustomEventResponder *)_responder
{
	bool subViewHits = NO;
	CGAffineTransform tmp = _tEvent.currentTransform;
	if([[_responder subviews] count]>0){
		if([_responder hasTransform]){
			_tEvent.currentTransform = _responder.currentTranslation;
		}		
		for (CustomEventResponder *button in [_responder subviews]) {
			if([self manageTouchDown:_tEvent forButton:button]){
				subViewHits = YES;
			}
		}
	}
	if(!subViewHits){
		_tEvent.currentTransform = tmp;
		if([_responder insideX:_tEvent.pos.x Y:_tEvent.pos.y] && [_responder respondsToSelector:@selector(touchDown:)] == YES) {
			[currentButtonForTouch setObject:_responder forKey:[NSNumber numberWithInt:_tEvent.touchId]];
			[startTouch setObject:_tEvent forKey:[NSNumber numberWithInt:_tEvent.touchId]];
			[_responder touchDown:_tEvent];
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
		[startTouch removeObjectForKey:[NSNumber numberWithInt:_tEvent.touchId]];
	}
}
+(void)touchMoved:(TouchEvent*)_tEvent
{
	if([currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]]!=nil
	   && [[currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]]respondsToSelector:@selector(touchMoved:)] == YES){
		[_tEvent.prevTouch release];
		_tEvent.prevTouch = [[startTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]]retain];
		_tEvent.currentTransform = _tEvent.prevTouch.currentTransform;
		[startTouch setObject:_tEvent forKey:[NSNumber numberWithInt:_tEvent.touchId]];
		[[currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]] touchMoved:_tEvent];
	}
}
@end
