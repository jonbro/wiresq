
#include "ofPointUtils.h"

float ofpDot(const ofPoint v1, const ofPoint v2)
{
	return v1.x*v2.x + v1.y*v2.y;
}
ofPoint ofpNormalize(const ofPoint v)
{
	return v*(1.0f/ofpLength(v));
}
float ofpLength(const ofPoint v)
{
	return sqrtf(ofpLengthSQ(v));
}
float ofpLengthSQ(const ofPoint v)
{
	return ofpDot(v, v);
}
