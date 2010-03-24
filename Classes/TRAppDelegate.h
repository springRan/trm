#import "Three20/Three20.h"
#import "InAppSettings.h"
#import "TRTweetTableViewController.h"
#import "TRDefaultStylesheet.h"

// acapela
#include <AudioToolbox/AudioToolbox.h>
#include "babdevlopper.lic.h" 
#include "babdevlopper.lic.password"
#include "AcapelaLicense.h"
#include "AcapelaSpeech.h"

@interface TRAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
    TRTweetTableViewController *trTweetTableViewController;
    UIView *loadingOverlay;
    InAppSettingsViewController *settingsController;
    AcapelaLicense *acapelaLicense;
    AcapelaSpeech *speaker;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet TRTweetTableViewController *trTweetTableViewController;
@property (nonatomic, retain) IBOutlet UIView *loadingOverlay;
@property (nonatomic, retain) IBOutlet InAppSettingsViewController *settingsController;
@property (readonly, retain)  IBOutlet AcapelaLicense *acapelaLicense;
@property (readonly, retain)  IBOutlet AcapelaSpeech *speaker;

- (void)presentSettings;
- (void)dismissSettings;
- (void)speakString:(NSString *)string;

@end

