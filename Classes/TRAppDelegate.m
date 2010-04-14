#import "TRAppDelegate.h"
#import "TRTwitterTweet.h"
#import "TRTweetTableItemCell.h"

@implementation TRAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize loadingOverlay;
@synthesize settingsController;
@synthesize trTweetTableViewController;
@synthesize playButton;
@synthesize pauseButton;
@synthesize acapelaLicense;
@synthesize speaker;

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
  [trTweetTableViewController tableView].separatorColor = [UIColor clearColor];
  navigationController = [[UINavigationController alloc] initWithRootViewController:trTweetTableViewController];
  [window addSubview:[navigationController view]];
  
  
  [self setupNavigationBarButtons];
  
  // load up the app or ask for credentials
  [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Save data if appropriate
  [self ensureSpeaker];
  [speaker stopSpeaking];
}

#pragma mark -
#pragma mark Player

- (void)togglePlay{
  if (!indexPathOfCurrentTweet){
    indexPathOfCurrentTweet = [NSIndexPath indexPathForRow:0 inSection:0];
  }
  if (playing) {
    playing = NO;
    [speaker pauseSpeakingAtBoundary:AcapelaSpeechWordBoundary];
    trTweetTableViewController.navigationItem.rightBarButtonItem = playButton;
  } else {
    playing = YES;
    trTweetTableViewController.navigationItem.rightBarButtonItem = pauseButton;
    [self playTweetAtIndexPath:indexPathOfCurrentTweet andScrollTo:YES];
  }
}

// play the tweet at the requested index in the model
- (void)playTweetAtIndexPath:(NSIndexPath *)indexPath andScrollTo:(BOOL)scrollTo{
  if (!playing) {
    playing = YES;
    trTweetTableViewController.navigationItem.rightBarButtonItem = pauseButton;
  }

  TRTweetTableItemCell *tableItemCell = (TRTweetTableItemCell *)[[trTweetTableViewController tableView] cellForRowAtIndexPath:indexPath];
  if (tableItemCell) {
    indexPathOfCurrentTweet = indexPath;
    TRTwitterTweet* tweet = [tableItemCell tweet];
    [self ensureSpeaker];
    if ([speaker isSpeaking]){
      [speaker pauseSpeakingAtBoundary:AcapelaSpeechWordBoundary];
      indexPathOfCurrentTweet = indexPath;
    }
    NSLog(@"about to speak row:%d",indexPathOfCurrentTweet.row);
    [speaker startSpeakingString:[tweet speakableText]];
    [[trTweetTableViewController tableView] selectRowAtIndexPath:indexPath
                                                        animated:YES
                                                  scrollPosition:UITableViewScrollPositionTop];
    int nextRow = indexPathOfCurrentTweet.row + 1;
    indexPathOfCurrentTweet = [NSIndexPath indexPathForRow:nextRow inSection:0];
  } else {
    //should load more
  }
}

// process the string
- (NSString *)processString:(NSString *)string{
  return [string stringByAppendingString:@"\\Pau=1000\\"];
}

- (void) ensureSpeaker {
  if (!acapelaLicense){
    NSString* aLicenseString = [[NSString alloc] initWithCString:babLicense 
                                                        encoding:NSASCIIStringEncoding]; 
    acapelaLicense = [[AcapelaLicense alloc] initLicense:aLicenseString 
                                                    user:uid.userId 
                                                  passwd:uid.passwd];
    
    [acapelaLicense retain];
    [aLicenseString release];
    NSLog(@"number of voices:%d", [[AcapelaSpeech availableVoices] count]);
    speaker = [[AcapelaSpeech alloc] initWithVoice:[[AcapelaSpeech availableVoices] objectAtIndex:1] license:acapelaLicense];
    [speaker setDelegate:self];
  }
}

- (void)speechSynthesizer:(AcapelaSpeech *)sender didFinishSpeaking: (BOOL)finishedSpeaking{
  if (playing && ![speaker isSpeaking]) {
    [self playTweetAtIndexPath:indexPathOfCurrentTweet andScrollTo:YES];
  }
}; 
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakWord: (NSRange)characterRange ofString:(NSString *)string{
  
};
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakPhoneme: (short)phonemeOpcode{
  
}; 
- (void)speechSynthesizer:(AcapelaSpeech *)sender didEncounterSyncMessage: (NSString *)errorMessage{
  
};
                                                                      
#pragma mark -
#pragma mark UI

// setup navigation controls                                                                      
- (void)setupNavigationBarButtons
{
  UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] 
                                     initWithTitle:@"settings" 
                                     style:UIBarButtonItemStyleBordered 
                                     target:self 
                                     action:@selector(presentSettings)];
  
  trTweetTableViewController.navigationItem.leftBarButtonItem = settingsButton;
  [settingsButton release];
  
  
  self.playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay 
                                                                  target:self 
                                                                  action:@selector(togglePlay)];
  trTweetTableViewController.navigationItem.rightBarButtonItem = playButton;
  
  self.playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay 
                                                                  target:self 
                                                                  action:@selector(togglePlay)];
  self.pauseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause
                                                                  target:self 
                                                                  action:@selector(togglePlay)];
}
                                                                      
                                                                    

#pragma mark -
#pragma mark Settings

- (void)presentSettings{
  if (!settingsController){
    settingsController = [[InAppSettingsViewController alloc] init];
  }
  [self ensureSpeaker];
  if ([speaker isSpeaking]) {
    [self togglePlay];
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
//  [trTweetTableViewController loadData];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

