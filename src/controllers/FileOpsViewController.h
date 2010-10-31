#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoadViewController.h"
#import "SaveViewController.h"
#import "ofMain.h"
#include "ofxiPhoneExtras.h"
#import "RootModel.h"

@interface FileOpsViewController : UITabBarController <UITabBarControllerDelegate> {
	UITabBarItem *save, *load, *main;
	LoadViewController *loadView;
	SaveViewController *saveView;
	EAGLView *mainView;
	UIViewController *mainViewDummyController;
	UIViewController *lastViewController;
	RootModel *rootModel;
}

@property (assign) RootModel *rootModel;

-(void)save;
-(void)loadFromFile:(NSString *)filename;

@end
