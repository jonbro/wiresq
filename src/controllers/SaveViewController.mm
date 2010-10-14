//
//  SaveViewController.mm
//  ww
//
//  Created by jonbroFERrealz on 10/13/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//

#import "SaveViewController.h"


@implementation SaveViewController
-(id)init
{
	self = [super init];
	self.view.backgroundColor = [UIColor grayColor];
	textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
	textField.backgroundColor = [UIColor whiteColor];
	textField.returnKeyType = UIReturnKeyDone;
	textField.delegate = self;
	[self.view addSubview:textField];
	return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)_textField {
	// do the saving in here.
	[_textField resignFirstResponder];
	return NO;
}
@end