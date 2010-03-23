//
//  TRTweetTableDelegate.m
//  trm
//
//  Created by will bailey on 3/23/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//

#import "TRTweetTableDelegate.h"


@implementation TRTweetTableDelegate

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"clicked it");
  NSDictionary *tweet = [[[Twitter singleton] tweets] objectAtIndex:(int)indexPath.row];
  [[[UIApplication sharedApplication] delegate] speakString:[tweet objectForKey:@"text"]];
}

@end
