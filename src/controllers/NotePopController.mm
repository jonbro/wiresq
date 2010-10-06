#include "NotePopController.h"
#include "MainController.h"

void NotePopController::setup()
{
	fg.loadImage("images/note_pop_border.png");
	bg.loadImage("images/note_pop_bg.png");
	notes.loadImage("images/note_pop_notes.png");
	notes.setImageType(OF_IMAGE_COLOR_ALPHA);
	octaves.loadImage("images/note_pop_octaves.png");
	x = ofGetWidth()/2.0-fg.getWidth()/2.0;
	y = ofGetHeight()/2.0-fg.getHeight()/2.0;
	width = fg.getWidth();
	height = fg.getHeight();
	leftPane.setup();
	leftPane.setPosAndSize(this->x, this->y, fg.getWidth()/2.0, fg.getHeight());
	leftPane.removeListeners();
	sliderOffset1 = -13;
	fingerDown1 = false;
	showTime = ofGetElapsedTimeMillis();
}
void NotePopController::draw()
{
	bg.draw(this->x, this->y);
	drawRect(this->x+19, this->y+11, 32, 48, 0, sliderOffset1, 0);
	fg.draw(this->x, this->y);
}
void NotePopController::update()
{
	if (!fingerDown1) {
		// slide back the the nearest note
//		float nearestBelow = fmod(sliderOffset1,28);
//		nearestBelow = (int)((sliderOffset1-5)/28)*28;
//		nearestBelow+=5;
		sliderOffset1 = ofLerp(sliderOffset1, (noteNum*28)-13, 0.5);
	}
}
void NotePopController::touchDown(ofTouchEventArgs &touch)
{
	if (leftPane.hitTest(touch) && !fingerDown1) {
		fingerDown1 = true;
		fingerNumber1 = touch.id;
		fingerPos1 = touch.y;
	}
	if (fingerDown1 == false && !this->hitTest(touch) && ofGetElapsedTimeMillis() - showTime>200) {
		mainController->changeScreen("scroller");
	}
}
void NotePopController::touchMoved(ofTouchEventArgs &touch)
{
	if (fingerDown1 && touch.id == fingerNumber1) {
		sliderOffset1 += fingerPos1 - touch.y;
		fingerPos1 = touch.y;
	}
}
void NotePopController::touchUp(ofTouchEventArgs &touch)
{
	if (fingerDown1 && touch.id == fingerNumber1) {
		fingerDown1 = false;
		float remainder = fmod(sliderOffset1+13, 28);
		noteNum = (int)((sliderOffset1+13)/28);
		if (remainder > 14) {
			noteNum++;
		}
		noteNum = ofClamp(noteNum, 0, 10);
		rootModel->notes[editTargetX][editTargetY] = noteNum+60;
	}
}
bool NotePopController::hitTest(ofTouchEventArgs &touch)
{
	if (touch.x > x && touch.x < width+x
		&& touch.y > y && touch.y < height+y) {
		return true;
	}
	return false;
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