#import "Three20/Three20.h"
#import "Twitter.h"
#import "TRTweetTableItem.h"
#import "TRTweetTableItemCell.h"



@interface TRTweetTableDataSource : TTListDataSource {
}
- (void)statusesReceived;
+ (TRTweetTableDataSource*)TRTweetTableDataSource;

@end
