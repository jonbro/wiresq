#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoadViewController.h"
#import "SaveViewController.h"

@interface FileOpsViewController : UITabBarController {
	UITabBarItem *save, *load;
	LoadViewController *loadView;
	SaveViewController *saveView;

}

@end
