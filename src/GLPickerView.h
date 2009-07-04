//
//  GLPickerView.h
//  rotator
//
//  Created by jonbroFERrealz on 5/31/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ofMain.h"
#import "Events.h"
#import "TouchEvent.h"
#import "CustomEventResponder.h"
@protocol GLPickerViewDelegate;
@protocol GLPickerViewDataSource;

@interface GLPickerView : CustomEventResponder {
	int							selected;
	float						fingerStart;
	bool						fingerDown;
	float						floatSelected;
	id<GLPickerViewDelegate>	_delegate;
	id<GLPickerViewDataSource>	_dataSource;
	ofTrueTypeFont				interstate;
}

@property(nonatomic, assign) id<GLPickerViewDelegate> _delegate;
@property(nonatomic, assign) id<GLPickerViewDataSource> _dataSource;

-(void)render;
-(void)update;
-(void)touchDown:(TouchEvent*)_tEvent;
- (void)touchMoved:(TouchEvent*)_tEvent;

@end

@protocol GLPickerViewDelegate
-(NSString*)pickerView:(GLPickerView*)pickerView titleForRow:(NSInteger)row;
@optional
-(void)pickerView:(GLPickerView *)pickerView didSelectRow:(NSInteger)row;
@end

@protocol GLPickerViewDataSource
-(NSInteger)numberOfRowsInPickerView:(GLPickerView*)pickerView;
@end
