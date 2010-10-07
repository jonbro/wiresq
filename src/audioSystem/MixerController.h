#pragma once
#include "synthUnit.h"
#include "RootModel.h"

class MainController;

class MixerController{
public:
	void setup();
	void calculateRate();
	void audioRequested(float * output, int bufferSize, int nChannels);
	
	RootModel *rootModel;
	MainController *mainController;
	
	SynthUnit synths[8];
	int currentBeat, currentSynth;
	int pitchPos;
	int frameCounter;
	int beatLength;
	float audioOff, audioOffInterp;	
};