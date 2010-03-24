#import "TRTweetTableItem.h"
///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TRTweetTableItem

@synthesize imageURL = _imageURL, defaultImage = _defaultImage, imageStyle = _imageStyle;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL {
  TTTableImageItem* item = [[[self alloc] init] autorelease];
  item.text = text;
  item.imageURL = imageURL;
  return item;
}

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL URL:(NSString*)URL {
  TTTableImageItem* item = [[[self alloc] init] autorelease];
  item.text = text;
  item.imageURL = imageURL;
  item.URL = URL;
  return item;
}

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL defaultImage:(UIImage*)defaultImage
               URL:(NSString*)URL {
  TTTableImageItem* item = [[[self alloc] init] autorelease];
  item.text = text;
  item.imageURL = imageURL;
  item.defaultImage = defaultImage;
  item.URL = URL;
  return item;
}

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL defaultImage:(UIImage*)defaultImage
        imageStyle:(TTStyle*)imageStyle URL:(NSString*)URL {
  TTTableImageItem* item = [[[self alloc] init] autorelease];
  item.text = text;
  item.imageURL = imageURL;
  item.defaultImage = defaultImage;
  item.imageStyle = imageStyle;
  item.URL = URL;
  return item;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  if (self = [super init]) {
    _defaultImage = nil;
    _imageURL = nil;
    _imageStyle = nil;
  }
  return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_imageURL);
  TT_RELEASE_SAFELY(_defaultImage);
  TT_RELEASE_SAFELY(_imageStyle);
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
  if (self = [super initWithCoder:decoder]) {
    self.imageURL = [decoder decodeObjectForKey:@"imageURL"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [super encodeWithCoder:encoder];
  if (self.imageURL) {
    [encoder encodeObject:self.imageURL forKey:@"imageURL"];
  }
}
@end