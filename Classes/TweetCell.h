#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface TweetCell : UITableViewCell {
  IBOutlet UILabel *textLabel;
  IBOutlet UILabel *userNameLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;
@end
