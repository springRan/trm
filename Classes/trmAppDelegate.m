#import "trmAppDelegate.h"
#import "RootViewController.h"

@implementation trmAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize loginViewController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  [[Twitter singleton] setDelegate:(id *)self];
  [window addSubview:[navigationController view]];
  [loginViewController setNavigationController:navigationController];
  [navigationController presentModalViewController:loginViewController animated:YES];
  [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Save data if appropriate
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


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

