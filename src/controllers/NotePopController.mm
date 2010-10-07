#include "NotePopController.h"
#include "MainController.h"

void NotePopController::setup()
{
	fg.loadImage("images/note_pop_border.png");
	bg.loadImage("images/note_pop_bg.png");
	notes.loadImage("images/note_pop_notes.png");
	notes.setImageType(OF_IMAGE_COLOR_ALPHA);
	octaves.loadImage("images/note_pop_octaves.png");
	octaves.setImageType(OF_IMAGE_COLOR_ALPHA);
	x = ofGetWidth()/2.0-fg.getWidth()/2.0;
	y = ofGetHeight()/2.0-fg.getHeight()/2.0;
	width = fg.getWidth();
	height = fg.getHeight();

	leftPane.setup();
	leftPane.setPosAndSize(this->x, this->y, fg.getWidth()/2.0, fg.getHeight());
	leftPane.removeListeners();
	
	rightPane.setup();
	rightPane.setPosAndSize(this->x+fg.getWidth()/2.0, this->y, fg.getWidth()/2.0, fg.getHeight());
	rightPane.removeListeners();
	
	sliderOffset1 = -13;
	sliderOffset2 = (4*28)-10;
	fingerDown1 = false; 
	
	octaveNum = 5;
	noteNum = 0;
	
	showTime = ofGetElapsedTimeMillis();
}
void NotePopController::initDisplay(){
	octaveNum = rootModel->notes[editTargetX][editTargetY]/12;
	noteNum = rootModel->notes[editTargetX][editTargetY]%12;
}
void NotePopController::draw()
{
	bg.draw(this->x, this->y);
	drawRect(this->x+19, this->y+11, 32, 48, 0, sliderOffset1, 0);
	drawRect(this->x+74, this->y+11, 26, 48, 0, sliderOffset2, 1);
	fg.draw(this->x, this->y);
}
void NotePopController::update()
{
	if (!fingerDown1) {
		sliderOffset1 = ofLerp(sliderOffset1, (noteNum*28)-13, 0.5);
	}
	if (!fingerDown2) {
		sliderOffset2 = ofLerp(sliderOffset2, (octaveNum*28)-10, 0.5);
	}	
}
void NotePopController::touchDown(ofTouchEventArgs &touch)
{
	if (leftPane.hitTest(touch) && !fingerDown1) {
		fingerDown1 = true;
		fingerNumber1 = touch.id;
		fingerPos1 = touch.y;
	}
	if (rightPane.hitTest(touch) && !fingerDown2){
		fingerDown2 = true;
		fingerNumber2 = touch.id;
		fingerPos2 = touch.y;
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
	if (fingerDown2 && touch.id == fingerNumber2) {
		sliderOffset2 += fingerPos2 - touch.y;
		fingerPos2 = touch.y;
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
	}
	if (fingerDown2 && touch.id == fingerNumber2) {
		fingerDown2 = false;
		float remainder = fmod(sliderOffset2+10, 28);
		octaveNum = (int)((sliderOffset2+10)/28);
		if (remainder > 9) {
			octaveNum++;
		}
		octaveNum = ofClamp(octaveNum, 0, 9);
	}
	rootModel->notes[editTargetX][editTargetY] = noteNum+12*octaveNum;		
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
		tex = &octaves.getTextureReference();
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