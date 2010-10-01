//
//  RootModel.h
//  ww
//
//  Created by jonbroFERrealz on 9/24/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//
#pragma once

#import "defines.h"
#import <UIKit/UIKit.h>
#include "ofMain.h"
#include "SynthModel.h"
#

@interface rootModelObj : NSObject <NSCoding> {
	NSMutableArray *world;
	NSMutableArray *links;
	NSMutableArray *synths;
}

@property (nonatomic, retain) NSMutableArray *world;
@property (nonatomic, retain) NSMutableArray *links;
@property (nonatomic, retain) NSMutableArray *synths;

@end


class RootModel{
public:
	RootModel();
	void update();
	void step();
	void save();
	void load();
	
	int neighbors(int x, int y);
	
	rootModelObj *objcRootModel;
	int world[NUMCELLSX][NUMCELLSX][2];
	
	ofPoint synthLinks[8]; // should be implemented in a vector eventually
	ofPoint scrollOffset;
	bool linkingSynths;
	int currentSynth;
	
	int currentState;
	int currentScreen;
	
	bool running;
	
	SynthModel synthData[8];
};