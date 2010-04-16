#import "Three20/TTStyleSheet.h"
#import "Three20/TTDefaultStyleSheet.h"

@interface TRDefaultStyleSheet : TTDefaultStyleSheet
// styles
-(TTStyle *)username;
-(TTStyle *)cell;

// colors
- (UIColor *)cellbackground1;
- (UIColor *)cellbackground2;
- (UIColor *)cellbackground3;
- (UIColor *)cellbackground4;
- (UIColor *)darkColor;
- (UIColor *)lightColor;
- (UIColor *)darkBackground;
// fonts
- (UIFont*)smallItalicFont;
- (UIFont*)smallBoldFont;
@end
