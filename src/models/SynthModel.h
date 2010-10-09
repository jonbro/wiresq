#pragma once
#import <Foundation/Foundation.h>
#import "ofxColor.h"

@interface synthModelObj : NSObject <NSCoding> {
	NSNumber *wavType;
	NSNumber *Attack;
	NSNumber *Hold;
	NSNumber *Decay;
	NSNumber *Pitch;
	NSNumber *Cutoff;
	NSNumber *Res;
}

@property (retain) NSNumber *wavType;
@property (retain) NSNumber *Attack;
@property (retain) NSNumber *Hold;
@property (retain) NSNumber *Decay;
@property (retain) NSNumber *Pitch;
@property (retain) NSNumber *Cutoff;
@property (retain) NSNumber *Res;

@end

class SynthModel{
public:
	void setup();
	void save();
	void load();
	
	synthModelObj *objCmodel;
	int wavType;
	float Attack, Hold, Decay;
	float Pitch;
	float Cutoff, Res;
	ofxColorf color;
};