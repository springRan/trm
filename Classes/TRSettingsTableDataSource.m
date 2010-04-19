//
//  TRSettingsTableDataSource.m
//  trm
//
//  Created by will bailey on 4/13/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//

#import "TRSettingsTableDataSource.h"
#import "AcapelaSpeech.h"


@implementation TRSettingsTableDataSource
@synthesize loginField = _loginField;
@synthesize passwordField = _passwordField;
//@synthesize voiceField = _voiceField;

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray *sections = [[NSMutableArray alloc] init];
	NSMutableArray *items = [[NSMutableArray alloc] init];
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  
	[sections addObject:@""];
	NSMutableArray* itemRows = [[NSMutableArray alloc] init];
	
	_loginField = [[UITextField alloc] init];
	_loginField.placeholder = @"login";
	_loginField.delegate = self;
	_loginField.autocorrectionType = UITextAutocorrectionTypeNo;
	_loginField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_loginField.text = [prefs objectForKey:@"login"];
	[itemRows addObject:[TTTableControlItem itemWithCaption:@"" control:_loginField]];
  
	_passwordField = [[UITextField alloc] init];
	_passwordField.placeholder = @"password";
	_passwordField.secureTextEntry = YES;
	_passwordField.delegate = self;
	_passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
	_passwordField.text = [prefs objectForKey:@"password"];
	_passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	[itemRows addObject:[TTTableControlItem itemWithCaption:@"" control:_passwordField]];
  
//  _voiceField = [[UITextField alloc] init];
//  _voiceField.enabled = NO;
//  
//  NSString *voiceName = [[AcapelaSpeech availableVoices] objectAtIndex:(int)[prefs integerForKey:@"voice_id"]];
//  NSDictionary* voiceAttributes = [AcapelaSpeech attributesForVoice:voiceName];
//  _voiceField.text = [voiceAttributes objectForKey:@"AcapelaVoiceName"];
//	[itemRows addObject:[TTTableControlItem itemWithCaption:@"voice" control:_voiceField]];
  
  
	[items addObject:itemRows];
	self.sections = sections;
	self.items = items;
	TT_RELEASE_SAFELY(sections);
}




@end
