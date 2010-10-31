//
//  FileOpsViewController.mm
//  ww
//
//  Created by jonbroFERrealz on 10/13/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//

#import "FileOpsViewController.h"


@implementation FileOpsViewController

@synthesize rootModel;

-(id)init
{
	self = [super init];
	main = [[UITabBarItem alloc]initWithTitle:@"main" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"main_tab" ofType:@"png" inDirectory:@"images"]] tag:0];
	load = [[UITabBarItem alloc]initWithTitle:@"load" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"load_tab" ofType:@"png" inDirectory:@"images"]] tag:0];
	save = [[UITabBarItem alloc]initWithTitle:@"save" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"save_tab" ofType:@"png" inDirectory:@"images"]] tag:0];
	
	loadView = [[LoadViewController alloc]init];
	loadView.tabBarItem = load;

	saveView =  [[SaveViewController alloc]init];
	saveView.tabBarItem = save;
	
	mainView = ofxiPhoneGetGLView();
	mainViewDummyController = [[UIViewController alloc]init];
	mainViewDummyController.tabBarItem = main;

	self.viewControllers = [NSArray arrayWithObjects:mainViewDummyController, loadView, saveView, nil];
	self.selectedIndex = 1;
	lastViewController = self.selectedViewController;
	self.delegate = self;
	return self;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	if (viewController == mainViewDummyController) {
		// switch back to the main view
		UIView *currentView = self.view;
		
		// get the the underlying UIWindow, or the view containing the current view view
		UIView *theWindow = [currentView superview];
		
		// remove the current view and replace with myView1
		[currentView removeFromSuperview];
		[theWindow addSubview:mainView];
		
		// set up an animation for the transition between the views
		CATransition *animation = [CATransition animation];
		[animation setDuration:0.5];
		[animation setType:kCATransitionPush];
		[animation setSubtype:kCATransitionFromLeft];
		[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
		[[theWindow layer] addAnimation:animation forKey:@"SwitchToMain"];
		
		// roll back the selected view
		// to the previous selected one
		self.selectedViewController = lastViewController;
		
		ofSetFrameRate(30);
	}
	lastViewController = viewController;
}
-(void)save
{
	rootModel->saveToFile(saveView.textField.text);
	NSLog(@"save from parent");
}
-(void)loadFromFile:(NSString *)filename
{
	rootModel->loadFromFile(filename);
}
@end
