//
//  TRSettingsTableViewController.h
//  trm
//
//  Created by will bailey on 4/13/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TRSettingsTableViewController : TTTableViewController <UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
  UIPickerView *_voicePicker;
  CGRect _voicePickerOffScreen;
  CGRect _voicePickerOnScreen;
}
//- (void)setVoicePicker:(BOOL)visibility;
@end
