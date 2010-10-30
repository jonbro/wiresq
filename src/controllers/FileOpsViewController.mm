//
//  FileOpsViewController.mm
//  ww
//
//  Created by jonbroFERrealz on 10/13/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//

#import "FileOpsViewController.h"


@implementation FileOpsViewController

-(id)init{
	self = [super init];
	load = [[UITabBarItem alloc]initWithTitle:@"load" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"load_tab" ofType:@"png" inDirectory:@"images"]] tag:0];
	save = [[UITabBarItem alloc]initWithTitle:@"save" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"save_tab" ofType:@"png" inDirectory:@"images"]] tag:0];
	
	loadView = [[LoadViewController alloc]init];
	loadView.tabBarItem = load;

	saveView =  [[SaveViewController alloc]init];
	saveView.tabBarItem = save;
	
	self.viewControllers = [NSArray arrayWithObjects:loadView, saveView, nil];
	
	return self;
}

@end
