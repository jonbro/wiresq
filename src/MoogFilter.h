#pragma once

class MoogFilter{
public:
	float f, p, q, cutoff, resonance;             //filter coefficients
	float b0, b1, b2, b3, b4;  //filter buffers (beware denormals!)
	float t1, t2;              //temporary buffers
	bool lowPass;
	void setup();
	void setCutoff(float _cutoff);
	void setRes(float _res);
	void calc();
	void processSample(float *sample);
};