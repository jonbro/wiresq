//
//  GLColorPickerView.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/18/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "GLColorPickerView.h"
#import "Color.h"
#import "ofxMSAShape3D.h"
#ifdef TARGET_OPENGLES
	#include "glu.h"
#endif

@implementation GLColorPickerView
-(id)initWithRect:(CGRect)_frame
{
	self = [super init];
	frame = _frame;
	//build picker texture
	pickerTex = pickerImage.getTextureReference();
	Color *c = [[Color alloc] init];
	[c setColorH:0 S:100 L:40];
	unsigned char pixels[(int)frame.size.width*(int)frame.size.height*3];
	for(int i=0;i<frame.size.width;i++)
	{
		for(int j=0;j<frame.size.height;j++)
		{
			int index = j*(int)frame.size.width*3 + i*3;
			pixels[index] = (int)c.red;
			pixels[index+1] = (int)c.green;
			pixels[index+2] = (int)c.blue;
		}
	}
	pickerTex.loadData(pixels, (int)frame.size.width, (int)frame.size.height, GL_RGB);
	return self;
}
-(void)render
{
	[super render];
	pickerTex.bind();
	colorPickerShape = new ofxMSAShape3D();

	colorPickerShape->begin(GL_TRIANGLE_STRIP);
	
	colorPickerShape->setTexCoord(0, 1);
	colorPickerShape->addVertex(frame.origin.x, frame.origin.y);

	colorPickerShape->setTexCoord(1, 1);
	colorPickerShape->addVertex(frame.origin.x+frame.size.width, frame.origin.y);

	colorPickerShape->setTexCoord(0, 0);
	colorPickerShape->addVertex(frame.origin.x, frame.origin.y+frame.size.height);
	
	colorPickerShape->setTexCoord(1, 0);
	colorPickerShape->addVertex(frame.origin.x+frame.size.width, frame.origin.y+frame.size.height);
	
	colorPickerShape->end();
	pickerTex.unbind();
}
@end
