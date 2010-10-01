#include "MixerController.h"

void MixerController::setup()
{
	float clockMult = 2.0;
	float bpm = 120.0;
	beatLength = (22050.0*60/bpm)/clockMult;
	for (int i=0; i<8; i++) {
		synths[i].setup();
	}
	currentSynth = 0;
	frameCounter = 0;	
}
void MixerController::audioRequested(float * output, int bufferSize, int nChannels) {
	for(int i = 0; i < bufferSize; i++) {
		int remainder = frameCounter%beatLength;			
		if(remainder == 0){
			currentBeat = (currentBeat+1)%16;
			rootModel->update();
			for (int j=0; j<8; j++) {
				if (rootModel->world[(int)rootModel->synthLinks[j].x][(int)rootModel->synthLinks[j].y][0] == 2 && rootModel->running) {
					printf("trigger \n");
					currentSynth = (currentSynth+1)%8;
					// copy over the synth data
					float pitch = (rootModel->synthData[j].Pitch-0.5)*30.0+60.0;
					synths[currentSynth].filterLeft.setRes(rootModel->synthData[j].Res);
					synths[currentSynth].filterLeft.setCutoff(rootModel->synthData[j].Cutoff);
					synths[currentSynth].inTime = 10000.0 * rootModel->synthData[j].Attack;
					synths[currentSynth].holdTime = 22500.0 * rootModel->synthData[j].Hold;
					synths[currentSynth].outTime = 88200.0 * sin(rootModel->synthData[j].Decay*PI/2.0);
					synths[currentSynth].triggerSynth(0, pitch);
				}
			}
		}
		frameCounter++;
	}
	float *mixBuffer = 0;
	for (int j=0; j<8; j++) {
		if (!mixBuffer) {
			mixBuffer=(float *)malloc(bufferSize*2*sizeof(float));
		}
		synths[j].audioRequested(mixBuffer, bufferSize, nChannels);
		for(int i = 0; i < bufferSize*nChannels; i++) {
			output[i] += mixBuffer[i]*0.5;
			if (!mixBuffer) {
				mixBuffer=(float *)malloc(bufferSize*2*sizeof(float));
			}
			audioOff = fmax(fabs(output[i]), audioOff);
		}	
	}
	free(mixBuffer);	
}
