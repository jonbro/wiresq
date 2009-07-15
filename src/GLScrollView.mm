//
//  GLScrollView.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/14/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "GLScrollView.h"


@implementation GLScrollView
-(id)init
{
	self = [super init];
	currentTranslation = CGAffineTransformIdentity;
	touchingHere = CGPointMake(160, 240);
	return self;
}
-(void)touchDown:(TouchEvent*)_tEvent
{
	touchingHere = CGPointMake(_tEvent.pos.x, _tEvent.pos.y);
}
-(void)touchMoved:(TouchEvent*)_tEvent
{
	float diffX = _tEvent.pos.x - _tEvent.prevTouch.x_pos;
	float diffY = _tEvent.pos.y - _tEvent.prevTouch.y_pos;
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
