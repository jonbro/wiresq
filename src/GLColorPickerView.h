//
//  GLColorPickerView.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/18/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ofMain.h"
#import "Events.h"
#import "TouchEvent.h"
#import "CustomEventResponder.h"

@interface GLColorPickerView : CustomEventResponder {
	ofImage pickerImage;
	ofTexture pickerTex;
}

@end
