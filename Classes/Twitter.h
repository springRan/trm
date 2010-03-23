#import "Three20/Three20.h"
#import "MGTwitterEngine.h"
#import "TRTweet.h"

@interface Twitter : TTModel{
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
@property (nonatomic,retain) id *twitterEngine;



+ (Twitter *)singleton;
- (void) setUserNameAndPassword;
- (BOOL) userNameAndPasswordSet;

- (NSString *) getFollowedTimeline;
- (NSString *) getPublicTimeline;
- (NSString *) getSearchResultsForQuery:(NSString *) query;
@end