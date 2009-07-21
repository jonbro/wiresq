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
ofImage bob;

@implementation Turtle

@synthesize pos, dir, currentColor, pos3, dir3;

-(id)init
{
	self = [super init];
	in_set = [[InstructionSet alloc] init];
	currentInstruction = 0;

	pos3 = new Vector3f(0.0, 0.0, 0.0);
	dir3 = new Vector3f(0.0, 1.0, 0.0);
	bob.loadImage("bob.png");
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
    Vector3f vPoint0(-1.0, -1.0, 0.0f);
    Vector3f vPoint1( 1.0, -1.0, 0.0f);
    Vector3f vPoint2( 1.0,  1.0, 0.0f);
    Vector3f vPoint3(-1.0,  1.0, 0.0f);
	glPushMatrix();
	glTranslatef(pos3->x, pos3->y, pos3->z);
	turtleShape->begin(GL_TRIANGLE_STRIP);
	bob.getTextureReference().bind();
	float mat[16];
	glGetFloatv( GL_MODELVIEW_MATRIX, mat );
	Vector3f vRight( mat[0], mat[4], mat[8] );
	Vector3f vUp( mat[1], mat[5], mat[9] );
	Vector3f vCenter( 0.0f, 0.0f, 0.0f );

	vPoint0 = vCenter + ((-vRight - vUp) * lineWeight);
	vPoint1 = vCenter + (( vRight - vUp) * lineWeight);
	vPoint2 = vCenter + (( vRight + vUp) * lineWeight);
	vPoint3 = vCenter + ((-vRight + vUp) * lineWeight);
	turtleShape->setTexCoord(0.0, 0.0);
	turtleShape->addVertex(vPoint0.x,vPoint0.y,vPoint0.z);
	
	turtleShape->setTexCoord(1.0f, 0.0f);
	turtleShape->addVertex(vPoint1.x,vPoint1.y,vPoint1.z);
	
	turtleShape->setTexCoord(0.0f, 1.0f);
	turtleShape->addVertex(vPoint3.x,vPoint3.y,vPoint3.z);
	
	turtleShape->setTexCoord(1.0f, 1.0f);
	turtleShape->addVertex(vPoint2.x,vPoint2.y,vPoint2.z);
	
	turtleShape->end();
	bob.getTextureReference().unbind();
	glPopMatrix();
}
-(void)setLineWidth:(float)_width
{
	lineWeight = _width;
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
	[self runInstruction:_currentInstruction];
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
