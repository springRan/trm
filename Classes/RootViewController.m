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
  
  self.dataSource = [[[RootViewDataSource alloc] init] autorelease];
  [[Twitter singleton] getFollowedTimelineAndNotifyObject:self 
                                             withSelector:@selector(statusesReceived)];
}  

//////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewController  

- (id)createDataSource {
  return [RootViewDataSource rootViewDataSource];
}  

- (void)statusesReceived {
  id *appDelegate = [[UIApplication sharedApplication] delegate];
  [appDelegate setLoadingOverlayVisibility:NO];
  [self.dataSource tableViewDidLoadModel:self];
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


	// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  static NSString *CellIdentifier = @"Cell";
//  TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//  if (cell == nil) {
//		[[NSBundle mainBundle] loadNibNamed:@"TweetCell" owner:self options:nil];
//    cell = tweetCell;
//    tweetCell = nil;
//  } else {
//    AsyncImageView* oldImage = (AsyncImageView*)
//    [cell.contentView viewWithTag:999];
//    [oldImage removeFromSuperview];
//  }
//
//	// Configure the cell.
//  NSDictionary *tweet = [[[Twitter singleton] tweets] objectAtIndex:(int)indexPath.row];
//  cell.textLabel.text = [tweet objectForKey:@"text"];
//  NSDictionary *user = [tweet objectForKey:@"user"];
//  cell.userNameLabel.text = [user objectForKey:@"name"];
//
//  NSString *path = [user objectForKey:@"profile_image_url"];
//  NSURL *url = [NSURL URLWithString:path];
//
//  CGRect frame;
//	frame.size.width=48; frame.size.height=48;
//	frame.origin.x=10; frame.origin.y=10;
//	AsyncImageView* asyncImage = [[[AsyncImageView alloc]
//                                 initWithFrame:frame] autorelease];
//	asyncImage.tag = 999;
//	[asyncImage loadImageFromURL:url];
//  
//	[cell.contentView addSubview:asyncImage];
//  
//  
//  return cell;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	return 80;
//}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *tweet = [[[Twitter singleton] tweets] objectAtIndex:(int)indexPath.row];
  [[[UIApplication sharedApplication] delegate] speakString:[tweet objectForKey:@"text"]];
}

- (void)dealloc {
    [super dealloc];
}


@end

