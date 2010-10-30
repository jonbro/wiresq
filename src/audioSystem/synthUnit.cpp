/*
 *  synthUnit.cpp
 *  audioSkope
 *
 *  Created by jonbroFERrealz on 11/24/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "synthUnit.h"

void SynthUnit::setup()
{
	outTime = 25500.0;
	inTime = 1500.0;
	holdTime = 0.0;
	volume = 1.0;
	
	filterLeft.setup();
	filterLeft.setRes(1.0);
	filterRight.setup();
	wavType = 0;
	// load up our noise data
	for (int i=0; i<22050; i++) {
		noiseSampleData[i] = ofRandom(-0.5, 0.5);
	}
	numPackets = 22050;
}
void SynthUnit::audioRequested( float * output, int bufferSize, int nChannels )
{
	float volumeModifier = 1.0;
	for(int j = 0; j < bufferSize; j++) {
		if(startOffset > 0){
			startOffset -= 1;
		}else if(offset<holdTime+outTime+inTime){
			if(offset<inTime)
				volumeModifier = ((float)offset)/inTime+0.01;
			if (offset>inTime&&offset<inTime+holdTime) {
				volumeModifier = 1.0;
			}
			if(offset>inTime+holdTime)
				volumeModifier = 1.0-((float)offset-inTime-holdTime)/outTime;
			switch (wavType) {
				case 0:
					output[j*2] = getSampleTriangle();
					break;
				case 1:
					output[j*2] = getSampleSquare();
					break;
				default:
					output[j*2] = getSampleNoise();
					break;
			}
			filterLeft.processSample(&output[j*2]);
			output[j*2] *= volumeModifier*volume;
			output[j*2+1] = output[j*2];
			offset++;
		}else {
			output[j*2] = 0.0;
			output[j*2+1] = 0.0;
		}
	}
}
void SynthUnit::triggerSynth(int _startOffset, float pitch) // centered on 60
{
	setFrequency(440.0*pow(2.0, (pitch-60.0)/12.0));
	startOffset = _startOffset;
	offset = 0;
}
void SynthUnit::setFrequency(float frequency) {
	phaseIncrement = frequency*2*PI/SAMPLERATE;		// calculate how much we need to increment the phase for each sample
	sampleDelta = frequency/440.0; // don't need the fundamenta frequency here
}

float SynthUnit::getSampleTriangle() {
	phase += phaseIncrement;						// update the phase of the oscillator
	if(phase>=2*PI) phase -= 2*PI;					// wrap it around
	return phase<PI ? (-1.f + (2.f*phase/PI)):(1.f - (2.f*(phase-PI)/PI)); // generate the signal
}
float SynthUnit::getSampleSquare() {
	phase += phaseIncrement;						// update the phase of the oscillator
	if(phase>=2*PI) phase -= 2*PI;					// wrap it around
	return phase<PI ? -1.f:1.f; // generate the signal
}
float SynthUnit::getSampleNoise() {
	samplePos += sampleDelta;
	if (samplePos>=numPackets) {
		samplePos = 0;
	}
	return noiseSampleData[(int)samplePos];
}