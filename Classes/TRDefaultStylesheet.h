#import "Three20/TTStyleSheet.h"
#import "Three20/TTDefaultStyleSheet.h"

@interface TRDefaultStyleSheet : TTDefaultStyleSheet
// styles
-(TTStyle *)silverGradient;
-(TTStyle *)username;
-(TTStyle *)cell;
-(TTStyle *)metalGradient;

// colors
- (UIColor *)cellbackground1;
- (UIColor *)cellbackground2;
- (UIColor *)cellbackground3;
- (UIColor *)cellbackground4;
- (UIColor *)darkColor;
- (UIColor *)darkColorShadowColor;
- (UIColor *)lightColor;
- (UIColor *)darkBackground;
- (UIColor*)navigationBarTintColor;
- (UIColor*)barColor;
// fonts
- (UIFont*)smallItalicFont;
- (UIFont*)smallBoldFont;
- (UIFont*)mediumBoldFont;

@end
