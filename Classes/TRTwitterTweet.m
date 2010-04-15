#import "TRTwitterTweet.h"
#import "RegexKitLite.h"

@implementation TRTwitterTweet

@synthesize created         = _created;
@synthesize tweetId         = _tweetId;
@synthesize text            = _text;
@synthesize source          = _source;
@synthesize profileImageUrl = _profileImageUrl;
@synthesize userName        = _userName;
@synthesize userRealName    = _userRealName;
@synthesize userProfileUrl  = _userProfileUrl;

- (NSString *)speakableText {
  NSLog(@"text of tweet %@", self.text);
  if (!_speakableText) {
    NSLog(@"in here");
    NSString *sanitizedText = [self.text stringByReplacingOccurrencesOfRegex:@"http://\\S*" withString:@""];
    sanitizedText = [sanitizedText stringByReplacingOccurrencesOfRegex:@"[_<>-@]" withString:@" "];
    _speakableText = [NSString stringWithFormat:@"%@ said\\Pau=500\\ %@\\Pau=1000\\", 
                      self.userRealName, sanitizedText];
    
    [_speakableText retain];
  }
  return _speakableText;
}

- (void) dealloc {
  TT_RELEASE_SAFELY(_speakableText);
  TT_RELEASE_SAFELY(_created);
  TT_RELEASE_SAFELY(_tweetId);
  TT_RELEASE_SAFELY(_text);
  TT_RELEASE_SAFELY(_speakableText);
  TT_RELEASE_SAFELY(_source);
  TT_RELEASE_SAFELY(_profileImageUrl);
  TT_RELEASE_SAFELY(_userName);
  TT_RELEASE_SAFELY(_userRealName);
  TT_RELEASE_SAFELY(_userProfileUrl);
  [super dealloc];
}


@end
