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
    TRTweetTableItem* item = [TRTweetTableItem itemWithTweet:tweet];
    [items addObject:item];
  }
  self.items = items;
  TT_RELEASE_SAFELY(items);
}

- (id)model {
  return _data;
}

- (NSString*)titleForLoading:(BOOL)reloading {
  return NSLocalizedString(@"loading...", @"Twitter feed loading text");
}

@end