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

-(float)getHeading;

@end
