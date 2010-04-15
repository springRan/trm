#import "Three20/Three20.h"
#import "TRTweetTableDataSource.h"
#import "TRTweetTableViewController.h"
#import "TRTwitterModel.h"

@implementation TRTweetTableViewController

-(id) init {
	if (self = [super init]) {
		self.title = @"User Settings";
		self.tableViewStyle = UITableViewStyleGrouped;
    
    UIImage *image = [UIImage imageNamed:@"gear.png"];
		UIBarButtonItem *settings = [[UIBarButtonItem alloc] 
                                   initWithImage:image 
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(settingsClicked)];
		
		self.navigationItem.leftBarButtonItem = settings;
    

		_playButton = [[UIBarButtonItem alloc] 
                                 initWithBarButtonSystemItem: UIBarButtonSystemItemPlay
                                 target:self 
                                 action:@selector(playPressed)];

    _pauseButton = [[UIBarButtonItem alloc] 
                             initWithBarButtonSystemItem: UIBarButtonSystemItemPlay
                             target:self 
                             action:@selector(pausePressed)];

		self.navigationItem.rightBarButtonItem = _playButton;
  }
	return self;
}

- (void) viewWillAppear:(BOOL)animated
{
  [self reload];
  [super viewWillAppear:animated];
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
  return [[[TRTweetTableDelegate alloc] initWithController:self] autorelease];
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
  self.navigationItem.rightBarButtonItem = _pauseButton;
}

- (void)pausePressed{
  self.navigationItem.rightBarButtonItem = _playButton;
}
@end

