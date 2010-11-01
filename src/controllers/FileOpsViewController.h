#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoadViewController.h"
#import "SaveViewController.h"
#import "ofMain.h"
#include "ofxiPhoneExtras.h"
#import "RootModel.h"
#import "HelpViewController.h"

@interface FileOpsViewController : UITabBarController <UITabBarControllerDelegate> {
	UITabBarItem *save, *load, *main, *help;
	LoadViewController *loadView;
	SaveViewController *saveView;
	HelpViewController* helpView;

	EAGLView *mainView;
	
	UIViewController *mainViewDummyController;
	UIViewController *lastViewController;
	
	RootModel *rootModel;
}

@property (assign) RootModel *rootModel;

-(void)save;
-(void)loadFromFile:(NSString *)filename;
-(void)goToMainController;

@end
