//
//  Color.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/18/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Color : NSObject {
	float red, green, blue;
}

@property float red;
@property float green;
@property float blue;

-(void)setColorH:(float)_h S:(float)_s L:(float)_l;

@end
