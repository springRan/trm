#import "Three20/Three20.h"
#import "TRTwitterTweet.h"

@interface TRTweetTableItem : TTTableTextItem {
  NSString* _imageURL;
  UIImage* _defaultImage;
  TTStyle* _imageStyle;
  TRTwitterTweet* _tweet;
}

@property(nonatomic,copy) NSString* imageURL;
@property(nonatomic,retain) UIImage* defaultImage;
@property(nonatomic,retain) TTStyle* imageStyle;
@property(nonatomic,retain) TRTwitterTweet *tweet;

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL;
+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL URL:(NSString*)URL;
+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage URL:(NSString*)URL;
+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle URL:(NSString*)URL;

@end

