#import "RootViewDataSource.h"
#import "RootViewController.h"
#import "Three20/Three20.h"

@implementation RootViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController  

- (void)loadView {
  [super loadView];  
  
  self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds
                                                 style:UITableViewStylePlain] autorelease];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth
  | UIViewAutoresizingFlexibleHeight;
  self.variableHeightRows = YES;
  self.title = @"tweetrad.io";
  [self.view addSubview:self.tableView];
}  

//////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewController  

- (void)createModel {
  self.dataSource = [[[RootViewDataSource alloc] init] autorelease];
  [self loadData];
}

- (void)loadData {
  [[Twitter singleton] getFollowedTimelineAndNotifyObject:self
                                             withSelector:@selector(statusesReceived)];
}

- (void)statusesReceived {
  [self.dataSource tableViewDidLoadModel:_tableView];
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


	// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  int tweetCount = [[[Twitter singleton] tweets] count];
  return tweetCount;
}


- (void)dealloc {
    [super dealloc];
}


@end

