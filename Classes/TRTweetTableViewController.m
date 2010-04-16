#import "Three20/Three20.h"
#import "TRTweetTableDataSource.h"
#import "TRTweetTableViewController.h"
#import "TRTwitterModel.h"

@implementation TRTweetTableViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
// UI Selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  if ([cell isKindOfClass:[TRTweetTableItemCell class]]) {
//    if ([(TRTweetTableViewController *)_controller lastSpokenIndexPath] == indexPath) {
//      ((TTView *)((TRTweetTableItemCell *)cell).backgroundView).style = TTSTYLE(highlightedCell);
//    } else {
//      ((TTView *)((TRTweetTableItemCell *)cell).backgroundView).style = TTSTYLE(cell);
//    }
//    [[(TRTweetTableItemCell *)cell label] setBackgroundColor:[UIColor clearColor]];
//  }
  TRTweetTableItemCell *cell = (TRTweetTableItemCell *)[_controller.tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[TRTweetTableItemCell class]]) {
    [(TRTweetTableViewController *)_controller speakItem:cell.object];
  }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //	UIColor *backgroundColor            = RGBCOLOR(223,241,241);
		//	cell.backgroundColor                = backgroundColor;
		//	cell.backgroundView.backgroundColor = backgroundColor;
		//	cell.contentView.backgroundColor    = backgroundColor;
    if ([cell isKindOfClass:[TRTweetTableItemCell class]]) {
    //      if ([(TRTweetTableViewController *)_controller lastSpokenIndexPath] == indexPath) {
    //        ((TTView *)((TRTweetTableItemCell *)cell).backgroundView).style = TTSTYLE(highlightedCell);
    //      } else {
    //        ((TTView *)((TRTweetTableItemCell *)cell).backgroundView).style = TTSTYLE(cell);
    //      }
      [[(TRTweetTableItemCell *)cell label] setBackgroundColor:[UIColor clearColor]];
    }
 }
@end


@implementation TRTweetTableViewController
@synthesize playButton = _playButton;
@synthesize pauseButton = _pauseButton;
@synthesize speaker = _speaker;
@synthesize acapelaLicense = _acapelaLicense;
@synthesize speaking = _speaking;


-(id) init {
	if (self = [super init]) {
    [self enableAcapela];
    _speaking = NO;
		self.title = @"User Settings";
		self.tableViewStyle = UITableViewStyleGrouped;
    
    UIImage *image = [UIImage imageNamed:@"gear.png"];
		UIBarButtonItem *settings = [[UIBarButtonItem alloc] 
                                   initWithImage:image 
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(settingsClicked)];
		
		self.navigationItem.leftBarButtonItem = settings;
    

		self.playButton = [[UIBarButtonItem alloc] 
                                 initWithBarButtonSystemItem: UIBarButtonSystemItemPlay
                                 target:self 
                                 action:@selector(playPressed)];

    self.pauseButton = [[UIBarButtonItem alloc] 
                             initWithBarButtonSystemItem: UIBarButtonSystemItemPause
                             target:self 
                             action:@selector(pausePressed)];

		self.navigationItem.rightBarButtonItem = self.playButton;
  }
	return self;
}

