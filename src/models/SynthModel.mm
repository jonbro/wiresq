#include "SynthModel.h"

@implementation synthModelObj

@synthesize Attack, Hold, Decay, Pitch, Cutoff, Res, wavType, Volume;

-(id)init
{
	self = [super init];
	return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:wavType forKey:@"wavType"];
	[coder encodeObject:Attack forKey:@"Attack"];
	[coder encodeObject:Hold forKey:@"Hold"];
	[coder encodeObject:Decay forKey:@"Decay"];
	[coder encodeObject:Pitch forKey:@"Pitch"];
	[coder encodeObject:Cutoff forKey:@"Cutoff"];
	[coder encodeObject:Res forKey:@"Res"];
	[coder encodeObject:Volume forKey:@"Vol"];
}
- (id)initWithCoder:(NSCoder *)coder
{
	self = [self init];
	self.wavType = [[coder decodeObjectForKey:@"wavType"] retain];
	self.Attack = [[coder decodeObjectForKey:@"Attack"] retain];
	self.Hold = [[coder decodeObjectForKey:@"Hold"] retain];
	self.Decay = [[coder decodeObjectForKey:@"Decay"] retain];
	self.Pitch = [[coder decodeObjectForKey:@"Pitch"] retain];
	self.Cutoff = [[coder decodeObjectForKey:@"Cutoff"] retain];
	self.Res = [[coder decodeObjectForKey:@"Res"] retain];
	if ([coder containsValueForKey:@"Vol"]) {
		self.Volume = [[coder decodeObjectForKey:@"Vol"] retain];
	}else {
		self.Volume = [NSNumber numberWithFloat:1.0];
	}
    return self;
}
@end

void SynthModel::setup()
{
	Attack = 0.001;
	Decay = 0.5;
	Hold = 0.0001;
	
	Cutoff = 0.5;
	Res = 0.0;
	wavType = 0;
	
	Volume = 1.0;
	printf("setting up synth: %i \n", sid);
}
void SynthModel::save()
{
	objCmodel.wavType = [NSNumber numberWithFloat:wavType];
	objCmodel.Attack = [NSNumber numberWithFloat:Attack];
	objCmodel.Hold = [NSNumber numberWithFloat:Hold];
	objCmodel.Decay = [NSNumber numberWithFloat:Decay];
	objCmodel.Pitch = [NSNumber numberWithFloat:Pitch];
	objCmodel.Cutoff = [NSNumber numberWithFloat:Cutoff];
	objCmodel.Res = [NSNumber numberWithFloat:Res];
	objCmodel.Volume = [NSNumber numberWithFloat:Volume];
}
void SynthModel::load()
{
	wavType = [objCmodel.wavType floatValue];
	Attack = [objCmodel.Attack floatValue];
	Hold = [objCmodel.Hold floatValue];
	Decay = [objCmodel.Decay floatValue];
	Pitch = [objCmodel.Pitch floatValue];
	Cutoff = [objCmodel.Cutoff floatValue];
	Res = [objCmodel.Res floatValue];
	Volume = [objCmodel.Volume floatValue];
}