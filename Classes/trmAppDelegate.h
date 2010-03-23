#import "InAppSettings.h"
#import "Three20/Three20.h"
#import "RootViewController.h"
#import "TRDefaultStylesheet.h"

// acapela
#include <AudioToolbox/AudioToolbox.h>
#include "babdevlopper.lic.h" 
#include "babdevlopper.lic.password"
#include "AcapelaLicense.h"
#include "AcapelaSpeech.h"

@interface trmAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
    RootViewController *rootViewController;
    UIView *loadingOverlay;
    InAppSettingsViewController *settingsController;
    AcapelaLicense *acapelaLicense;
    AcapelaSpeech *speaker;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet UIView *loadingOverlay;
@property (nonatomic, retain) IBOutlet InAppSettingsViewController *settingsController;
@property (readonly, retain)  IBOutlet AcapelaLicense *acapelaLicense;
@property (readonly, retain)  IBOutlet AcapelaSpeech *speaker;

- (void)setLoadingOverlayVisibility:(BOOL)visibility;
- (IBAction)presentSettings;
- (void)dismissSettings;
- (void)speakString:(NSString *)string;

@end

