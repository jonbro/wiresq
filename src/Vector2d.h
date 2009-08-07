//
//  Vector2d.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/27/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Vector2d : NSObject {
	float x;
	float y;
}

@property float x;
@property float y;

-(id)initWithX:(float)_x Y:(float)_y;
-(id)initWithVector:(Vector2d*)_vec;
+(Vector2d*)mult:(Vector2d*)v amount:(float)n;
-(float)getHeading;
-(float)magnitude;
-(void)normalize;
-(void)div:(float)n;
-(void)mult:(float)n;
-(void)add:(Vector2d*)v;
-(void)rotate:(float)rad;

@end
