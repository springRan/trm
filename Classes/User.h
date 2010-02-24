#import <foundation/foundation.h>
#import "SQLitePersistentObject.h"

@interface User : SQLitePersistentObject {
	NSString *login;
    NSString *password;
}
@property (nonatomic, retain) IBOutlet NSString *login;
@property (nonatomic, retain) IBOutlet NSString *password;

@end
