#import "TRAppDelegate.h"
#import "TRTwitterTweet.h"
#import "TRTweetTableItemCell.h"
#import "TRSettingsTableViewController.h"

@implementation TRAppDelegate

@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  // setup three20 global stylesheet
  [TTStyleSheet setGlobalStyleSheet:[[[TRDefaultStyleSheet alloc]   
                                      init] autorelease]];
  // setup in app settings
  window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  //////////////////////////////////////////
  // ROUTES
  //////////////////////////////////////////
  TTNavigator *_navigator = [TTNavigator navigator];
  _navigator.persistenceMode = TTNavigatorPersistenceModeNone;
  _navigator.window = window;

  TTURLMap* map = _navigator.URLMap;

  // default route
  [map from:@"*" toViewController:[TTWebController class]];
    
  // user settings route
  [map from:@"tt://settings" toModalViewController:[TRSettingsTableViewController class]];

  // user settings route
  [map from:@"tt://tweets" toSharedViewController:[TRTweetTableViewController class]];

  TTOpenURL(@"tt://tweets");

  // load up the app or ask for credentials
  [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Save data if appropriate
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[window release];
	[super dealloc];
}


@end

