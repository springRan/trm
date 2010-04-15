#import "Three20/Three20.h"
#import "TRTweetTableDelegate.h"

@interface TRTweetTableViewController : TTTableViewController {
  UIBarButtonItem *_playButton;
  UIBarButtonItem *_pauseButton;
}
- (void)statusesReceived;
@end
