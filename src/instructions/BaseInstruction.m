//
//  BaseInstruction.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/4/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "BaseInstruction.h"


@implementation BaseInstruction

-(void)touchMoved:(TouchEvent*)_tEvent
{
	frame.origin.x += _tEvent.x_pos - _tEvent.prevTouch.x_pos;
	frame.origin.y += _tEvent.y_pos - _tEvent.prevTouch.y_pos;
}

@end
