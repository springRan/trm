#import "Three20/Three20.h"
#import "TRTwitterTweet.h"

@interface TRTweetTableItemCell : TTStyledTextTableItemCell {
  TTImageView* _avatar;
  UILabel* _username;
  UILabel* _timestamp;
  TTImageView* _playingIndicator;
}

- (TRTwitterTweet *)tweet;

@end
