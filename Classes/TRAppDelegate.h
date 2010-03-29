#import "Three20/Three20.h"
#import "InAppSettings.h"
#import "TRTweetTableViewController.h"
#import "TRDefaultStylesheet.h"

// acapela
#include <AudioToolbox/AudioToolbox.h>
#include "babdevlopper.lic.h" 
#include "babdevlopper.lic.password"
#include "AcapelaSpeech.h"

@interface TRAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
    TRTweetTableViewController *trTweetTableViewController;
    UIView *loadingOverlay;
    InAppSettingsViewController *settingsController;
    AcapelaLicense *acapelaLicense;
    AcapelaSpeech *speaker;
    UIBarButtonItem *playButton;
    UIBarButtonItem *pauseButton;
    NSIndexPath *indexPathOfCurrentTweet;
    BOOL playing;
}

@property (nonatomic, retain) UIBarButtonItem *playButton;
@property (nonatomic, retain) UIBarButtonItem *pauseButton;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet TRTweetTableViewController *trTweetTableViewController;
@property (nonatomic, retain) IBOutlet UIView *loadingOverlay;
@property (nonatomic, retain) IBOutlet InAppSettingsViewController *settingsController;
@property (readonly, retain)  IBOutlet AcapelaLicense *acapelaLicense;
@property (readonly, retain)  IBOutlet AcapelaSpeech *speaker;

- (void)setupNavigationBarButtons;
- (void)presentSettings;
- (void)dismissSettings;
- (void)togglePlay;
- (void)playTweetAtIndexPath:(NSIndexPath *)indexPath andScrollTo:(BOOL)scrollTo;
- (void)ensureSpeaker;

- (void)speechSynthesizer:(AcapelaSpeech *)sender didFinishSpeaking: (BOOL)finishedSpeaking;
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakWord: (NSRange)characterRange ofString:(NSString *)string;
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakPhoneme: (short)phonemeOpcode;
- (void)speechSynthesizer:(AcapelaSpeech *)sender didEncounterSyncMessage: (NSString *)errorMessage;

@end

