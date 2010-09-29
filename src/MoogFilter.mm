//
//  MoogFilter2.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/8/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "MoogFilter.h"


void MoogFilter::setup()
{
	b0 = b1 = b2 = b3 = b4 = 0.0;  //filter buffers (beware denormals!)
	t1 = t2 = 0.0;              //temporary buffers
	lowPass = true;
}	
void MoogFilter::setRes(float _res)
{
	resonance = _res;
	calc();
}
void MoogFilter::setCutoff(float _cutoff)
{
	_cutoff *= 2.0;
	if(_cutoff<1.0){
		cutoff = _cutoff;
		lowPass = true;
	}else{
		cutoff = _cutoff-1.0;
		lowPass = false;
	}
	cutoff = fmin(fmax(cutoff, 0.0), 1.0);
	calc();
}
void MoogFilter::calc()
{
	q = 1.0 - cutoff;
	p = cutoff + 0.8 * cutoff * q;
	f = p + p - 1.0;
	q = resonance * (1.0 + 0.5 * q * (1.0f - q + 5.6 * q * q));
}

void MoogFilter::processSample(float *inputSample)
{
	*inputSample -= q * b4;                          //feedback
	t1 = b1;  b1 = (*inputSample + b0) * p - b1 * f;
	t2 = b2;  b2 = (b1 + t1) * p - b2 * f;
	t1 = b3;  b3 = (b2 + t2) * p - b3 * f;
	b4 = (b3 + t1) * p - b4 * f;
	b4 -= b4 * b4 * b4 * 0.166667;    //clipping
	b0 = *inputSample;
	if(lowPass){
		*inputSample = b4;
	}else{
		*inputSample = *inputSample-b4;
	}
}
