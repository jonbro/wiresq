//
//  connectionNode.m
//  logo_fighter
//
//  Created by Jonathan Brodsky on 7/5/09.
//  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
//

#import "ConnectionNode.h"
#import "ofMain.h"
#import "colorScheme.h"
#ifdef TARGET_OPENGLES
#include "glu.h"
#endif


@implementation ConnectionNode
@synthesize incomingInstruction;
-(void)render
{
	if(incomingInstruction != nil){
		ofSetColor(0xFFFFFF);
		glPushMatrix();
		glTranslatef(frame.origin.x, frame.origin.y, 0);
		ofRect(0, 0, frame.size.width, frame.size.height);
		glPopMatrix();
	}
}
-(void)attachIncomingInstruction
{
	[(BaseInstruction*)superview attachInstruction:incomingInstruction toNode:self];
}
@end
