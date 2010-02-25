#import "Twitter.h"

@implementation Twitter

@synthesize username;
@synthesize password;
@synthesize delegate;
@synthesize tweets;

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
    twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
    [twitterEngine setUsername:username password:password];
  }
}

- (NSString *) getFollowedTimelineAndNotifyObject:(id *) object withSelector:(SEL)selector{
  NSString *strSelector = NSStringFromSelector(selector);
  NSDictionary *callbackBinding = [[NSDictionary alloc] initWithObjectsAndKeys: strSelector, @"selector", object, @"object", nil];
  NSString *connectionIdentifier = [twitterEngine getFollowedTimelineSinceID:0 startingAtPage:0 count:30];
  if (!connections) {
    connections = [[NSMutableDictionary alloc] init];
  }
  [connections setValue:callbackBinding forKey:connectionIdentifier];
  return connectionIdentifier;
}

- (NSString *) getPublicTimeline {
	return [twitterEngine getPublicTimeline];
}

- (NSString *) getSearchResultsForQuery:(NSString *) q {
  return [twitterEngine getSearchResultsForQuery:q sinceID:0 startingAtPage:1 count:20];
}

#pragma mark -
#pragma mark MGTwitterEngine Delegate
- (void)requestSucceeded:(NSString *)connectionIdentifier
{
  NSLog(@"Request succeeded for connectionIdentifier = %@", connectionIdentifier);
}

- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error
{
  NSLog(@"Request failed for connectionIdentifier = %@, error = %@ (%@)", 
        connectionIdentifier, 
        [error localizedDescription], 
        [error userInfo]);
}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)connectionIdentifier
{
  if (!self.tweets) {
    self.tweets = [[NSMutableArray alloc] init];
  }
  for (int x=0; x<statuses.count; x++) {
    // @synthesize tweetId;
    // @synthesize fromUser;
    // @synthesize toUser;
    // @synthesize profileImageUrl;
    // @synthesize text;
		NSDictionary *tweet = [statuses objectAtIndex:x]; 
    [self.tweets addObject:tweet];
		NSLog(@"%@",tweet);
	}
  NSLog(@"tweets is %@", self.tweets);
  NSLog(@"processed %d tweets", self.tweets.count);
  id binding = [connections valueForKey:connectionIdentifier];
  if (binding) {
    NSLog(@"found binding");
    [[binding valueForKey:@"object"] performSelector:NSSelectorFromString([binding valueForKey:@"selector"])];
  }
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)connectionIdentifier
{
  NSLog(@"Got direct messages for %@:\r%@", connectionIdentifier, messages);
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier
{
  NSLog(@"Got user info for %@:\r%@", connectionIdentifier, userInfo);
}


- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got misc info for %@:\r%@", connectionIdentifier, miscInfo);
}

- (void)searchResultsReceived:(NSArray *)searchResults forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got search results for %@:\r%@", connectionIdentifier, searchResults);
	for (int x=0; x<searchResults.count; x++) {
		NSDictionary *tweetData = [searchResults objectAtIndex:x]; 
		NSLog(@"text %@",[tweetData valueForKey:@"text"]);
	}
}

//- (void)imageReceived:(NSImage *)image forRequest:(NSString *)connectionIdentifier
//{
//    NSLog(@"Got an image for %@: %@", connectionIdentifier, image);
//    
//		// Save image to the Desktop.
//    // NSString *path = [[NSString stringWithFormat:@"~/Desktop/%@.tiff", connectionIdentifier] stringByExpandingTildeInPath];
//    // [[image TIFFRepresentation] writeToFile:path atomically:NO];
//}

- (void)connectionFinished:(NSString *)connectionIdentifier
{
  NSLog(@"Connection finished %@", connectionIdentifier);
}

- (void)receivedObject:(NSDictionary *)dictionary forRequest:(NSString *)connectionIdentifier
{
  NSLog(@"Got an object for %@: %@", connectionIdentifier, dictionary);
}

@end
