#pragma once

class SynthLink{
public:
	void set(float _x, float _y);
	float x, y;
	int triggerTime;
	int synth, linkNumber;	// link number is how many synths have already been linked to this cell
							// I am caching it so that it can be used to render the wires correctly
};