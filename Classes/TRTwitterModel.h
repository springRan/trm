#import "Three20/Three20.h"

@interface TRTwitterModel : TTURLRequestModel {
  NSString* _searchQuery;
  NSString* _username;
  NSString* _password;
  NSArray*  _tweets;
  NSString* _queryMode;
}

@property (nonatomic, retain)   NSString* searchQuery;
@property (nonatomic, retain)   NSString* queryMode;
@property (nonatomic, retain, readonly) NSArray*  tweets;
- (void)searchWithQuery:(NSString *)query;
@end
