//
//  turtle.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstructionSet.h"
#import "Vector2d.h"

@interface Turtle : NSObject {
	InstructionSet* iset;
	NSNumber* currentInstruction;
	Vector2d* pos;
	Vector2d* dir;
}

@property (retain) InstructionSet* iset;
@property (retain) Vector2d* pos;
@property (retain) Vector2d* dir;

-(void)update;
-(void)render;

@end

/* Steering helper from an old processing project:
 Vector3D steer(Vector3D target, boolean slowdown) {
	 Vector3D steer;  // The steering vector
	 Vector3D desired = Vector3D.sub(target,pos);  // A vector pointing from the location to the target
	 float d = desired.magnitude(); // Distance from the target is the magnitude of the vector
	 // If the distance is greater than 0, calc steering (otherwise return zero vector)
	 if (d > 0) {
		 // Normalize desired
		 desired.normalize();
		 // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
		 if ((slowdown) && (d < 100.0f)) desired.mult(maxspeed*(d/100.0f)); // This damping is somewhat arbitrary
		 else desired.mult(maxspeed);
		 // Steering = Desired minus Velocity
		 steer = Vector3D.sub(desired,vel);
		 steer.limit(maxforce);  // Limit to maximum steering force
	 } else {
		steer = new Vector3D(0,0);
	 }
	 return steer;
 }
*/