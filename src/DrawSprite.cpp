/*
 *  DrawSprite.cpp
 *  logo_fighter
 *
 *  Created by jonbroFERrealz on 7/12/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */


#include "DrawSprite.h"

ofxMSAShape3D *spriteShape;
ofImage moveImage;
ofTexture moveTex;

void drawRectSprite(int tex, int x, int y, int width, int height, int offset_x, int offset_y)
{
	if(!spriteShape){
		spriteShape = new ofxMSAShape3D();
		moveImage.loadImage("move_atlas.png");
		moveImage.setImageType(OF_IMAGE_COLOR_ALPHA);
		moveTex = moveImage.getTextureReference();		
	}
	int atlasWidth = 128;
	int atlasHeight = 64;
	
	float t_1 = (float)offset_x/(float)atlasWidth;
	float t_2 = (float)(offset_x+width)/(float)atlasWidth;
	
	float u_1 = (float)(atlasHeight-offset_y)/(float)atlasHeight;
	float u_2 = (float)(atlasHeight-(offset_y+height))/(float)atlasHeight;
	
	moveTex.bind();	
	ofSetColor(255, 255, 255);
	glPushMatrix();
	spriteShape->enableColor(false);
	spriteShape->begin(GL_TRIANGLE_STRIP);

	spriteShape->setTexCoord(t_1, u_1);
	spriteShape->addVertex(x, y);
	
	spriteShape->setTexCoord(t_2, u_1);
	spriteShape->addVertex(x+width, y);
	
	spriteShape->setTexCoord(t_1, u_2);
	spriteShape->addVertex(x, y+height);
	
	spriteShape->setTexCoord(t_2, u_2);
	spriteShape->addVertex(x+width, y+height);
	
	spriteShape->end();
	glPopMatrix();
	
	moveTex.unbind();	
}