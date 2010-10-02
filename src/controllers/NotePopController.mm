#include "NotePopController.h"

void NotePopController::setup()
{
	fg.loadImage("images/note_pop_border.png");
	bg.loadImage("images/note_pop_bg.png");
	notes.loadImage("images/note_pop_notes.png");
	notes.setImageType(OF_IMAGE_COLOR_ALPHA);
	octaves.loadImage("images/note_pop_octaves.png");
	this->x = ofGetWidth()/2.0-fg.getWidth()/2.0;
	this->y = ofGetHeight()/2.0-fg.getHeight()/2.0;
	this->width = fg.width;
	this->width = fg.height;
	leftPane.setup();
	leftPane.setPosAndSize(this->x, this->y, fg.getWidth()/2.0, fg.getHeight());
	leftPane.removeListeners();
	sliderOffset1 = -13;
}
void NotePopController::draw()
{
	bg.draw(this->x, this->y);
	// draw the notes in here
	drawRect(this->x+19, this->y+11, 32, 48, 0, sliderOffset1, 0);
//	notes.draw(this->x+12, this->y+11);
	fg.draw(this->x, this->y);
	//leftPane.draw();
}
void NotePopController::touchDown(ofTouchEventArgs &touch)
{
	if (leftPane.hitTest(touch) && !fingerDown1) {
		fingerDown1 = true;
		fingerNumber1 = touch.id;
		fingerPos1 = touch.y;
		printf("GETTING TOUCH \n");
	}
}
void NotePopController::touchMoved(ofTouchEventArgs &touch)
{
	if (fingerDown1 && touch.id == fingerNumber1) {
		printf("GETTING TOUCH \n");
		sliderOffset1 += fingerPos1 - touch.y;
		fingerPos1 = touch.y;
	}
}
void NotePopController::touchUp(ofTouchEventArgs &touch)
{
	if (fingerDown1 && touch.id == fingerNumber1) {
		fingerDown1 = false;
	}
}

void NotePopController::drawRect(int x, int y, int width, int height, int inputWidth, int inputHeight, int offset_x, int offset_y, int texture)
{	
	int atlasWidth = notes.getWidth();
	int atlasHeight = notes.getHeight();
	ofTexture *tex;
	if(texture == 0){
		tex = &notes.getTextureReference();
	}else if(texture == 1){
		octaves.getTextureReference().bind();
		atlasWidth = octaves.getWidth();
		atlasHeight = octaves.getHeight();
	}
	tex->bind();
	atlasWidth = tex->getWidth();
	atlasHeight = tex->getHeight();

	float t_1 = tex->getCoordFromPoint(offset_x, offset_y).x;
	float t_2 = tex->getCoordFromPoint(offset_x+inputWidth, offset_y+inputHeight).x;
	
	float u_1 = tex->getCoordFromPoint(offset_x, offset_y).y;
	float u_2 = tex->getCoordFromPoint(offset_x, offset_y+inputHeight).y;
	
	glPushMatrix();
	myShape.begin(GL_TRIANGLE_STRIP);
	myShape.setColor(1.0, 1.0, 1.0, 1.0);
	myShape.setTexCoord(t_1, u_1);
	myShape.addVertex(x, y);
	
	myShape.setTexCoord(t_2, u_1);
	myShape.addVertex(x+width, y);
	
	// going to move these up based on mutes eventually
	myShape.setTexCoord(t_1, u_2);
	myShape.addVertex(x, y+height);
	
	myShape.setTexCoord(t_2, u_2);
	myShape.addVertex(x+width, y+height);
	
	myShape.end();
	glPopMatrix();
	if(texture == 0){
		notes.getTextureReference().unbind();
	}else if(texture == 1){
		octaves.getTextureReference().unbind();
	}
}
void NotePopController::drawRect(int x, int y, int width, int height, int offset_x, int offset_y, int texture)
{
	this->drawRect(x, y, width, height, width, height, offset_x, offset_y, texture);
}