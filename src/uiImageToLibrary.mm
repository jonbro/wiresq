//
//  uiImageToLibrary.mm
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/12/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "uiImageToLibrary.h"
#import "glHelper.h"
#import "ofMain.h"
#ifdef TARGET_OPENGLES
#include "glu.h"
#endif

void releaseData(void *info, const void *data, size_t dataSize) {
	NSLog(@"releaseData\n");
	free((void*)data);	 // free the
}

@implementation uiImageToLibrary

+(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	NSLog(@"Save finished\n");
	[image release];	 // release image
}

+(void)saveCurrentScreenToPhotoAlbum
{
	CGRect rect = [[UIScreen mainScreen] bounds];
	int width = rect.size.width;
	int height = rect.size.height;
	NSInteger myDataLength = width * height * 4;
	GLubyte *buffer = (GLubyte *) malloc(myDataLength);
	GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
	glReadPixels(0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
	for(int y = 0; y <height; y++) {
		for(int x = 0; x <width * 4; x++) {
			buffer2[int((height - 1 - y) * width * 4 + x)] = buffer[int(y * 4 * width + x)];
		}
	}
	free(buffer);	 // YOU CAN FREE THIS NOW
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, releaseData);
	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	int bytesPerRow = 4 * width;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
	CGColorSpaceRelease(colorSpaceRef);	 // YOU CAN RELEASE THIS NOW
	CGDataProviderRelease(provider);	 // YOU CAN RELEASE THIS NOW
	UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];	// change this to manual alloc/init instead of autorelease
	CGImageRelease(imageRef);	 // YOU CAN RELEASE THIS NOW
	UIImageWriteToSavedPhotosAlbum(image, self, (SEL)@selector(image:didFinishSavingWithError:contextInfo:), nil);	// add callback for finish saving
}
@end
