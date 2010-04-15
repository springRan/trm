#import "Three20/Three20.h"
#import "TRTwitterTweet.h"

@interface TRTweetTableItemCell : TTTableLinkedItemCell {
  TTImageView* _avatar;
  TTLabel* _username;
  TTLabel* _timestamp;
  TTImageView* _playingIndicator;
  TTStyledTextLabel* _label;
}

- (TRTwitterTweet *)tweet;

@end
