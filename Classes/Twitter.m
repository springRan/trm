#import "Twitter.h"

@implementation Twitter

@synthesize username;
@synthesize password;

static Twitter * Twitter_Singleton = nil;

+ (Twitter *)singleton
{
    if (nil == Twitter_Singleton)
    {
        Twitter_Singleton = [[Twitter alloc] init];
    }
    return Twitter_Singleton;
}

- (id) setUsername:(NSString *) usernameArg andPassword:(NSString *) passwordArg {
	if (self = [super init]){
		username=usernameArg;
		password=passwordArg;
		twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
		[twitterEngine setUsername:username password:password];
	}
	return self;
}

- (NSString *) getPublicTimeline {
	return [twitterEngine getPublicTimeline];
}

- (NSString *) getSearchResultsForQuery:(NSString *) q {
	return [twitterEngine getSearchResultsForQuery:q sinceID:0 startingAtPage:1 count:20];
}


// MGTwitterEngineDelegate Implementation
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
	for (int x=0; x<statuses.count; x++) {
		NSDictionary *tweetData = [statuses objectAtIndex:x]; 
		NSLog(@"text %@",[tweetData valueForKey:@"text"]);
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
	//    NSString *path = [[NSString stringWithFormat:@"~/Desktop/%@.tiff", connectionIdentifier] stringByExpandingTildeInPath];
	//    [[image TIFFRepresentation] writeToFile:path atomically:NO];
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
