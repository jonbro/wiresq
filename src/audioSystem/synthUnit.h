#pragma once
#include "ofMain.h"
#include "MoogFilter.h"

#define SAMPLERATE 44100
#define BUFFER_SIZE 256

class SynthUnit {
public:
	void audioRequested( float * output, int bufferSize, int nChannels );
	void triggerSynth(int _startOffset, float pitch);
	void setup();
	float getSampleTriangle();
	float getSampleSquare();
	float getSampleNoise();
	void setFrequency(float frequency);
	
	MoogFilter filterLeft, filterRight;
	float phase;
	float phaseIncrement;
	
	// internal state of the sampler
	int offset, startOffset, wavType;
	float pitch;
	bool hasMix;
	float holdTime, outTime, inTime, volume;
	
	// sampler data
	float sampleDelta, samplePos;
	float noiseSampleData[22050];
	int loopStart, loopEnd, numPackets;
	
};