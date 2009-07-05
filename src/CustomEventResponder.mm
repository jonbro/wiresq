//
//  CustomEventResponder.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "CustomEventResponder.h"


@implementation CustomEventResponder

@synthesize subviews, toBeRemoved, frame;

-(id)init
{
	self = [super init];
	frame = CGRectMake(0, 0, 0, 0);
	subviews = [[NSMutableArray alloc] initWithCapacity:0];
	subviewsToBeAdded = [[NSMutableArray alloc] initWithCapacity:0];
	toBeRemoved = false;
	return self;
}
-(id)initWithFrame:(CGRect)_frame
{
	self = [self init];
	frame = _frame;
	return self;	
}
-(void)update
{
	for(CustomEventResponder *subview in subviews){
		[subview update];
	}
}
-(void)render
{
	toBeRemovedLoop = [[NSMutableArray alloc] initWithCapacity:0];
	int i = 0;
	for(CustomEventResponder *subview in subviews){
		[subview render];
		if(subview.toBeRemoved){
			subview.toBeRemoved = false;
			[toBeRemovedLoop addObject:[NSNumber numberWithInt:i]];
		}
		i++;
	}
	if([toBeRemovedLoop count]>0){
		for(int i=0;i<[toBeRemovedLoop count];i++){
			NSLog(@"inside remove loop");
			[subviews removeObjectAtIndex:[[toBeRemovedLoop objectAtIndex:i]intValue]-i];
		}
	}
	if([subviewsToBeAdded count]>0){
		for(int i=0;i<[subviewsToBeAdded count];i++){
			[subviews addObject:[subviewsToBeAdded objectAtIndex:0]];
			[subviewsToBeAdded removeObjectAtIndex:0];
		}
	}
}
-(void)touchDown:(TouchEvent*)_tEvent
{}
-(void)touchUp:(TouchEvent*)_tEvent
{}
-(void)touchMoved:(TouchEvent*)_tEvent
{}
-(void)touchDoubleTap:(TouchEvent*)_tEvent
{}
-(bool)insideX:(float)x Y:(float)y
{
	return (x>frame.origin.x && y>frame.origin.y && x<frame.origin.x+frame.size.width && y<frame.origin.y+frame.size.height);
}
-(void)addSubview:(CustomEventResponder *)_view
{
	[subviewsToBeAdded addObject:_view];
	[_view setSuperview:self];
}
-(void)removeSubview:(CustomEventResponder *)_view
{
	// mark as toBeRemoved
	// remove on the superview next update loop
	_view.toBeRemoved = true;
}
-(void)setSuperview:(CustomEventResponder *)_superview
{
	[superview release];
	superview = [_superview retain];
}
-(void)removeSuperview
{
	[superview release];
}
@end
