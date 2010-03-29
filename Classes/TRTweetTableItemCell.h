#import "Three20/Three20.h"
#import "TRTwitterTweet.h"

@interface TRTweetTableItemCell : TTTableTextItemCell {
  TTImageView* _imageView2;
}

@property(nonatomic,readonly,retain) TTImageView* imageView2;

- (TRTwitterTweet *)tweet;

@end
