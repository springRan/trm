#import "TRTweetTableItemCell.h"

static const CGFloat kHPadding = 10;
static const CGFloat kVPadding = 10;
static const CGFloat kMargin = 10;
static const CGFloat kSmallMargin = 6;
static const CGFloat kSpacing = 8;
static const CGFloat kControlPadding = 8;
static const CGFloat kDefaultTextViewLines = 5;
static const CGFloat kMoreButtonMargin = 40;

static const CGFloat kKeySpacing = 12;
static const CGFloat kKeyWidth = 75;
static const CGFloat kMaxLabelHeight = 2000;
static const CGFloat kDisclosureIndicatorWidth = 23;

static const NSInteger kMessageTextLineCount = 2;

static const CGFloat kDefaultImageSize = 50;
static const CGFloat kDefaultMessageImageWidth = 34;
static const CGFloat kDefaultMessageImageHeight = 34;


@implementation TRTweetTableItemCell

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewCell class public

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
  TTTableImageItem* imageItem = object;
  
  UIImage* image = imageItem.imageURL
  ? [[TTURLCache sharedCache] imageForURL:imageItem.imageURL] : nil;
  if (!image) {
    image = imageItem.defaultImage;
  }
  
  CGFloat imageHeight, imageWidth;
  TTImageStyle* style = [imageItem.imageStyle firstStyleOfClass:[TTImageStyle class]];
  if (style && !CGSizeEqualToSize(style.size, CGSizeZero)) {
    imageWidth = style.size.width + kKeySpacing;
    imageHeight = style.size.height;
  } else {
    imageWidth = image
    ? image.size.width + kKeySpacing
    : (imageItem.imageURL ? kDefaultImageSize + kKeySpacing : 0);
    imageHeight = image
    ? image.size.height
    : (imageItem.imageURL ? kDefaultImageSize : 0);
  }
  
  CGFloat maxWidth = tableView.width - (imageWidth + kHPadding*2 + kMargin*2);
  
  CGSize textSize = [imageItem.text sizeWithFont:TTSTYLEVAR(tableSmallFont)
                               constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                   lineBreakMode:UILineBreakModeTailTruncation];
  
  CGFloat contentHeight = textSize.height > imageHeight ? textSize.height : imageHeight;
  return contentHeight + kVPadding*2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
    _imageView2 = [[TTImageView alloc] init];
    [self.contentView addSubview:_imageView2];
	}
	return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_imageView2);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)layoutSubviews {
  [super layoutSubviews];
  
  TTTableImageItem* item = self.object;
  UIImage* image = item.imageURL ? [[TTURLCache sharedCache] imageForURL:item.imageURL] : nil;
  if (!image) {
    image = item.defaultImage;
  }
  
  if (_imageView2.urlPath) {
    CGFloat iconWidth = image
    ? image.size.width
    : (item.imageURL ? kDefaultImageSize : 0);
    CGFloat iconHeight = image
    ? image.size.height
    : (item.imageURL ? kDefaultImageSize : 0);
      
    TTImageStyle* style = [item.imageStyle firstStyleOfClass:[TTImageStyle class]];
    if (style) {
      _imageView2.contentMode = style.contentMode;
      _imageView2.clipsToBounds = YES;
      _imageView2.backgroundColor = [UIColor clearColor];
      if (style.size.width) {
        iconWidth = style.size.width;
      }
      if (style.size.height) {
        iconHeight = style.size.height;
      }
    }
      
    _imageView2.frame = CGRectMake(kHPadding, kVPadding,
                                   iconWidth, iconHeight);
    
    CGFloat innerWidth = self.contentView.width - (kHPadding*2 + iconWidth + kKeySpacing);
    CGFloat innerHeight = self.contentView.height - kVPadding*2;

    CGSize textSize = [item.text sizeWithFont:TTSTYLEVAR(tableSmallFont)
                                 constrainedToSize:CGSizeMake(innerWidth, CGFLOAT_MAX)
                                     lineBreakMode:UILineBreakModeTailTruncation];
    self.textLabel.frame = CGRectMake(kHPadding + iconWidth + kKeySpacing, kVPadding,
                                      innerWidth, textSize.height);
  } else {
    self.textLabel.frame = CGRectInset(self.contentView.bounds, kHPadding, kVPadding);
    _imageView2.frame = CGRectZero;
  }
}

- (void)didMoveToSuperview {
  [super didMoveToSuperview];
  if (self.superview) {
    _imageView2.backgroundColor = self.backgroundColor;
  }
}

- (void)setObject:(id)object {
  if (_item != object) {
    [super setObject:object];
    TTTableImageItem* item = object;
    _imageView2.style = item.imageStyle;
    _imageView2.defaultImage = item.defaultImage;
    _imageView2.urlPath = item.imageURL;

    self.textLabel.font = TTSTYLEVAR(tableFont);
    self.textLabel.textAlignment = UITextAlignmentLeft;
  }  
}
@end
@end
