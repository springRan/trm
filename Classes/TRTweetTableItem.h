#import "Three20/Three20.h"
#import "TRTwitterTweet.h"

@interface TRTweetTableItem : TTTableItem {
  TRTwitterTweet* _tweet;
  TTStyledText* _content;
}

@property(nonatomic,retain) TRTwitterTweet *tweet;
@property(nonatomic,retain) TTStyledText *content;

- (id)initWithTweet:(TRTwitterTweet *)tweet;
@end

