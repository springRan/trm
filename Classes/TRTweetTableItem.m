//
//  TRTweetTableItem.m
//  trm
//
//  Created by will bailey on 3/17/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//

#import "Three20/Three20.h"
#import "TRTweetTableItem.h"


@implementation TRTweetTableItem
  @synthesize avatar;
  @synthesize avatarStyle;

- (id)itemWithText:(NSString *)text caption:(NSString *)caption avatar:(NSString *)avatar {
  TRTweetTableItem* item = [[[self alloc] init] autorelease];  
  item.text = text;  
  item.caption = caption;  
  item.avatar = avatar;  
  return item;
};

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
	if (self = [super init]) {
		avatar = nil;
		avatarStyle = nil;
	}
	return self;
}

- (void)dealloc {
	[avatar release];
	[avatarStyle release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.avatar = [decoder decodeObjectForKey:@"avatar"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	if (self.avatar) {
		[encoder encodeObject:self.avatar forKey:@"avatar"];
	}
}

@end