- (void) viewWillAppear:(BOOL)animated
{
  [self reload];
  [super viewWillAppear:animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// PLAYER
//- (void)speakRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  if ([self.tableView numberOfRowsInSection:0] - 1 > indexPath.row) {
//    _lastSpokenIndexPath = indexPath;
//    [self.speaker pauseSpeakingAtBoundary:AcapelaSpeechWordBoundary];
//    [self.speaker stopSpeaking];
//    [self setVoice];
//    
//    self.speaking = YES;
//    [self.tableView selectRowAtIndexPath:indexPath
//                                animated:YES
//                          scrollPosition:UITableViewScrollPositionTop];
//
//    TRTweetTableDataSource *item;
//    for(item in ((TRTweetTableDataSource *)self.dataSource).items){
//      ((TRTweetTableItem *)item).speaking = NO;
//    }
//                  
//    item = [((TRTweetTableDataSource *)self.dataSource).items objectAtIndex:indexPath.row];
//    if ([item isKindOfClass:[TRTweetTableItem class]]) {
//      ((TRTweetTableItem *)item).speaking = YES;
//      [self.speaker startSpeakingString:[((TRTweetTableItem *)item).tweet speakableText]];
//    } else {
//    }
//    NSLog(@"speaking");
//  } else {
//    // need more tweets it seems
//  }
//
//}

- (void)speakNextTweet
{
  [self prepareToSpeak];
  NSArray *items = ((TRTweetTableDataSource *)self.dataSource).items;
  TRTweetTableItem *item = nil;
  TRTweetTableItem *currentItem = nil;
  int i = 0;
  for(item in items){
    if (item.speaking) {
      currentItem = item;
      item.speaking = NO;
      break;
    }
    i++;
  }
  if (currentItem) {
    i++;
    currentItem = [items objectAtIndex:i];
  } else {
    currentItem = [items objectAtIndex:0];
  }
  currentItem.speaking = YES;
  [self.speaker startSpeakingString:[currentItem.tweet speakableText]];
}

- (void)speakItem:(TRTweetTableItem *)currentItem
{
  [self prepareToSpeak];
  TRTweetTableItem *item = nil;
  NSArray *items = ((TRTweetTableDataSource *)self.dataSource).items;
  for(item in items){item.speaking = NO;}
  currentItem.speaking = YES;
  [self.speaker startSpeakingString:[currentItem.tweet speakableText]];
}

- (void)setVoice
{
  
}

- (void)prepareToSpeak
{
  [self.speaker pauseSpeakingAtBoundary:AcapelaSpeechWordBoundary];
  [self.speaker stopSpeaking];
  self.speaking = YES;
  [self setVoice];
}

- (void)setSpeaking:(BOOL)speaking{
  if (_speaking != speaking){
    _speaking = speaking;
    if (_speaking) {
      self.navigationItem.rightBarButtonItem = self.pauseButton;
    } else {
      self.navigationItem.rightBarButtonItem = self.playButton;
      [self.speaker pauseSpeakingAtBoundary:AcapelaSpeechWordBoundary];
      [self.speaker stopSpeaking];
    }
  }
}

- (void)speechSynthesizer:(AcapelaSpeech *)sender didFinishSpeaking:(BOOL)finishedSpeaking{
  if (![self.speaker isSpeaking] && _speaking) {
    NSLog(@"speaker just finished speaking");
    [self speakNextTweet];
    NSLog(@"finished");
  }
}; 

- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakWord: (NSRange)characterRange ofString:(NSString *)string{
};

- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakPhoneme: (short)phonemeOpcode{
}; 

- (void)speechSynthesizer:(AcapelaSpeech *)sender didEncounterSyncMessage: (NSString *)errorMessage{
  NSLog(@"error:%@",errorMessage);
};

#pragma mark -
#pragma mark acapela setup
- (void)enableAcapela 
{
  NSLog(@"enabling acapela");
  char babLicense[]="\"5526 0 NSCA #EVALUATION#NSCAPI Acapela-group\"\nV26UONwcfvic6afGbd7I4HNp@%c6$2izATv3eewbWWeizdgNUtTmJra!PWN@\nY2JQ!X5RzKm$jkMBJKEZnHo3NvvRSYtDbaaGtQ##\nXGHCxjY%ZnKXmxxXeViL\n";
	struct Uid { BB_U32 userId;BB_U32 passwd;} uid={0x01c7b439,0x00004427};
  
  
  NSString* aLicenseString = [[NSString alloc] initWithCString:babLicense 
                                                      encoding:NSASCIIStringEncoding]; 
  self.acapelaLicense = [[AcapelaLicense alloc] initLicense:aLicenseString 
                                                       user:uid.userId 
                                                     passwd:uid.passwd];
  [aLicenseString release];
  NSLog(@"number of voices:%d", [[AcapelaSpeech availableVoices] count]);
  self.speaker = [[AcapelaSpeech alloc] initWithVoice:[[AcapelaSpeech availableVoices] objectAtIndex:0] license:self.acapelaLicense];
	[self.speaker setDelegate:self];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController  

- (void)loadView {
  [super loadView];  
  CGRect tableViewBounds = self.view.bounds;
  
  self.tableView = [[[UITableView alloc] initWithFrame:tableViewBounds
                                                 style:UITableViewStylePlain] autorelease];
  self.variableHeightRows = YES;
  self.title = @"tweetrad.io";
  [self.view addSubview:self.tableView];
}  

//////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewController  

- (void)createModel {
  self.dataSource = [[[TRTweetTableDataSource alloc] init] autorelease];
}

- (void)statusesReceived {
  NSLog(@"status received invoked on table view controller");
  [self.dataSource tableViewDidLoadModel:_tableView];
}

- (void)modelDidFinishLoad:(id)model
{
  NSLog(@"model did load %@", model); 
  [super modelDidFinishLoad:model];
}

- (id<UITableViewDelegate>)createDelegate {
  return [[[TRTweetTableViewDelegate alloc] initWithController:self] autorelease];
}

- (void)didReceiveMemoryWarning {
		// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
		// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
		// Release anything that can be recreated in viewDidLoad or on demand.
		// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (void)settingsClicked{
  TTOpenURL(@"tt://settings");
}

- (void)playPressed{
  NSLog(@"play pressed");
  self.speaking = YES;
  [self speakNextTweet];
}

- (void)pausePressed{
  NSLog(@"pause pressed");
  self.speaking = NO;
}
@end

