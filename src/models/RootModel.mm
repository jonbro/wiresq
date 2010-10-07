//
//  RootModel.mm
//  ww
//
//  Created by jonbroFERrealz on 9/24/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//
#define RANDOMSTATES 0
#import "RootModel.h"

@implementation rootModelObj

@synthesize world, links, synths, bpm, clockMult, notes;

-(id)init
{
	self = [super init];
	world = [[NSMutableArray alloc] init];
	notes = [[NSMutableArray alloc] init];
	links = [[NSMutableArray alloc] init];
	synths = [[NSMutableArray alloc] init];
	bpm = [[NSNumber alloc] initWithFloat:120.0];
	clockMult = [[NSNumber alloc] initWithInt:2];
	return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
	NSLog(@"world: %i", [self.world count]);
	[coder encodeObject:world forKey:@"world"];
	[coder encodeObject:notes forKey:@"notes"];
	[coder encodeObject:links forKey:@"links"];
	[coder encodeObject:synths forKey:@"synths"];
	[coder encodeObject:bpm forKey:@"bpm"];
	[coder encodeObject:clockMult forKey:@"clockMult"];
}
- (id)initWithCoder:(NSCoder *)coder
{
	self = [self init];
	self.world = [[coder decodeObjectForKey:@"world"] retain];
	self.notes = [[coder decodeObjectForKey:@"notes"] retain];
	self.links = [[coder decodeObjectForKey:@"links"] retain];
	self.synths = [[coder decodeObjectForKey:@"synths"] retain];
	self.bpm = [[coder decodeObjectForKey:@"bpm"] retain];
	self.clockMult = [[coder decodeObjectForKey:@"clockMult"] retain];
    return self;
}
@end

RootModel::RootModel(){
	
	bpm = 120.0;
	clockMult = 2;
	
	currentState = 0;
	running = false;
	
	linkingSynths = false;

	ofxColorf myColor(.1, .2, .3);
	myColor.setMode(OF_COLOR_HSV);
	myColor.setRange(1);
	myColor.set(0, 1, 1);
	
	for (int i=0; i<8; i++) {
		synthData[i].setup();
		myColor.setMode(OF_COLOR_HSV).setHue((float)i/(float)(8+1));
		synthData[i].color = myColor;

	}
	//initialize world
	for (int i=0; i<NUMCELLSX; i++) {
		for (int j=0; j<NUMCELLSY; j++) {
			world[i][j][0] = 0;
			world[i][j][1] = 0;
			notes[i][j] = 60;
#if RANDOMSTATES
			int state = ofRandom(0, 5);
			world[i][j][0] = state;
			world[i][j][1] = state;
#endif
		}
	}
}
void RootModel::save(){
	// copy over all the data
	// world data
	printf("RootModel::save\n");
	
	NSNumber *clockMultObj = [[NSNumber numberWithInt:clockMult] retain];
	objcRootModel.clockMult = clockMultObj;
	[clockMultObj release];

	NSNumber *bpmObj = [[NSNumber numberWithFloat:bpm] retain];
	objcRootModel.bpm = bpmObj;
	[bpmObj release];
	
	[objcRootModel.world removeAllObjects];
	[objcRootModel.notes removeAllObjects];
	for (int y=0; y<NUMCELLSY; y++) {
		for (int x=0; x<NUMCELLSX; x++) {
			NSNumber *cell = [[NSNumber numberWithInt:world[x][y][0]]retain];
			NSNumber *note = [[NSNumber numberWithInt:notes[x][y]]retain];
			[objcRootModel.world addObject:cell];
			[objcRootModel.notes addObject:note];
			if (world[x][y][0] == 1) {
				NSLog(@"non zero");
			}			
			[cell release];
			[note release];
		}
	}
	// link data
	NSLog(@"num links: %i", [objcRootModel.links count]);
	[objcRootModel.links removeAllObjects];
	for (int i=0; i<8; i++) {
		NSArray *linkObject = [NSArray arrayWithObjects:[NSNumber numberWithInt:(int)synthLinks[i].x], [NSNumber numberWithInt:(int)synthLinks[i].y], nil];
		[objcRootModel.links addObject:linkObject];
	}
	// synth data
	for (int i=0; i<8; i++) {
		synthModelObj *objCsynthData = [[synthModelObj alloc] init];
		synthData[i].objCmodel = objCsynthData;
		synthData[i].save();
		[objcRootModel.synths addObject:objCsynthData];
	}
	// save the object to disk
	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:objcRootModel] forKey:@"savedArray"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
