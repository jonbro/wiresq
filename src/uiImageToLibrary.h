//
//  uiImageToLibrary.h
//  logo_fighter
//
//  Created by jonbroFERrealz on 7/12/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface uiImageToLibrary : NSObject {

}
+(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
+(void)saveCurrentScreenToPhotoAlbum;

@end
