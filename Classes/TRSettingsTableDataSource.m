//
//  TRSettingsTableDataSource.m
//  trm
//
//  Created by will bailey on 4/13/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//

#import "TRSettingsTableDataSource.h"


@implementation TRSettingsTableDataSource

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* sections = [[NSMutableArray alloc] init];
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	[sections addObject:@""];
	NSMutableArray* itemRows = [[NSMutableArray alloc] init];
	
	UITextField *_loginField = [[UITextField alloc] init];
	_loginField.placeholder = @"login";
	_loginField.delegate = self;
	_loginField.autocorrectionType = UITextAutocorrectionTypeNo;
	_loginField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//	_loginField.text = [[SFAccount instance] login];
	[itemRows addObject:[TTTableControlItem itemWithCaption:@"" control:_loginField]];
  
	UITextField *_passwordField = [[UITextField alloc] init];
	_passwordField.placeholder = @"password";
	_passwordField.secureTextEntry = YES;
	_passwordField.delegate = self;
	_passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
//	_passwordField.text = [[SFAccount instance] password];
	_passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	[itemRows addObject:[TTTableControlItem itemWithCaption:@"" control:_passwordField]];
  
	[_loginField becomeFirstResponder];
	
	[items addObject:itemRows];
	self.sections = sections;
	self.items = items;
	TT_RELEASE_SAFELY(sections);
}


@end
