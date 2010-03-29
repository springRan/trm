#import "Three20/Three20.h"

@interface TRTwitterModel : TTURLRequestModel {
  NSString* _searchQuery;
  NSString* _username;
  NSString* _password;
  NSArray*  _tweets;
}

@property (nonatomic, copy)     NSString* searchQuery;
@property (nonatomic, copy)     NSString* username;
@property (nonatomic, copy)     NSString* password;
@property (nonatomic, readonly) NSArray*  tweets;

@end
