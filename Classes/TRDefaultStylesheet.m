#import "TRDefaultStyleSheet.h"
#import "Three20/TTStyle.h"
#import "Three20/TTShape.h"
#import "Three20/TTURLCache.h"



///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TRDefaultStyleSheet


///////////////////////////////////////////////////////////////////////////////////////////////////
// styles

-(TTStyle *)avatar {
	return [TTShapeStyle styleWithShape:
			[TTRoundedRectangleShape shapeWithRadius:8] next:
			[TTContentStyle styleWithNext:nil]];
}

-(TTStyle *)username {
	return [TTSolidFillStyle styleWithColor:[UIColor clearColor] 
									   next:[TTTextStyle 
											 styleWithFont:TTSTYLEVAR(smallBoldFont)
											 color:TTSTYLEVAR(darkColor) 
											 textAlignment:UITextAlignmentLeft
											 next:nil]];
}

-(TTStyle *)timestamp {
	return [TTSolidFillStyle styleWithColor:[UIColor clearColor] 
									   next:[TTTextStyle 
											 styleWithFont:TTSTYLEVAR(smallItalicFont)
											 color:TTSTYLEVAR(lightColor) 
											 textAlignment:UITextAlignmentRight
											 next:nil]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public colors
- (UIColor *)highlightedTextColor {
  return [UIColor whiteColor];
}

- (UIColor *)darkColor {
	return [UIColor blackColor];
}

- (UIColor *)lightColor {
	return [UIColor grayColor];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// public fonts

- (UIFont*)smallItalicFont {
  return [UIFont italicSystemFontOfSize:13];
}

- (UIFont*)smallBoldFont {
  return [UIFont boldSystemFontOfSize:13];
}

- (UIFont*)tableSmallFont {
  return [UIFont systemFontOfSize:13];
}

- (UIFont *)tableFont {
  return [UIFont systemFontOfSize:13];
}

@end