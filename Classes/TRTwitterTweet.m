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
    NSString *sanitizedText = [self.text stringByReplacingOccurrencesOfRegex:@"http://\\S*" withString:@""];
    sanitizedText = [sanitizedText stringByReplacingOccurrencesOfRegex:@"[_<>-@]" withString:@" "];
    _speakableText = [NSString stringWithFormat:@"%@\\Pau=500\\ %@\\Pau=1000\\", 
                      self.userRealName, sanitizedText];
    
    [_speakableText retain];
  }
  return _speakableText;
}

- (NSString *)relativeTimestamp {
	NSDate *todayDate = [NSDate date];
	double ti = [self.created timeIntervalSinceDate:todayDate];
	ti = ti * -1;
	if(ti < 1) {
		return @"just now";
	} else      if (ti < 60) {
		return @"just now";
	} else if (ti < 3600) {
		int diff = round(ti / 60);
    if (diff == 1) {
      return [NSString stringWithFormat:@"1 minute ago"];
    } else {
      return [NSString stringWithFormat:@"%d minutes ago", diff];
    }
	} else if (ti < 86400) {
		int diff = round(ti / 60 / 60);
    if (diff == 1) {
      return[NSString stringWithFormat:@"1 hour ago"];
    } else {
      return[NSString stringWithFormat:@"%d hours ago", diff];
    }
	} else if (ti < 2629743) {
		int diff = round(ti / 60 / 60 / 24);
    if (diff == 1) {
      return[NSString stringWithFormat:@"1 day ago"];
    } else {
      return[NSString stringWithFormat:@"%d days ago", diff];
    }
	} else {
		return @"awhile ago";
	}   
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
