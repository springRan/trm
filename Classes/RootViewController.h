#import "TweetCell.h"
#import "Twitter.h"
@interface RootViewController : UITableViewController {
  IBOutlet TweetCell *tweetCell;
}
@property (nonatomic, retain) IBOutlet TweetCell *tweetCell;
- (void)statusesReceived;
@end
