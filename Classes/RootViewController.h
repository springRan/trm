#import "TweetCell.h"
#import "Twitter.h"
#import "Three20/Three20.h"

@interface RootViewController : TTTableViewController {
  IBOutlet TweetCell *tweetCell;
}
@property (nonatomic, retain) IBOutlet TweetCell *tweetCell;
- (void)statusesReceived;
@end
