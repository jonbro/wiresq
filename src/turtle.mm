//
//  turtle.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/26/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "turtle.h"
#import "ofGraphics.h"
#import "InstructionSet.h"
#import "ofxiPhone.h"

#import "ofxMSAShape3D.h"

ofxMSAShape3D *turtleShape;

@implementation Turtle

@synthesize pos, dir, currentColor, pos3, dir3;

-(id)init
{
	self = [super init];
	in_set = [[InstructionSet alloc] init];
	currentInstruction = 0;

	pos3 = new Vector3f(0.0, 0.0, 0.0);
	dir3 = new Vector3f(0.0, 1.0, 0.0);
	
	pos = [[Vector2d alloc] init];
	pos.x = 160.0;
	pos.y = 240.0;
	turtleShape = new ofxMSAShape3D();
	currentColor = [[Color alloc] init];
	currentColor.red = 0;
	currentColor.green = 0;
	currentColor.blue = 0;
	lineWeight = 1;
	dir = [[Vector2d alloc] init];
	dir.x = 0;
	dir.y = 1;
	
	return self;
}
-(void)update
{
	
}
-(void)addPoint:(CGPoint)_newPoint
{
}
-(void)render
{
	//add the left vertex
	turtleShape->setColor(currentColor.red/255.0, currentColor.green/255.0, currentColor.blue/255.0);
	turtleShape->addVertex(pos3->x, pos3->y);
}
-(void)setLineWidth:(float)_width
{
	lineWeight = _width;
	turtleShape->end();
	glLineWidth(lineWeight);
	turtleShape->begin(GL_LINE_STRIP);
}
-(void)runFirstInstruction:(BaseInstruction*)_currentInstruction
{
	//reset
	pos.x = 160.0;
	pos.y = 240.0;

	//reset
	dir.x = 0;
	dir.y = 1;

	pos3->x = 160.0;
	pos3->y = 240.0;
	pos3->z = 0;

	dir3->x = 0.0;
	dir3->y = 1.0;
	dir3->z = 0.0;
	
	ofSetColor(255, 255, 255);

	currentColor.red = 0;
	currentColor.green = 0;
	currentColor.blue = 0;
	
	ofSetColor(0xFFFFFF);
	ofRect(0, 0, 320, 480);
	// run all of the instructions
	ofSetColor(currentColor.red, currentColor.green, currentColor.blue);

	ofSetColor(0x000000);
	glLineWidth(lineWeight);
	turtleShape->begin(GL_LINE_STRIP);
	[self runInstruction:_currentInstruction];
	turtleShape->end();
	// save to the photo library
//	
	ofFill();
}
-(void)save:(BaseInstruction*)_currentInstruction
{
	[self runFirstInstruction:_currentInstruction];
	iPhoneScreenGrab(self);
}
-(void)runInstruction:(BaseInstruction*)_currentInstruction
{
	currentInstruction = _currentInstruction;
	while(currentInstruction != nil)
	{
		currentInstruction = [currentInstruction processTurtle:self];
	}
}
@end
