#import "Three20/Three20.h"
#import "AcapelaSpeech.h"
#import "TRTweetTableItem.h"

@interface TRTweetTableViewDelegate : TTTableViewDragRefreshDelegate
{
}
@end


@interface TRTweetTableViewController : TTTableViewController <UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate> {
  BOOL _speaking;
  BOOL _acapelaEnabled;
  NSString *_mode;
  AcapelaLicense *_acapelaLicense;
  AcapelaSpeech *_speaker;
  UIBarButtonItem *_playButton;
  UIBarButtonItem *_pauseButton;
  UISearchBar *_searchBar;
  
}
@property (nonatomic,retain) UIBarButtonItem *playButton;
@property (nonatomic,retain) UIBarButtonItem *pauseButton;
@property (nonatomic, retain) AcapelaLicense *acapelaLicense;
@property (nonatomic, retain) AcapelaSpeech *speaker;
@property (nonatomic) BOOL speaking;

- (id)initWithMode:(NSString *)mode;
- (void)enableAcapela;
- (void)speakNextTweet;
- (void)speakItem:(TRTweetTableItem *)currentItem;
- (void)_speakItem:(TRTweetTableItem *)item;
- (void)prepareToSpeak;
- (void)setVoice;
- (void)speechSynthesizer:(AcapelaSpeech *)sender didFinishSpeaking: (BOOL)finishedSpeaking;
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakWord: (NSRange)characterRange ofString:(NSString *)string;
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakPhoneme: (short)phonemeOpcode;
- (void)speechSynthesizer:(AcapelaSpeech *)sender didEncounterSyncMessage: (NSString *)errorMessage;

@end
