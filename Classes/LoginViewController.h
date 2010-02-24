#import <UIKit/UIKit.h>
#import "Twitter.h"

@interface LoginViewController : UIViewController {
  IBOutlet UITextField *login;
  IBOutlet UITextField *password;
  IBOutlet UIButton *loginButton;
  UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UITextField *login;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) UINavigationController *navigationController;

- (IBAction)userDidPressLoginButton:(id)sender;

@end
