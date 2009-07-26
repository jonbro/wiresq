//
//  Vector2d.m
//  logo_fighter
//
//  Created by Jonathan Brodsky on 5/27/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "Vector2d.h"

@implementation Vector2d

@synthesize x, y;

-(id)initWithX:(float)_x Y:(float)_y
{
	self = [super init];
	self.x = _x;
	self.y = _y;
	return self;
	
}
-(id)initWithVector:(Vector2d*)_vec
{
	self = [self init];
	self.x = _vec.x;
	self.y = _vec.y;
	return self;
}
+(id)vectorWithVector:(Vector2d*)_vec
{
	return self = [[Vector2d alloc] initWithVector:_vec];
}

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
-(void)div:(float)n
{
	x /= n;
	y /= n;
}
-(void)mult:(float)n
{
	x *= n;
	y *= n;
}
+(Vector2d*)mult:(Vector2d*)v amount:(float)n
{
	Vector2d* tmp = [self vectorWithVector:v];
	[tmp mult:n];
	return tmp;
}
-(void)add:(Vector2d*)v
{
	x += v.x;
	y += v.y;
}
-(void)rotate:(float)rad
{
	float deg = ((rad * M_PI) / 180.0);
	float tx = (x * cosf(deg)) - (y * sinf(deg));
	float ty = (x * sinf(deg)) + (y * cosf(deg));
	x = tx;
	y = ty;
}

@end
