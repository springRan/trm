#import "Three20/Three20.h"
#import "trmAppDelegate.h"

@implementation trmAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize loadingOverlay;
@synthesize settingsController;
@synthesize rootViewController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  // setup three20 global stylesheet
  [TTStyleSheet setGlobalStyleSheet:[[[TRDefaultStyleSheet alloc]   
                                      init] autorelease]];
  // setup in app settings
  [InAppSettings registerDefaults];
  [window addSubview:[navigationController view]];
  
  UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] 
                                 initWithTitle:@"settings" 
                                 style:UIBarButtonItemStyleBordered 
                                 target:self 
                                 action:@selector(presentSettings)];
  rootViewController.navigationItem.leftBarButtonItem = settingsButton;
  [settingsButton release];

  // load up the app or ask for credentials
  if (![[Twitter singleton] userNameAndPasswordSet]) {
    [self presentSettings];
  }
  [window makeKeyAndVisible];
}

  // show the settings view
- (IBAction)presentSettings{
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
  [rootViewController loadData];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Save data if appropriate
}

  // display a loading overlay
- (void)setLoadingOverlayVisibility:(BOOL)visible {
//  if (visible) {
//    [window addSubview:loadingOverlay];
//    loadingOverlay.hidden=NO;
//  } else {
//    [self.loadingOverlay removeFromSuperview];
//  }
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

