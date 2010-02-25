#import "trmAppDelegate.h"
#import "RootViewController.h"

@implementation trmAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize loginViewController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  [window addSubview:[navigationController view]];
  [loginViewController setNavigationController:navigationController];
  [navigationController presentModalViewController:loginViewController animated:YES];
  [window makeKeyAndVisible];
}

- (void)userDidEnterCredentials {
  [self.navigationController dismissModalViewControllerAnimated:YES];
  [[Twitter singleton] getFollowedTimelineAndNotifyObject:[self.navigationController topViewController] withSelector:@selector(statusesReceived)];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Save data if appropriate
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

