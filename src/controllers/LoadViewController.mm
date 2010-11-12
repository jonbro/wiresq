//
//  LoadViewController.mm
//  ww
//
//  Created by jonbroFERrealz on 10/13/10.
//  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
//

#import "LoadViewController.h"


@implementation LoadViewController
-(id)init
{
	self = [super init]; 
	
	files = [[NSMutableArray alloc]init];
	[self loadFiles];
	return self;
}
-(void)loadFiles
{
	[files removeAllObjects];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSArray *docsContent = [[NSFileManager defaultManager] directoryContentsAtPath:documentsDirectory];
	for (int i=0; i<[docsContent count]; i++) {
		NSString *file = [docsContent objectAtIndex:i];
		NSLog(@"filename: %s", file);
		if ([[file pathExtension] isEqualToString:@"wsq"]) {
			[files addObject:file];
		}
	}
	[self.view reloadData];
}
-  (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section 
{
	return [files count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell.hidesAccessoryWhenEditing = YES;
	}
	
	cell.accessoryType = UITableViewCellAccessoryNone;

	cell.textLabel.text = [files objectAtIndex:indexPath.row];
	return cell;
}
- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
	// load the file
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];

	[self.parentViewController loadFromFile:[documentsDirectory stringByAppendingPathComponent:[files objectAtIndex:indexPath.row]]];

	// go back to the main screen
}


@end
