//
//  GLScrollView.h
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/14/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
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
