#import "TRDefaultStyleSheet.h"
#import "Three20/TTStyle.h"
#import "Three20/TTShape.h"
#import "Three20/TTURLCache.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TRDefaultStyleSheet


///////////////////////////////////////////////////////////////////////////////////////////////////
// styles

-(TTStyle *)cell {
  return [TTLinearGradientFillStyle styleWithColor1:TTSTYLEVAR(cellbackground1) 
                                            color2:TTSTYLEVAR(cellbackground2)
                                              next:nil];
}

-(TTStyle *)highlightedCell {
  return [TTLinearGradientFillStyle styleWithColor1:TTSTYLEVAR(cellbackground3) 
                                             color2:TTSTYLEVAR(cellbackground4)
                                               next:nil];
}

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

- (UIColor*)darkBackground {
  return UIColorFromRGB(0x222222);
}

- (UIColor*)linkTextColor {
  return UIColorFromRGB(0x000000);
}

- (UIColor *)cellbackground1{
  return UIColorFromRGB(0xeeeeeee);
}

- (UIColor *)cellbackground2{
  return UIColorFromRGB(0xffffff);
}

- (UIColor *)cellbackground3{
  return UIColorFromRGB(0x007dff);
}

- (UIColor *)cellbackground4{
  return UIColorFromRGB(0x054ac);
}

- (UIColor *)highlightedTextColor {
  return [UIColor whiteColor];
}

- (UIColor *)darkGrayColor {
  return UIColorFromRGB(0x444444);
}

- (UIColor *)darkColor {
  return UIColorFromRGB(0x607734);
}

- (UIColor *)lightColor {
	return [UIColor grayColor];
}

- (UIColor*)navigationBarTintColor {
  return RGBCOLOR(140,63,31);
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