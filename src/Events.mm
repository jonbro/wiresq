//
//  Events.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "Events.h"

static NSMutableArray *ceResponders;
static NSMutableDictionary *currentButtonForTouch;

@implementation Events
+(void)addButton:(CustomEventResponder*)button
{
	if(!ceResponders){
		ceResponders = [[NSMutableArray arrayWithCapacity:1]retain];
		currentButtonForTouch = [[[NSMutableDictionary alloc] init]retain];
	}
	[ceResponders addObject:[button retain]];
}
+(void)removeButton:(CustomEventResponder*)button
{
	[ceResponders removeObjectIdenticalTo:button];
}
+(void)touchDown:(TouchEvent*)_tEvent
{
	if(ceResponders && [ceResponders count]>0){
		for (CustomEventResponder *button in ceResponders) {
			if([button insideX:_tEvent.x_pos Y:_tEvent.y_pos] && [button respondsToSelector:@selector(touchDown:)] == YES) {
				[currentButtonForTouch setObject:button forKey:[NSNumber numberWithInt:_tEvent.touchId]];
			}
			[[currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]] touchDown:_tEvent];
		}
	}
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
		[[currentButtonForTouch objectForKey:[NSNumber numberWithInt:_tEvent.touchId]] touchMoved:_tEvent];
	}
}
+(void)touchDoubleTap:(TouchEvent*)_tEvent
{}
@end
