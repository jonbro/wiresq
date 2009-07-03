//
//  TouchEvent.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 6/3/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TouchEvent : NSObject {
	float	x_pos;
	float	y_pos;
	int		touchId;
	TouchEvent *prevTouch;
}

@property float x_pos;
@property float y_pos;
@property int touchId;
@property (retain) TouchEvent* prevTouch;

@end
