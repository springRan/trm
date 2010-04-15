#import "Three20/Three20.h"

@interface TRTwitterTweet : NSObject {
  NSDate*   _created;
  NSNumber* _tweetId;
  NSString* _text;
  NSString* _speakableText;
  NSString* _source;
  NSString* _profileImageUrl;
  NSString* _userName;
  NSString* _userRealName;
  NSString* _userProfileUrl;
}

@property (nonatomic, retain) NSDate*   created;
@property (nonatomic, retain) NSNumber* tweetId;
@property (nonatomic, copy)   NSString* text;
@property (nonatomic, copy)   NSString* source;
@property (nonatomic, copy)   NSString* profileImageUrl;
@property (nonatomic, copy)   NSString* userName;
@property (nonatomic, copy)   NSString* userRealName;
@property (nonatomic, copy)   NSString* userProfileUrl;

- (NSString *)speakableText;
- (NSString *)relativeTimestamp;
@end
