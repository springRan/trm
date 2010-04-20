#import "TRTweetTableItem.h"
#import "TRTwitterTweet.h"

@implementation TRTweetTableItem

@synthesize tweet = _tweet;
@synthesize content = _content;
@synthesize speaking = _speaking;

- (id)initWithTweet:(TRTwitterTweet *)tweet 
{
  if (self = [super init]){
    self.tweet = tweet;
  }
  return self;
}

- (TTStyledText *)content
{
	if (!_content) {
		_content = [TTStyledText textFromXHTML:_tweet.text];
		_content.font = TTSTYLEVAR(font);
    [_content retain];
	}
	return _content;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_tweet);
  [super dealloc];
}

@end