#include "MixerController.h"
#include "MainController.h"

void MixerController::setup()
{
	currentSynth = 0;
	frameCounter = 0;
	for (int i=0; i<8; i++) {
		synths[i].setup();
	}
	calculateRate();
}
void MixerController::calculateRate()
{
	float clockMult = rootModel->clockMult;
	float bpm = rootModel->bpm;
	beatLength = (22050.0*60/bpm)/clockMult;
}
void MixerController::audioRequested(float * output, int bufferSize, int nChannels) {
	calculateRate();
	for(int i = 0; i < bufferSize; i++) {
		int remainder = frameCounter%beatLength;			
		if(remainder == 0){
			currentBeat = (currentBeat+1)%16;
			rootModel->update();
			for(int i=0;i<rootModel->synthLinks.size();i++){
				SynthLink *link = &rootModel->synthLinks[i];
				if (rootModel->world[(int)link->x][(int)link->y][0] == 2 && rootModel->running) {
					currentSynth = (currentSynth+1)%8;
					link->triggerTime = ofGetElapsedTimeMillis();
					//rootModel->synthLinks[j].synth = j;
					if (mainController->scroller.triggersToDisplay.size() < 20) {
						mainController->scroller.triggersToDisplay.push_front(*link);
					}
					// copy over the synth data
					float pitch = rootModel->notes[(int)link->x][(int)link->y];
					synths[currentSynth].wavType = rootModel->synthData[link->synth].wavType;
					synths[currentSynth].filterLeft.setRes(rootModel->synthData[link->synth].Res);
					synths[currentSynth].filterLeft.setCutoff(rootModel->synthData[link->synth].Cutoff);
					synths[currentSynth].inTime = 10000.0 * rootModel->synthData[link->synth].Attack;
					synths[currentSynth].holdTime = 22500.0 * rootModel->synthData[link->synth].Hold;
					synths[currentSynth].outTime = 88200.0 * sin(rootModel->synthData[link->synth].Decay*PI/2.0);
					synths[currentSynth].triggerSynth(0, pitch);					
				}
			}			
			for (int j=0; j<8; j++) {
					
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
			output[i] += mixBuffer[i]*0.125;
			if (!mixBuffer) {
				mixBuffer=(float *)malloc(bufferSize*2*sizeof(float));
			}
			audioOff = fmax(fabs(output[i]), audioOff);
		}	
	}
	free(mixBuffer);	
}
