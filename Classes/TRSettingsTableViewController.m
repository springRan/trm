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
#import "AcapelaSpeech.h"

@implementation TRSettingsTableViewController
-(id) init {
	if (self = [super init]) {

		self.title = @"User Settings";
		self.tableViewStyle = UITableViewStyleGrouped;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"done" 
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(doneClicked)];
		
		self.navigationItem.rightBarButtonItem = doneButton;
    
    // background view
    TTView *backgroundView = [[TTView alloc] initWithFrame:CGRectMake(0,0,320,460)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    [self.view addSubview:self.tableView];
    
    // account instructions
    TTLabel *accountInstructions = [[TTLabel alloc] initWithFrame:CGRectMake(10, 40, 300, 20)];
    accountInstructions.text = @"enter your Twitter account:";
    accountInstructions.style = TTSTYLE(instructions);
    accountInstructions.backgroundColor = [UIColor clearColor];
    [self.view addSubview:accountInstructions];
    

    // picker instructions
    TTLabel *pickerInstructions = [[TTLabel alloc] initWithFrame:CGRectMake(10, 224, 300, 20)];
    pickerInstructions.text = @"select a voice:";
    pickerInstructions.style = TTSTYLE(instructions);
    pickerInstructions.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pickerInstructions];
    
    // setup the voice picker
    _voicePickerOnScreen = CGRectMake(0, 244, 320, 216);
    _voicePickerOffScreen = CGRectMake(0, 460, 320, 216);
    _voicePicker = [[UIPickerView alloc] init];
    _voicePicker.delegate = self;
    _voicePicker.dataSource = self;
    _voicePicker.showsSelectionIndicator = YES;
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
  
  self.tableView.frame = CGRectMake(0, 60, 320, 400);
  
  // voice picker
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  int voiceId = [prefs integerForKey:@"voice_id"];
  _voicePicker.frame = _voicePickerOnScreen;
  [self.view addSubview:_voicePicker];
  [_voicePicker selectRow:voiceId inComponent:0 animated:NO];
  [super viewWillAppear:animated];
}

- (void)viewDidLoad{
  [((TRSettingsTableDataSource *)self.dataSource).loginField becomeFirstResponder];
}

- (void)createModel {
	self.dataSource = [[TRSettingsTableDataSource alloc] init];
}

- (id<UITableViewDelegate>)createDelegate {
  return self;
}

- (void)doneClicked {
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  [prefs setObject:((TRSettingsTableDataSource *)self.dataSource).loginField.text forKey:@"login"];
  [prefs setObject:((TRSettingsTableDataSource *)self.dataSource).passwordField.text forKey:@"password"];
  [self dismissModalViewController];
}

///
// TABLE VIEW DELEGATE
///
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  if (!_voicePicker) {
//    _voicePickerOnScreen = CGRectMake(0, 244, 320, 216);
//    _voicePickerOffScreen = CGRectMake(0, 460, 320, 216);
//    _voicePicker = [[UIPickerView alloc] init];
//    _voicePicker.delegate = self;
//    _voicePicker.dataSource = self;
//    _voicePicker.showsSelectionIndicator = YES;
//    _voicePicker.frame = _voicePickerOnScreen;
//  }
//  [self.view addSubview:_voicePicker];
////	if(_voicePicker.frame.origin.y < _voicePickerOffScreen.origin.y) { // off screen
////    [self setVoicePicker:NO];
////	} else { // on screen, show a done button
////    [self setVoicePicker:YES];
////	}
//}

//- (void)setVoicePicker:(BOOL)visibility {
//	[UIView beginAnimations:@"CalendarTransition" context:nil];
//	[UIView setAnimationDuration:0.3];
//	if(visibility) { // off screen
//		_voicePicker.frame = _voicePickerOnScreen;
//		// update new transit lines
//	} else { // on screen, show a done button
//		_voicePicker.frame = _voicePickerOffScreen;
//	}
//	[UIView commitAnimations];
//}

- (void)dealloc{
  TT_RELEASE_SAFELY(_voicePicker);
  [super dealloc];
}

//
// PICKERVIEW DELEGATE DATASOURCE
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  return [[AcapelaSpeech availableVoices] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
  NSString *voiceName = [[AcapelaSpeech availableVoices] objectAtIndex:row];
  NSDictionary* voiceAttributes = [AcapelaSpeech attributesForVoice:voiceName];
  return [voiceAttributes objectForKey:@"AcapelaVoiceName"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  [prefs setInteger:row forKey:@"voice_id"];
}
@end
