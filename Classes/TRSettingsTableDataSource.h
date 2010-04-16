//
//  TRSettingsTableDataSource.h
//  trm
//
//  Created by will bailey on 4/13/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TRSettingsTableDataSource : TTSectionedDataSource <UITextFieldDelegate> {
  UITextField *_loginField;
  UITextField *_passwordField;
}
@property (readonly, nonatomic) UITextField *loginField;
@property (readonly, nonatomic) UITextField *passwordField;

@end
