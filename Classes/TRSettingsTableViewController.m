//
//  TRSettingsTableViewController.m
//  trm
//
//  Created by will bailey on 4/13/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//
#import "TRDefaultStylesheet.h"
#import "TRSettingsTableViewController.h"
#import "TRSettingsTableDataSource.h"

@implementation TRSettingsTableViewController
-(id) init {
	if (self = [super init]) {
		self.title = @"User Settings";
		self.tableViewStyle = UITableViewStyleGrouped;
    self.tableView.backgroundColor = TTSTYLEVAR(darkGrayColor);
    
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"done" 
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(doneClicked)];
		
		self.navigationItem.rightBarButtonItem = doneButton;
	}
	return self;
}

- (void)createModel {
	self.dataSource = [[TRSettingsTableDataSource alloc] init];
}

- (void)doneClicked {
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  [prefs setObject:((TRSettingsTableDataSource *)self.dataSource).loginField.text forKey:@"login"];
  [prefs setObject:((TRSettingsTableDataSource *)self.dataSource).passwordField.text forKey:@"password"];
  [self dismissModalViewController];
}

@end
