/*
 *  DrawSprite.cpp
 *  logo_fighter
 *
 *  Created by Jonathan Brodsky on 7/12/09.
 *  Released into the Public Domain 2009 Heavy Ephemera Industries. No rights reserved.
 *
 */


#include "DrawSprite.h"

ofxMSAShape3D *spriteShape;
ofImage moveImage, controlImage, currentImage;
ofTexture moveTex, controlTex, currentTex;
void drawRectSprite(int tex, int x, int y, int width, int height, int offset_x, int offset_y, int scale_width, int scale_height)
{
	if(!spriteShape){
		spriteShape = new ofxMSAShape3D();
		
		moveImage.loadImage("move_atlas.png");
		moveImage.setImageType(OF_IMAGE_COLOR_ALPHA);
		moveTex = moveImage.getTextureReference();		
		
		controlImage.loadImage("control_atlas.png");
		controlImage.setImageType(OF_IMAGE_COLOR_ALPHA);
		controlTex = controlImage.getTextureReference();		
	}
	
	switch (tex) {
		case 0:
			currentImage = moveImage;
			currentTex = moveTex;
			break;
		default:
			currentImage = controlImage;
			currentTex = controlTex;
			break;
	}
	
	int atlasWidth = currentImage.width;
	int atlasHeight = currentImage.height;
	
	float t_1 = (float)offset_x/(float)atlasWidth;
	float t_2 = (float)(offset_x+width)/(float)atlasWidth;
	
	float u_1 = (float)(atlasHeight-offset_y)/(float)atlasHeight;
	float u_2 = (float)(atlasHeight-(offset_y+height))/(float)atlasHeight;
	
	currentTex.bind();	
	ofSetColor(255, 255, 255);
	glPushMatrix();
	spriteShape->enableColor(false);
	spriteShape->begin(GL_TRIANGLE_STRIP);
	
	spriteShape->setTexCoord(t_1, u_1);
	spriteShape->addVertex(x, y);
	
	spriteShape->setTexCoord(t_2, u_1);
	spriteShape->addVertex(x+scale_width, y);
	
	spriteShape->setTexCoord(t_1, u_2);
	spriteShape->addVertex(x, y+scale_height);
	
	spriteShape->setTexCoord(t_2, u_2);
	spriteShape->addVertex(x+scale_width, y+scale_height);
	
	spriteShape->end();
	glPopMatrix();
	
	currentTex.unbind();	
}
void drawRectSprite(int tex, int x, int y, int width, int height, int offset_x, int offset_y)
{
	drawRectSprite(tex, x, y, width, height, offset_x, offset_y, width, height);
}