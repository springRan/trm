#import "Three20/Three20.h"
#import "TRTweetTableItem.h"
#import "TRTweetTableItemCell.h"
#import "TRTwitterModel.h"
#import "TRTwitterTweet.h"



@interface TRTweetTableDataSource : TTListDataSource {
  TRTwitterModel* _data;
}

@end
