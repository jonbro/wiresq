//
//  Vector2d.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/27/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "Vector2d.h"


@implementation Vector2d

@synthesize x, y;

-(float)getHeading
{
	float angle = (float)atan2(-y, x);
	return -1.0*angle;
}

-(void)normalize
{
	float m = [self magnitude];
	if (m > 0.0) {
		[self div:m];
	}
}

-(float)magnitude
{
	return (float)sqrt(x*x + y*y);
}

-(void)div:n
{
	x /= n;
	y /= n;
}

@end
