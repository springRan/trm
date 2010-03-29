#import "TRTwitterModel.h"
#import "TRTwitterTweet.h"
#import "RegexKitLite.h"

static NSString* kTwitterSearchFeedFormat = @"http://search.twitter.com/search.atom?q=%@";

///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TRTwitterModel

@synthesize searchQuery = _searchQuery;
@synthesize tweets      = _tweets;
@synthesize username    = _username;
@synthesize password    = _password;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
  self = [super init];
  self.searchQuery = @"dinner";
  return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
  TT_RELEASE_SAFELY(_searchQuery);
  TT_RELEASE_SAFELY(_tweets);
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
  if (!self.isLoading && TTIsStringWithAnyText(_searchQuery)) {
    NSString* url = [NSString stringWithFormat:kTwitterSearchFeedFormat, _searchQuery];
    
    TTURLRequest* request = [TTURLRequest
                             requestWithURL: url
                             delegate: self];
    
    request.cachePolicy = cachePolicy;
    request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
    response.isRssFeed = YES;
    request.response = response;
    TT_RELEASE_SAFELY(response);
    
    [request send];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
  TTURLXMLResponse* response = request.response;
  TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
  
  NSDictionary* feed = response.rootObject;
  TTDASSERT([[feed objectForKey:@"entry"] isKindOfClass:[NSArray class]]);
  
  NSArray* entries = [feed objectForKey:@"entry"];
  
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
  [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
  
  TT_RELEASE_SAFELY(_tweets);
  NSMutableArray* tweets = [[NSMutableArray alloc] initWithCapacity:[entries count]];
  
  for (NSDictionary* entry in entries) {
    TRTwitterTweet* tweet = [[TRTwitterTweet alloc] init];
    
    NSDate* date = [dateFormatter dateFromString:[[entry objectForKey:@"published"]
                                                  objectForXMLNode]];
    tweet.created = date;
    tweet.tweetId = [NSNumber numberWithLongLong:
                     [[[entry objectForKey:@"id"] objectForXMLNode] longLongValue]];
    tweet.text = [[entry objectForKey:@"title"] objectForXMLNode];
    tweet.source = [[entry objectForKey:@"twitter:source"] objectForXMLNode];

    // get the profile image
    NSArray* links = [entry objectForKey:@"link"];
    for (NSDictionary* link in links){
      if ([[link objectForKey:@"rel"] isEqualToString:@"image"]) {
        tweet.profileImageUrl = [link objectForKey:@"href"];
      }
    }
    
    // username components
    NSArray *userNameComponents = [[[[entry objectForKey:@"author"] objectForKey:@"name"] objectForXMLNode] arrayOfCaptureComponentsMatchedByRegex:@"^(.*) \\((.*)\\)"];
    for (NSArray *matchArray in userNameComponents) {
      tweet.userName = [matchArray objectAtIndex:1];
      tweet.userRealName = [matchArray objectAtIndex:2];
    } 
    tweet.userProfileUrl = [[[entry objectForKey:@"author"] objectForKey:@"uri"] objectForXMLNode];
    [tweets addObject:tweet];
    TT_RELEASE_SAFELY(tweet);
  }
  _tweets = tweets;
  
  TT_RELEASE_SAFELY(dateFormatter);
  
  [super requestDidFinishLoad:request];
}


@end

