//
//  CustomEventResponder.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchEvent.h"

@interface CustomEventResponder : NSObject {
	CGRect frame;
	NSMutableArray *subviews;
	NSMutableArray *subviewsToBeAdded;
	NSMutableArray *toBeRemovedLoop;
	CustomEventResponder *superview;
	CGAffineTransform currentTranslation;
	bool toBeRemoved;
}
@property (readonly) CGAffineTransform currentTranslation;
@property (readonly) NSMutableArray* subviews;
@property (assign) CGRect frame;
@property (readonly) CustomEventResponder* superview;
@property (assign) bool toBeRemoved;

-(id)initWithFrame:(CGRect)_frame;

-(void)update;
-(void)render;

-(bool)hasTransform;

-(void)touchDown:(TouchEvent*)_tEvent;
-(void)touchUp:(TouchEvent*)_tEvent;
-(void)touchMoved:(TouchEvent*)_tEvent;
-(void)touchDoubleTap:(TouchEvent*)_tEvent;

-(bool)insideX:(float)x Y:(float)y;

-(void)addSubview:(CustomEventResponder *)_view;
-(void)removeSubview:(CustomEventResponder *)_view;
-(void)setSuperview:(CustomEventResponder *)_superview;
-(void)removeSuperview;
@end
