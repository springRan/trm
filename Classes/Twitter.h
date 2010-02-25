#import <Foundation/Foundation.h>
#import "MGTwitterEngine.h"
#import "tweet.h"

@interface Twitter : NSObject {
	NSString *username;
	NSString *password;
	MGTwitterEngine *twitterEngine;
  NSMutableArray *tweets;
	id *delegate;
  NSMutableDictionary *connections;
}

@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSMutableArray *tweets;
@property (nonatomic,retain) id *delegate;



+ (Twitter *)singleton;
- (void) setUsername:(NSString *) usernameArg andPassword:(NSString *) passwordArg;

- (NSString *) getFollowedTimeline;
- (NSString *) getPublicTimeline;
- (NSString *) getSearchResultsForQuery:(NSString *) query;
@end