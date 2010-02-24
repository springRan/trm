#import <Foundation/Foundation.h>
#import "MGTwitterEngine.h"

@interface Twitter : NSObject {
	NSString *username;
	NSString *password;
	MGTwitterEngine *twitterEngine;
	NSManagedObjectContext *managedObjectContext;
	id *delegate;
}

@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) id *delegate;

+ (Twitter *)singleton;
- (void) setUsername:(NSString *) usernameArg andPassword:(NSString *) passwordArg;

- (NSString *) getPublicTimeline;
- (NSString *) getSearchResultsForQuery:(NSString *) query;
@end