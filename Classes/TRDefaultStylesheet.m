#import "TRDefaultStyleSheet.h"
#import "Three20/TTStyle.h"
#import "Three20/TTShape.h"
#import "Three20/TTURLCache.h"



  ///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TRDefaultStyleSheet


  ///////////////////////////////////////////////////////////////////////////////////////////////////
  // styles

  ///////////////////////////////////////////////////////////////////////////////////////////////////
  // public colors

- (UIColor*)myHeadingColor {
	return [UIColor blackColor];
}

- (UIColor*)mySubtextColor {
	return [UIColor grayColor];
}


  ///////////////////////////////////////////////////////////////////////////////////////////////////
  // public fonts

- (UIFont*)myHeadingFont {
	return [UIFont boldSystemFontOfSize:16];
}

- (UIFont*)mySubtextFont {
	return [UIFont systemFontOfSize:13];
}

@end