#import "Three20/Three20.h"
#import "TRTwitterTweet.h"

@interface TRTweetTableItem : TTTableItem {
  TRTwitterTweet* _tweet;
  TTStyledText* _content;
  BOOL _speaking;
}

@property(nonatomic,retain) TRTwitterTweet *tweet;
@property(nonatomic,retain) TTStyledText *content;
@property(nonatomic) BOOL speaking;

- (id)initWithTweet:(TRTwitterTweet *)tweet;
@end

