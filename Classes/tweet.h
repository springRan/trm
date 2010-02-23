#import <foundation/foundation.h>
#import "SQLitePersistentObject.h"

@interface Tweet : SQLitePersistentObject {
	NSString *tweetId;
    NSString *fromUser;
	NSString *toUser;
	NSString *profileImageUrl;
	NSString *text;
}

@property (nonatomic, retain) NSString *tweetId;
@property (nonatomic, retain) NSString *fromUser;
@property (nonatomic, retain) NSString *toUser;
@property (nonatomic, retain) NSString *profileImageUrl;
@property (nonatomic, retain) NSString *text;

@end