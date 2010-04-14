#import "TRTweetTableItem.h"
#import "TRTweetTableItemCell.h"

@implementation TRTweetTableItemCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(TRTweetTableItem *)object {
	TTStyledText* text = [object content];
	if (!text.font) {
		text.font = TTSTYLEVAR(font);
	}
	text.width = tableView.width - [tableView tableCellMargin]*2 - 60;
	return text.height + 10 > 60 ? text.height + 10 : 60;
}

- (TRTwitterTweet *) tweet {
  return [self.object tweet];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
		_label = [[TTStyledTextLabel alloc] init];
		_label.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_label];
		
		_avatar = [[TTImageView alloc] init];
		_avatar.frame = CGRectMake(5, 5, 50, 50);
		_avatar.style =  [TTShapeStyle styleWithShape:
                      [TTRoundedRectangleShape shapeWithRadius:8] next:
                      [TTContentStyle styleWithNext:nil]]; 
		_avatar.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:_avatar];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_avatar);
	[super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	_label.frame = CGRectMake(60, 5, _label.width -60, _label.height);
}

- (void)setObject:(id)object {
  if (_item != object) {
    _label.text = [TTStyledText textFromXHTML:((TRTweetTableItem *)object).tweet.text];

    NSString *urlPath = ((TRTweetTableItem *)object).tweet.profileImageUrl;
    _avatar.urlPath = @"";
    _avatar.urlPath = urlPath;

    NSString *userName = ((TRTweetTableItem *)object).tweet.userRealName;
    NSLog(@"username:%@",userName);
    _username.text = userName;
    [self setNeedsLayout];
  }  
}

@end
