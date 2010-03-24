#import "TRAppDelegate.h"

@implementation TRAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize loadingOverlay;
@synthesize settingsController;
@synthesize trTweetTableViewController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  // setup three20 global stylesheet
  [TTStyleSheet setGlobalStyleSheet:[[[TRDefaultStyleSheet alloc]   
                                      init] autorelease]];
  // setup in app settings
  [InAppSettings registerDefaults];
  
  window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  trTweetTableViewController = [[TRTweetTableViewController alloc] initWithStyle:UITableViewStylePlain];
  navigationController = [[UINavigationController alloc] initWithRootViewController:trTweetTableViewController];
  [window addSubview:[navigationController view]];
  
  UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] 
                                 initWithTitle:@"settings" 
                                 style:UIBarButtonItemStyleBordered 
                                 target:self 
                                 action:@selector(presentSettings)];
  
  trTweetTableViewController.navigationItem.leftBarButtonItem = settingsButton;
  [settingsButton release];
  
  // load up the app or ask for credentials
  if (![[Twitter singleton] userNameAndPasswordSet]) {
    [self presentSettings];
  }
  [window makeKeyAndVisible];
}

  // show the settings view
- (void)presentSettings{
  NSLog(@"presenting settings!");
  if (!settingsController){
    settingsController = [[InAppSettingsViewController alloc] init];
  }
  settingsController.navigationItem.hidesBackButton = YES;
  settingsController.title = @"tweetrad.io";
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                 initWithTitle:@"done"
                                 style:UIBarButtonItemStyleBordered  
                                 target:self 
                                 action:@selector(dismissSettings)];
  settingsController.navigationItem.rightBarButtonItem = doneButton;
  [doneButton release];
  [navigationController pushViewController:settingsController animated:YES];
}

  //dismiss the settings view
- (void)dismissSettings {
  [navigationController popViewControllerAnimated:YES];
  [trTweetTableViewController loadData];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Save data if appropriate
}

- (void)speakString:(NSString *)string {
  if (!acapelaLicense){
    NSString* aLicenseString = [[NSString alloc] initWithCString:babLicense 
                                                      encoding:NSASCIIStringEncoding]; 
    acapelaLicense = [[AcapelaLicense alloc] initLicense:aLicenseString 
                                                    user:uid.userId 
                                                  passwd:uid.passwd];
  
    [acapelaLicense retain];
    [aLicenseString release];
    NSLog(@"number of voices:%d", [[AcapelaSpeech availableVoices] count]);
    speaker = [[AcapelaSpeech alloc] initWithVoice:[[AcapelaSpeech availableVoices] objectAtIndex:0] license:acapelaLicense];
  }
  [speaker startSpeakingString:string];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

