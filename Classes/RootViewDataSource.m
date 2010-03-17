#import "RootViewDataSource.h"
#import "Twitter.h"

@implementation RootViewDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
// public


+ (RootViewDataSource*)rootViewDataSource {
	RootViewDataSource* dataSource =  [[[RootViewDataSource alloc] initWithItems:
                                      [NSMutableArray arrayWithObjects: nil]] autorelease];
	return dataSource;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc {
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource


- (void)tableViewDidLoadModel:(UITableView*)tableView {
  NSMutableArray* items = [[NSMutableArray alloc] init];
  
  for (NSDictionary* tweet in [[Twitter singleton] tweets]) {
    TTStyledText* styledText = [TTStyledText textFromXHTML:
                                [NSString stringWithFormat:@"%@\n<b>%@</b>",
                                 [[tweet objectForKey:@"text"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"],
                                 [[tweet objectForKey:@"created_at"] formatRelativeTime]]
                                                lineBreaks:YES URLs:YES];
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

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell
forRowAtIndexPath:(NSIndexPath*)indexPath {
	cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
