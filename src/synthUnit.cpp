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
				volumeModifier = volume;
			}
			if(offset>inTime+holdTime)
				volumeModifier = 1.0-((float)offset-inTime-holdTime)/outTime;
			output[j*2] = getSample();
			filterLeft.processSample(&output[j*2]);
			output[j*2] *= volumeModifier;
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
}

float SynthUnit::getSample() {
	// this might not be a square wave, look more like a triangle
	phase += phaseIncrement;						// update the phase of the oscillator
	if(phase>=2*PI) phase -= 2*PI;					// wrap it around
	return phase<PI ? (-1.f + (2.f*phase/PI)):(1.f - (2.f*(phase-PI)/PI)); // generate the signal
}