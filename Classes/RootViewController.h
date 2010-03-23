#import "Twitter.h"
#import "Three20/Three20.h"
#import "TRTweetTableDelegate.h"

@interface RootViewController : TTTableViewController {
}
- (void)statusesReceived;
- (void)loadData;
@end
