//
//  glHelper.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 5/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "glHelper.h"
#import "ofMain.h"
#ifdef TARGET_OPENGLES
	#include "glu.h"
#endif

@implementation glHelper
+(void)setupLighting
{
	// Turn the first light on
    glEnable(GL_LIGHT0);
    // Define the ambient component of the first light
    const GLfloat light0Ambient[] = {0.1, 0.1, 0.1, 1.0};
    glLightfv(GL_LIGHT0, GL_AMBIENT, light0Ambient);
    
    // Define the diffuse component of the first light
    const GLfloat light0Diffuse[] = {0.7, 0.7, 0.7, 1.0};
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light0Diffuse);
    
    // Define the specular component and shininess of the first light
    const GLfloat light0Specular[] = {0.7, 0.7, 0.7, 1.0};
    const GLfloat light0Shininess[] = {0.4, 0.4, 0.4, 1.0};
    glLightfv(GL_LIGHT0, GL_SPECULAR, light0Specular);
    glLightfv(GL_LIGHT0, GL_SHININESS, light0Shininess);
    
    
    // Define the position of the first light
    const GLfloat light0Position[] = {0.0, 10.0, 40.0, 0.0}; 
    glLightfv(GL_LIGHT0, GL_POSITION, light0Position); 
    
    // Define a direction vector for the light, this one points right down the Z axis
    const GLfloat light0Direction[] = {0.0, 0.0, -1.0};
    glLightfv(GL_LIGHT0, GL_SPOT_DIRECTION, light0Direction);
	
    // Define a cutoff angle. This defines a 90° field of vision, since the cutoff
    // is number of degrees to each side of an imaginary line drawn from the light's
    // position along the vector supplied in GL_SPOT_DIRECTION above
    glLightf(GL_LIGHT0, GL_SPOT_CUTOFF, 45.0);
	glEnable(GL_COLOR_MATERIAL);	
}
@end
