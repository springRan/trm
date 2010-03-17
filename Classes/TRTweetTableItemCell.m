#import "TRTweetTableItemCell.h"
#import "TRTweetTableItem.h"
#import "TRDefaultStylesheet.h"

  ///////////////////////////////////////////////////////////////////////////////////////////////////

static CGFloat kHPadding = 10;
static CGFloat kVPadding = 15;
static CGFloat kImageWidth = 50;
static CGFloat kImageHeight = 50;

  ///////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////
  //////   BNTableCaptionedItemWithThreeImagesBelowCell     ////
  //////////////////////////////////////////////////////////////

@implementation TRTweetTableItemCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(id)item {
	TRTweetTableItemCell* captionedItem = item;
  
	CGFloat maxWidth = tableView.width - kHPadding*2;
  
	CGSize textSize = [captionedItem.text sizeWithFont:TTSTYLEVAR(myHeadingFont)
                                   constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                       lineBreakMode:UILineBreakModeWordWrap];
	CGSize subtextSize = [[captionedItem caption] sizeWithFont:TTSTYLEVAR(mySubtextFont)
                                         constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
  
	return kVPadding*2 + textSize.height + subtextSize.height + kImageHeight + kVPadding;
}

  ///////////////////////////////////////////////////////////////////////////////////////////////////

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		_item = nil;
    
		avatarView = [[TTImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:avatarView];
    
	}
	return self;
}

- (void)dealloc {
	[avatarView release];
	[super dealloc];
}
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  // UIView

- (void)layoutSubviews {
	[super layoutSubviews];
  
	[self.detailTextLabel sizeToFit];
	self.detailTextLabel.top = kVPadding;
  
	self.textLabel.height = self.detailTextLabel.height;
  
	avatarView.frame = CGRectMake(20, self.detailTextLabel.bottom + kVPadding, kImageWidth, kImageHeight);
}

  ///////////////////////////////////////////////////////////////////////////////////////////////////
  // TTTableViewCell

- (id)object {
	return _item;
}

- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
    
		TRTweetTableItem* item = object;
    
		self.textLabel.textColor = TTSTYLEVAR(myHeadingColor);
		self.textLabel.font = TTSTYLEVAR(myHeadingFont);
		self.textLabel.textAlignment = UITextAlignmentRight;
		self.textLabel.contentMode = UIViewContentModeCenter;
		self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		self.textLabel.numberOfLines = 0;
    
		self.detailTextLabel.textColor = TTSTYLEVAR(mySubtextColor);
		self.detailTextLabel.font = TTSTYLEVAR(mySubtextFont);
		self.detailTextLabel.textAlignment = UITextAlignmentLeft;
		self.detailTextLabel.contentMode = UIViewContentModeTop;
		self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    
		avatarView.URL = item.avatar;
		avatarView.style = [item imageStyle];
  }
}

@end
