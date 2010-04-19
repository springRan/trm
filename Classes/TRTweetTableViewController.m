#import "Three20/Three20.h"
#import "TRDefaultStylesheet.h"
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

-(id)initWithMode:(NSString *)mode
{
  self = [self init];
  _mode = mode;
  if ([mode isEqualToString:@"account"]) {
    
    UIImage *userImage = [UIImage imageNamed:@"user.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"my account" image:userImage tag:0] autorelease];
    
    // table tweaks
    self.tableView.frame = CGRectMake(0,0,self.view.width,369);

  } else if ([mode isEqualToString:@"search"]) {
    
    UIImage *searchImage = [UIImage imageNamed:@"magnifying-glass.png"];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"search twitter" image:searchImage tag:0] autorelease];

    // search bar
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(0,0, self.view.width, 44);
    _searchBar.tintColor = TTSTYLEVAR(barColor);
    _searchBar.placeholder = @"search twitter";
    [self.view addSubview:_searchBar];
    
    // table tweaks
    self.tableView.frame = CGRectMake(0,44,320,325);
    
  }
  return self;
}

-(id) init {
	if (self = [super init]) {
    self.title = @"tweetradio";
    [self enableAcapela];
    _speaking = NO;
		self.tableViewStyle = UITableViewStyleGrouped;
      
    // settings button
    UIImage *image = [UIImage imageNamed:@"gear.png"];
		UIBarButtonItem *settings = [[UIBarButtonItem alloc] 
                                   initWithImage:image 
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(settingsClicked)];
    self.navigationItem.leftBarButtonItem = settings;
    
//    UISegmentedControl *_searchSettingsButtons = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:image, nil]];
//    [self.view addSubview:_searchSettingsButtons];
//    self.navigationItem.titleView = _searchSettingsButtons;
    
    // play pause controls
		self.playButton = [[UIBarButtonItem alloc] 
                                 initWithBarButtonSystemItem: UIBarButtonSystemItemPlay
                                 target:self 
                                 action:@selector(playPressed)];

    self.pauseButton = [[UIBarButtonItem alloc] 
                             initWithBarButtonSystemItem: UIBarButtonSystemItemPause
                             target:self 
                             action:@selector(pausePressed)];

		self.navigationItem.rightBarButtonItem = self.playButton;
    
//    _toolbar = [[TTButtonBar alloc] initWithFrame:CGRectMake(0,374,320,44)];
//    _toolbar.style = TTSTYLE(bar);
//    [self.view addSubview:_toolbar];
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,374,320,44)];
//    [self.view addSubview:toolbar];
//    toolbar.tintColor = TTSTYLEVAR(barColor);
//    self.tableView.frame = CGRectMake(0,0,320,374);
  }
	return self;
}

- (void) viewWillAppear:(BOOL)animated
{
  [self reload];
//  [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//                              animated:YES
//                        scrollPosition:UITableViewScrollPositionTop];
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
    if ([items count] > i) {
      currentItem = [items objectAtIndex:i];
      [self _speakItem:currentItem];
    } else {
      self.speaking = NO;
      // hit the end get more tweets!
    }

  } else {
    currentItem = [items objectAtIndex:0];
    [self _speakItem:currentItem];
  }

}

- (void)speakItem:(TRTweetTableItem *)currentItem
{
  TRTweetTableItem *item = nil;
  NSArray *items = ((TRTweetTableDataSource *)self.dataSource).items;
  for(item in items){item.speaking = NO;}
  [self _speakItem:currentItem];
}

-(void)_speakItem:(TRTweetTableItem *)item
{
  [self prepareToSpeak];
  NSArray *items = ((TRTweetTableDataSource *)self.dataSource).items;
  item.speaking = YES;
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[items indexOfObject:item] inSection:0];
  [self.tableView selectRowAtIndexPath:indexPath
                              animated:YES
                        scrollPosition:UITableViewScrollPositionTop];
  [self.speaker startSpeakingString:[item.tweet speakableText]];
  
}

- (void)setVoice
{
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  int voiceId = [prefs integerForKey:@"voice_id"];
  NSString *voiceIdentifier = [[AcapelaSpeech availableVoices] objectAtIndex:voiceId];
  [self.speaker setVoice:voiceIdentifier];
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

#pragma mark -
#pragma mark search
///////////////////////////////////////////////////////////////////////////////////////////////////
// SEARCH  

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
  [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  [searchBar setShowsCancelButton:NO animated:YES];
  [searchBar resignFirstResponder];
  [self.dataSource search:searchBar.text];
  self.speaking = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
  searchBar.text = @"";
  [searchBar setShowsCancelButton:NO animated:YES];
  [searchBar resignFirstResponder];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController  

- (void)loadView {
  [super loadView];  
  CGRect tableViewBounds = self.view.bounds;
  
  self.tableView = [[[UITableView alloc] initWithFrame:tableViewBounds
                                                 style:UITableViewStylePlain] autorelease];
  self.variableHeightRows = YES;
  [self.view addSubview:self.tableView];
}  

//////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewController  

- (void)createModel {
  self.dataSource = [[[TRTweetTableDataSource alloc] init] autorelease];
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
  TT_RELEASE_SAFELY(_mode);
    [super dealloc];
}

- (void)settingsClicked{
  self.speaking = NO;
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

- (void)viewWillDisappear:(BOOL)animated {
  self.speaking = NO;
  [super viewWillDisappear:animated];
}
@end

