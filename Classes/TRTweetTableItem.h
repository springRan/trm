//
//  TRTweetTableItem.h
//  trm
//
//  Created by will bailey on 3/17/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//

#import "Three20/Three20.h"


@interface TRTweetTableItem : TTTableCaptionItem {
  NSString* avatar;
  TTStyle* avatarStyle;
}

@property(nonatomic,copy) NSString* avatar;  
@property(nonatomic,retain) TTStyle* avatarStyle;

- (id)itemWithText:(NSString *)text caption:(NSString *)caption avatar:(NSString *)avatar;

@end
