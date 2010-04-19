//
//  TabBarController.m
//  trm
//
//  Created by will bailey on 4/18/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//

#import "TRTabBarController.h"


@implementation TRTabBarController
- (void)viewDidLoad {
  [self setTabURLs:[NSArray arrayWithObjects:@"tt://tweets/search",@"tt://tweets/account",nil]];
}

@end
