#import <Foundation/Foundation.h>
#import "MGTwitterEngine.h"

@interface Twitter : NSObject <MGTwitterEngineDelegate> {
	NSString *username;
	NSString *password;
	MGTwitterEngine *twitterEngine;
	NSManagedObjectContext *managedObjectContext;
	id *delegate;
}

@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *password;

+ (Twitter *)singleton;

- (id) setUsername:(NSString *) usernameArg andPassword:(NSString *) passwordArg;

- (NSString *) getPublicTimeline;

- (NSString *) getSearchResultsForQuery:(NSString *) query;
@end