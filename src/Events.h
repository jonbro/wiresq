//
//  Events.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchEvent.h"
#import "CustomEventResponder.h"
@protocol CustomEventResponder;


@interface Events : NSObject {

}
+(void)addButton:(CustomEventResponder*)button;
+(void)removeButton:(CustomEventResponder*)button;
+(void)touchDown:(TouchEvent*)_tEvent;
+(void)touchUp:(TouchEvent*)_tEvent;
+(void)touchMoved:(TouchEvent*)_tEvent;
+(void)touchDoubleTap:(TouchEvent*)_tEvent;

@end

@protocol CustomEventResponder
-(bool)insideX:(float)x Y:(float)y;
@end
