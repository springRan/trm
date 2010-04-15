#import "Three20/TTStyleSheet.h"
#import "Three20/TTDefaultStyleSheet.h"

@interface TRDefaultStyleSheet : TTDefaultStyleSheet
// styles
-(TTStyle *)username;

// colors
- (UIColor *)darkColor;
- (UIColor *)lightColor;

// fonts
- (UIFont*)smallItalicFont;
- (UIFont*)smallBoldFont;
@end
