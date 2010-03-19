#import "Three20/Three20.h"

@interface RootViewDataSource : TTListDataSource {
}
- (void)statusesReceived;
+ (RootViewDataSource*)rootViewDataSource;

@end
