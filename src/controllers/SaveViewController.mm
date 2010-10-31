//
//  SaveViewController.mm
//  ww
//
//  Created by jonbroFERrealz on 10/13/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//

#import "SaveViewController.h"


@implementation SaveViewController

@synthesize rootModel, textField;

-(id)init
{
	self = [super init];
	self.view.backgroundColor = [UIColor colorWithRed:0.298 green:0.333 blue:0.345 alpha:1.000];
	int left = 60;
	fileNameLabel = [[UIImageView alloc] initWithFrame:CGRectMake(left, 140, 210, 37)];
	fileNameLabel.image = [UIImage imageWithContentsOfFile:
						   [[NSBundle mainBundle] pathForResource:@"label_file_name" ofType:@"png" inDirectory:@"images"]];
	[fileNameLabel sizeToFit];
	
	textFieldContainer = [[UIImageView alloc] initWithFrame:CGRectMake(left, fileNameLabel.frame.origin.y+22, 210, 37)];
	textFieldContainer.image = [UIImage imageWithContentsOfFile:
									 [[NSBundle mainBundle] pathForResource:@"text_input_bg" ofType:@"png" inDirectory:@"images"]];
	int padding = 6;
	textField = [[UITextField alloc] 
				 initWithFrame:CGRectMake(
					textFieldContainer.frame.origin.x+padding,
					textFieldContainer.frame.origin.y+padding,
					textFieldContainer.frame.size.width-padding*2,
					textFieldContainer.frame.size.height-padding*2
				 )
				];
	textField.returnKeyType = UIReturnKeyDone;
	textField.delegate = self;
	
	saveButton = [[UIButton alloc]initWithFrame:CGRectMake(left, textFieldContainer.frame.size.height+textFieldContainer.frame.origin.y+10, 49, 36)];
	[saveButton 
		setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button_save" ofType:@"png" inDirectory:@"images"]] 
		forState:UIControlStateNormal
	];
	[saveButton addTarget:self 
				action:@selector(saveClick) 
				forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:fileNameLabel];
	[self.view addSubview:textFieldContainer];
	[self.view addSubview:textField];
	[self.view addSubview:saveButton];
	return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)_textField {
	[_textField resignFirstResponder];
	return NO;
}
-(void)saveClick
{
	[self.parentViewController save];
	[textField resignFirstResponder];
}
@end