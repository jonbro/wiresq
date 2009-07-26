//
//  GLScrollView.mm
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/14/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "GLScrollView.h"


@implementation GLScrollView
@synthesize touchingHere;
-(id)init
{
	self = [super init];
	currentTranslation = CGAffineTransformIdentity;
	touchingHere = CGPointMake(160, 240);
	return self;
}
-(void)touchDown:(TouchEvent*)_tEvent
{
//	_tEvent.currentTransform = currentTranslation;
	touchingHere = CGPointMake(_tEvent.pos.x, _tEvent.pos.y);
}
-(bool)insideX:(float)x Y:(float)y
{
	return	true;
}
-(void)touchMoved:(TouchEvent*)_tEvent
{
	float diffX = _tEvent.pos.x - _tEvent.prevTouch.pos.x;
	float diffY = _tEvent.pos.y - _tEvent.prevTouch.pos.y;
	currentTranslation = CGAffineTransformConcat(currentTranslation, CGAffineTransformMakeTranslation(diffX, diffY));
}
-(bool)hasTransform
{
	return true;
}
-(void)render
{
	glPushMatrix();
	static GLfloat m[16];
	CGAffineToGL(&currentTranslation, m);
	glMultMatrixf(m);
	ofSetColor(255, 0, 0);
	ofRect(touchingHere.x, touchingHere.y, 6, 6);
	[super render];
	glPopMatrix();
}
@end
