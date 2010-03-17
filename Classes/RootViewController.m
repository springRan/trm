#import "RootViewController.h"


@implementation RootViewController

/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }
 */

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)statusesReceived {
  id *appDelegate = [[UIApplication sharedApplication] delegate];
  [appDelegate setLoadingOverlayVisibility:NO];
  [self.tableView reloadData];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"TweetCell" owner:self options:nil];
    cell = tweetCell;
    tweetCell = nil;
  } else {
    AsyncImageView* oldImage = (AsyncImageView*)
    [cell.contentView viewWithTag:999];
    [oldImage removeFromSuperview];
  }

	// Configure the cell.
  NSDictionary *tweet = [[[Twitter singleton] tweets] objectAtIndex:(int)indexPath.row];
  cell.textLabel.text = [tweet objectForKey:@"text"];
  NSDictionary *user = [tweet objectForKey:@"user"];
  cell.userNameLabel.text = [user objectForKey:@"name"];

  NSString *path = [user objectForKey:@"profile_image_url"];
  NSURL *url = [NSURL URLWithString:path];

  CGRect frame;
	frame.size.width=48; frame.size.height=48;
	frame.origin.x=10; frame.origin.y=10;
	AsyncImageView* asyncImage = [[[AsyncImageView alloc]
                                 initWithFrame:frame] autorelease];
	asyncImage.tag = 999;
	[asyncImage loadImageFromURL:url];
  
	[cell.contentView addSubview:asyncImage];
  
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *tweet = [[[Twitter singleton] tweets] objectAtIndex:(int)indexPath.row];
  [[[UIApplication sharedApplication] delegate] speakString:[tweet objectForKey:@"text"]];
}
 


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
    [super dealloc];
}


@end

