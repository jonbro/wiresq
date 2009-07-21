//
//  GLScrollView.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/14/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "TransformUtils.h"
#import "ofMain.h"

@interface GLScrollView : CustomEventResponder {
	CGPoint touchingHere;
}
@property CGPoint touchingHere;
@end
