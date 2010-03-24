#import "TRTweetTableDataSource.h"

@implementation TRTweetTableDataSource

- (void)dealloc {
	[super dealloc];
}


- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object {
  return [TRTweetTableItemCell class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (void)tableViewDidLoadModel:(UITableView *) tableView {
  NSLog(@"statuses received invoked");
  NSMutableArray* items = [[NSMutableArray alloc] init];

  for (NSDictionary* tweet in [[Twitter singleton] tweets]) {
    TRTweetTableItem* item = [TRTweetTableItem itemWithText:[tweet objectForKey:@"text"] 
                                                   imageURL:[[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"]];
    [items addObject:item];
  }
  self.items = items;
  TT_RELEASE_SAFELY(items);
}

- (id<TTModel>)model {
  return [Twitter singleton];
}

- (NSString*)titleForLoading:(BOOL)reloading {
  if (reloading) {
    return NSLocalizedString(@"Updating Twitter feed...", @"Twitter feed updating text");
  } else {
    return NSLocalizedString(@"Loading Twitter feed...", @"Twitter feed loading text");
  }
}

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell
forRowAtIndexPath:(NSIndexPath*)indexPath {
	cell.accessoryType = UITableViewCellAccessoryNone;
}

@end