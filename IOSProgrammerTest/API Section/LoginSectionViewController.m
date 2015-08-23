//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"

@interface LoginSectionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
//@property NSString *t;
//@property NSString *message;
//


@end

@implementation LoginSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:self.username.text forKey:@"SuperBoise"];
    [prefs setObject:self.password.text forKey:@"qwerty"];
    
    [prefs synchronize];
    // Do any additional setup after loading the view from its nib.
    
    
}
- (IBAction)login:(UIButton *)sender {
    if ([self.username.text isEqualToString:@"SuperBoise"] && [self.password.text isEqualToString:@"qwerty"]) {
        MainMenuViewController *main = [[MainMenuViewController alloc]init];
        [self.navigationController pushViewController:main animated:YES];
//    }else{

    }
}

- (void)showAlert:(NSString*)title withMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:message delegate:self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
    [alert show];
}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

@end
