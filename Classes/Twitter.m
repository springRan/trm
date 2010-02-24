#import "Twitter.h"

@implementation Twitter

@synthesize username;
@synthesize password;
@synthesize delegate;

static Twitter * Twitter_Singleton = nil;

+ (Twitter *)singleton
{
    if (nil == Twitter_Singleton)
    {
        Twitter_Singleton = [[Twitter alloc] init];
    }
    return Twitter_Singleton;
}

- (void) setUsername:(NSString *) usernameArg andPassword:(NSString *) passwordArg {
  if (self = [super init]){
    username=usernameArg;
    password=passwordArg;
    twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self.delegate];
    [twitterEngine setUsername:username password:password];
  }
}

- (NSString *) getPublicTimeline {
	return [twitterEngine getPublicTimeline];
}

- (NSString *) getSearchResultsForQuery:(NSString *) q {
  return [twitterEngine getSearchResultsForQuery:q sinceID:0 startingAtPage:1 count:20];
}

@end
