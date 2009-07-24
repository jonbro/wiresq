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
#import "glHelper.h"

#import "ofxMSAShape3D.h"

ofxMSAShape3D *turtleShape;
ofImage bob, bob2, bob3;
ofTexture turtleTex;

@implementation Turtle

@synthesize pos, dir, currentColor, pos3, dir3, hasOverride;

-(id)init
{
	self = [super init];
	in_set = [[InstructionSet alloc] init];
	variables = [[NSMutableArray alloc] initWithCapacity:10];
	for(int i=0;i<10;i++){
		[variables addObject:[NSNumber numberWithInt:1]];
	}
	
	currentInstruction = 0;

	pos3 = new Vector3f(0.0, 0.0, 0.0);
	dir3 = new Vector3f(0.0, 1.0, 0.0);
	bob.loadImage("bob.png");
	bob.setImageType(OF_IMAGE_COLOR_ALPHA);
	bob2.loadImage("bob2.png");
	bob2.setImageType(OF_IMAGE_COLOR_ALPHA);
	bob3.loadImage("bob3.png");
	bob3.setImageType(OF_IMAGE_COLOR_ALPHA);
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
	hasOverride = false;
	settingVar = false;
	overrideVar = 0;
	varToSet = 0;
	return self;
}
-(void)update
{
	
}
-(void)addPoint:(CGPoint)_newPoint
{
}
-(void)setTexture:(int)tex
{
	switch (tex) {
		case 0:
			turtleTex = bob.getTextureReference();
			break;
		case 1:
			turtleTex = bob2.getTextureReference();
			break;
		default:
			turtleTex = bob3.getTextureReference();
			break;
	}
}
-(void)processArb:(int)amount
{
	if(settingVar)
	{
		settingVar = false;
		[variables replaceObjectAtIndex:varToSet withObject:[NSNumber numberWithInt:amount]];
	}else{
		if(amount < 10){
			[self setTexture:amount];
		}else if(amount < 20){
			[self setBlendMode:amount-10];
		}else if(amount >= 20 && amount <= 29){
			hasOverride = true;
			overrideVar = amount - 20;
		}else if(amount >= 30 && amount <= 39){
			varToSet = amount - 30;
			settingVar = true;
		}else if(amount >= 100 && amount < 200){
			int a = (amount - 100) / 10;
			int aVal = [[variables objectAtIndex:a] intValue];
			int b = (amount - 100) - a*10;
			int bVal = [[variables objectAtIndex:b] intValue];
			[variables replaceObjectAtIndex:a withObject:[NSNumber numberWithInt:aVal+bVal]];
		}else if(amount == 998){
			ofSetColor(currentColor.red, currentColor.green, currentColor.blue);
			ofRect(0, 0, 320, 480);
		}else if(amount == 999){
			[self resetTurtle];
		}
	}
}
-(bool)hasOverride
{
	if(hasOverride){
		hasOverride = false;
		return true;
	}else{
		return false;
	}
}
-(int)overRideVal
{
	return [(NSNumber*)[variables objectAtIndex:overrideVar] intValue];
}
-(void)setBlendMode:(int)mode
{
	switch (mode) {
		case 0:
			glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
			break;
		default:
			glBlendFunc(GL_ONE, GL_ONE);
			break;
	}
}
-(void)render
{
	ofEnableAlphaBlending();
	//add the left vertex
    Vector3f vPoint0(-1.0, -1.0, 0.0f);
    Vector3f vPoint1( 1.0, -1.0, 0.0f);
    Vector3f vPoint2( 1.0,  1.0, 0.0f);
    Vector3f vPoint3(-1.0,  1.0, 0.0f);
	glPushMatrix();
	glTranslatef(pos3->x, pos3->y, pos3->z);
	turtleShape->begin(GL_TRIANGLE_STRIP);
	turtleShape->setColor(currentColor.red/255.0, currentColor.green/255.0, currentColor.blue/255.0);
	turtleTex.bind();
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
	turtleTex.unbind();
	glPopMatrix();
}
-(void)setLineWidth:(float)_width
{
	lineWeight = _width;
}
-(void)resetTurtle
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
}
-(void)runFirstInstruction:(BaseInstruction*)_currentInstruction
{
	[self resetTurtle];
	ofSetColor(0xFFFFFF);
	ofRect(0, 0, 320, 480);
	// run all of the instructions
	turtleTex = bob.getTextureReference();
	ofSetColor(currentColor.red, currentColor.green, currentColor.blue);

	ofSetColor(0x000000);
	ofFill();
	[glHelper setupLighting];
	glEnable(GL_LIGHTING);
	glLineWidth(lineWeight);
	[self runInstruction:_currentInstruction];
	[self setBlendMode:0];
	// save to the photo library
//	
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
