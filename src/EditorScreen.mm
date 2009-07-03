//
//  EditorScreen.m
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "EditorScreen.h"
#import "colorScheme.h"
#ifdef TARGET_OPENGLES
	#include "glu.h"
#endif

@implementation EditorScreen
-(id)init
{
	self = [super init];
	displayMenu = false;
	touchingInstruction = false;
	fingerPos = [[Vector2d alloc] initWithX:0 Y:0];
	fingerDownPos = [[Vector2d alloc] initWithX:0 Y:0];
	fingerCounter = 0;
	frame = CGRectMake(0, 0, 320, 480);
	interstate.loadFont("Avenir_Medium.ttf", 14);
	instructions = [[NSMutableArray alloc]init];
	return self;
}
-(void)render
{
	for(CustomEventResponder* subview in subviews)
	{
		[subview render];
	}
//	for(int i=0;i<[instructions count];i++){
//		Vector2d* pos = [[instructions objectAtIndex:i]pos];
//		[colorScheme drawColor2];
//		ofRect(pos.x , pos.y, 40, 40);
//	}
	if(displayMenu){
		// should replace this with a full menu view at some point.
		
		[colorScheme drawColor1];
		ofRect(fingerDownPos.x , fingerDownPos.y, interstate.stringWidth("MOVEMENT")+20, interstate.stringHeight("MOVEMENT")+20);
		ofSetColor(0, 0, 0);
		interstate.drawString("MOVEMENT", fingerDownPos.x+10, fingerDownPos.y+14+interstate.stringHeight("MOVEMENT")/2);
	}
	if(touchingInstruction){
		glPushMatrix();
		glTranslatef(0, 420, 0);
		[currentInstruction renderEditor];
		glPopMatrix();
	}
}
-(void)update
{
	if(ofGetElapsedTimeMillis()-fingerTimer>200 && fingerCounter==1 && !touchingInstruction){
		displayMenu = true;
	}
}

-(void)touchDown:(TouchEvent*)_tEvent
{
	fingerCounter++;
	fingerDownPos	= [[Vector2d alloc] initWithX:_tEvent.x_pos	Y:_tEvent.y_pos];
	fingerTimer = ofGetElapsedTimeMillis();
}
-(void)touchUp:(TouchEvent*)_tEvent
{
	NSLog(@"here");
	float y_max = fingerDownPos.y+interstate.stringHeight("MOVEMENT")+20;
	float x_max = fingerDownPos.x+interstate.stringWidth("MOVEMENT")+20;
	if(_tEvent.x_pos > fingerDownPos.x && _tEvent.y_pos > fingerDownPos.y && _tEvent.x_pos < x_max && _tEvent.y_pos < y_max){
		MoveInstruction *instruction = [[MoveInstruction alloc]initWithFrame:CGRectMake(_tEvent.x_pos, _tEvent.x_pos, 40, 40)];
		instruction.amount = [NSNumber numberWithInt:20];
		instruction.direction = [NSMutableString stringWithString:@"forward"];
		instruction.pos = [[Vector2d alloc]initWithX:_tEvent.x_pos	Y:_tEvent.y_pos];
		[instructions addObject:instruction];
		[self addSubview:instruction];
	}
}
-(void)touchMoved:(TouchEvent*)_tEvent
{}
-(void)touchMoveX:(float)x Y:(float)y ID:(float)touchID
{
	if(touchingInstruction){
		if(y>400){
			[currentInstruction touchMoveX:x Y:y ID:touchID];
		}else{
			Vector2d* pos = [currentInstruction pos];
			pos.x = x;
			pos.y = y;
		}
	}
	fingerPos.x = x;
	fingerPos.y = y;
}
-(void)touchUpX:(float)x Y:(float)y ID:(float)touchID
{
	// check to see if we are over a menu item, lol haha, this is just for one tho.
//	touchingInstruction = false;
	displayMenu = false;
	fingerCounter--;
}
@end
