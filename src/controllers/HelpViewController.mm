//
//  HelpViewController.m
//  ww
//
//  Created by jonbroFERrealz on 10/31/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//

#import "HelpViewController.h"


@implementation HelpViewController
-(id)init
{
	self = [super init];
	webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 431)];
	// [webView setFrame:CGRectMake(0, 0, 320, 480)];
	// Override point for customization after application launch
	// NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"sampleBrowser"];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"help"];
	NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
	NSURL *baseURL = [NSURL fileURLWithPath:path];
	
	NSString *htmlString = [[NSString alloc] initWithData: 
							[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
	webView.delegate = self;
	webView.scalesPageToFit = YES;
	[webView loadHTMLString:htmlString baseURL:baseURL];
	[self.view addSubview:webView];
	
	return self;
}
@end
