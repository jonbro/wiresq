//
//  LoadViewController.h
//  ww
//
//  Created by jonbroFERrealz on 10/13/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RootModel.h"

@interface SaveViewController : UIViewController<UITextFieldDelegate> {
	UITextField	*textField;
	UIImageView	*textFieldContainer;
	UIImageView	*fileNameLabel;
	UIButton	*saveButton;
	RootModel *rootModel;
}
@property (assign) RootModel* rootModel;
@property (retain) UITextField	*textField;

-(void)saveClick;

@end
