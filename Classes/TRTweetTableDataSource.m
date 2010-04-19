#import "TRTweetTableDataSource.h"

@implementation TRTweetTableDataSource

- (id)init {
  if (self = [super init]) {
    _data = [[TRTwitterModel alloc] init];
  }
  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_data);
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

  for (TRTwitterTweet* tweet in [_data tweets]) {
    TRTweetTableItem* item = [[TRTweetTableItem alloc] initWithTweet:tweet];
    [items addObject:item];
  }
  self.items = items;
  TT_RELEASE_SAFELY(items);
}

- (void)search:(NSString *)text
{
  [(TRTwitterModel *)self.model searchWithQuery:text];
}

- (id)model {
  return _data;
}

- (void)tableView:tableView cell:cell willAppearAtIndexPath:indexPath {
}

- (NSString*)titleForLoading:(BOOL)reloading {
  return NSLocalizedString(@"loading...", @"Twitter feed loading text");
}

@end