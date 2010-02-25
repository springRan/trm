#import "TweetCell.h"
@implementation TweetCell

@synthesize textLabel;
@synthesize userNameLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [[UITableViewCell alloc] init]) {
    reuseIdentifier=reuseIdentifier;
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  
  [super setSelected:selected animated:animated];
  
    // Configure the view for the selected state
}


- (void)dealloc {
  [super dealloc];
}


@end