void RootModel::load(){
	NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
	NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"savedArray"];
	printf("RootModel::load\n");
	if (dataRepresentingSavedArray != nil)
	{
		printf("RootModel::load non nil\n");
		objcRootModel = [[NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray] retain];
		if([objcRootModel isKindOfClass:[rootModelObj class]]){
			bpm = [objcRootModel.bpm floatValue];
			clockMult = [objcRootModel.clockMult intValue];
			// copy data from the main object
			for (int y=0; y<NUMCELLSY; y++) {
				for (int x=0; x<NUMCELLSX; x++) {
					world[x][y][0] = world[x][y][1] = [[objcRootModel.world objectAtIndex:y*NUMCELLSX+x] intValue];
					notes[x][y] = [[objcRootModel.notes objectAtIndex:y*NUMCELLSX+x] intValue];
				}
			}
			for (int i=0; i<8; i++) {
				NSArray *linkObject = [objcRootModel.links objectAtIndex:i];
				synthLinks[i].set([[linkObject objectAtIndex:0]intValue], [[linkObject objectAtIndex:1] intValue]);
			}
			for (int i=0; i<8; i++) {
				synthModelObj *synthObject = [objcRootModel.synths objectAtIndex:i];
				synthData[i].objCmodel = synthObject;
				synthData[i].load();
			}
		}
	}else {
		objcRootModel = [[rootModelObj alloc] init];
	}
}
void RootModel::update(){
	if (running) {
		step();
	}
}
void RootModel::step(){
	//run the simulation one step
	for (int x=0; x<NUMCELLSX; x++) {
		for (int y=0; y<NUMCELLSY; y++) {
			if(world[x][y][0] == 2){
				world[x][y][1] = 3;
			}
			if(world[x][y][0] == 3){
				world[x][y][1] = 1;
			}
			if(world[x][y][0] == 1){
				int count = neighbors(x, y);
				if (count == 1 || count == 2) {
					world[x][y][1] = 2;
				}else {
					world[x][y][1] = 1;
				}
				
			}
		}
	}
	for (int x=0; x<NUMCELLSX; x++) {
		for (int y=0; y<NUMCELLSY; y++) {
			world[x][y][0] = world[x][y][1];
		}
	}
}
int RootModel::neighbors(int x, int y){
	int count = 0;
	
	if(world[(x + 1) % NUMCELLSX][y][0] == 2)
		count++;
	if(world[x][(y + 1) % NUMCELLSY][0] == 2)
		count++;
	if(world[(x + NUMCELLSX - 1) % NUMCELLSX][y][0] == 2)
		count++;
	if(world[x][(y + NUMCELLSY - 1) % NUMCELLSY][0] == 2)	
		count++;
	if(world[(x + 1) % NUMCELLSX][(y + 1) % NUMCELLSY][0] == 2)	
		count++;	
	if(world[(x + NUMCELLSX - 1) % NUMCELLSX][(y + 1) % NUMCELLSY][0] == 2)	
		count++;	
	if(world[(x + NUMCELLSX - 1) % NUMCELLSX][(y + NUMCELLSY - 1) % NUMCELLSY][0] == 2)	
		count++;	
	if(world[(x + 1) % NUMCELLSX][(y + NUMCELLSY - 1) % NUMCELLSY][0] == 2)	
		count++;	
	return count;
}

