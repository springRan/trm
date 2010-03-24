#import "Three20/Three20.h"

@interface TRTweetTableItem : TTTableTextItem {
  NSString* _imageURL;
  UIImage* _defaultImage;
  TTStyle* _imageStyle;
}

@property(nonatomic,copy) NSString* imageURL;
@property(nonatomic,retain) UIImage* defaultImage;
@property(nonatomic,retain) TTStyle* imageStyle;

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL;
+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL URL:(NSString*)URL;
+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage URL:(NSString*)URL;
+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle URL:(NSString*)URL;

@end

