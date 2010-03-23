#import "Three20/Three20.h"
#import "TRTweetTableItem.h"
#import "TRTweetTableItemCell.h"
#import "Twitter.h"



@interface RootViewDataSource : TTListDataSource {
}
- (void)statusesReceived;
+ (RootViewDataSource*)rootViewDataSource;

@end
