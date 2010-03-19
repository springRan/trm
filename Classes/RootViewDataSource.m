#import "RootViewDataSource.h"
#import "Twitter.h"

@implementation RootViewDataSource

- (void)dealloc {
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource


- (void)tableViewDidLoadModel:(UITableView *) tableView {
  NSLog(@"statuses received invoked");
  NSMutableArray* items = [[NSMutableArray alloc] init];
  
  for (NSDictionary* tweet in [[Twitter singleton] tweets]) {
    NSLog(@"tweet:%@", [tweet objectForKey:@"text"]);
    TTStyledText* styledText = [TTStyledText textFromXHTML:
                                [NSString stringWithFormat:@"%@\n",
                                 [[tweet objectForKey:@"text"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]]];
    TTDASSERT(nil != styledText);
    [items addObject:[TTTableStyledTextItem itemWithText:styledText]];
  }
  
  self.items = items;
  TT_RELEASE_SAFELY(items);
}

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
	
	if ([object isKindOfClass:nil]) { 
		return nil;
	} else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}

- (id<TTModel>)model {
  return [Twitter singleton];
}

- (NSString*)titleForEmpty {
  return NSLocalizedString(@"No tweets found.", @"Twitter feed no results");
}

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell
forRowAtIndexPath:(NSIndexPath*)indexPath {
	cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
