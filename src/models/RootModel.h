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
#include "synthLink.h"
#include <vector>

@interface rootModelObj : NSObject <NSCoding> {
	NSMutableArray *world;
	NSMutableArray *notes;
	NSMutableArray *links;
	NSMutableArray *synths;
	NSNumber *bpm;
	NSNumber *clockMult;
}

@property (nonatomic, retain) NSMutableArray *world;
@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) NSMutableArray *links;
@property (nonatomic, retain) NSMutableArray *synths;
@property (retain) NSNumber *bpm;
@property (retain) NSNumber *clockMult;
@end


class RootModel{
public:
	RootModel();
	void update();
	void step();
	void save();
	void load();
	
	void setLink(int x, int y, int synth);
	bool hasLink(int x, int y, int synth);
	void removeLink(int x, int y, int synth);
	int neighbors(int x, int y);
	
	rootModelObj *objcRootModel;
	int world[NUMCELLSX][NUMCELLSY][2];
	int notes[NUMCELLSX][NUMCELLSY];
	
	vector<SynthLink> synthLinks; // should be implemented in a vector eventually
	
	ofPoint scrollOffset;
	bool linkingSynths;
	int currentSynth;
	
	int currentState;
	int drawState;
	int currentScreen;
	
	float bpm;
	int clockMult;
	
	bool running;
	
	SynthModel synthData[8];
};