#import "Three20/Three20.h"
#import "TRTweetTableDelegate.h"

@interface TRTweetTableViewController : TTTableViewController {
  UIBarButtonItem *_playButton;
  UIBarButtonItem *_pauseButton;
}
@property (nonatomic,retain) UIBarButtonItem *playButton;
@property (nonatomic,retain) UIBarButtonItem *pauseButton;
- (void)statusesReceived;
@end
