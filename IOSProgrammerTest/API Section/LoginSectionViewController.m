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

@property (nonatomic, strong) NSURLConnection *loginConnection;
@property (nonatomic, strong) NSMutableData *responseData;


@property (strong, nonatomic) NSDate *requestStartTime;
@property (strong, nonatomic) NSDate *requestFinishTime;
@property (nonatomic) NSTimeInterval totalRequestTime;
//@property NSMutableData *responseData;

@end

@implementation LoginSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loginRequest{
    NSURL *url = [[NSURL alloc] initWithString:@"http://dev.AppPartner.com/AppPartnerProgrammerTest/scripts/login.php"];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    
    postRequest.HTTPMethod = @"POST";
    
    NSString *credentials = [NSString stringWithFormat:@"username=%@&password=%@", self.username.text, self.password.text];
    
    NSData *requestBodyData = [credentials dataUsingEncoding:NSUTF8StringEncoding];
    postRequest.HTTPBody = requestBodyData;
    
    self.loginConnection = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self startImmediately:YES];
    self.requestStartTime = [NSDate date];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[NSDate date] timeIntervalSince1970];
    
    //Check to see if this works when i get home
//    self.requestFinishTime = [NSDate date];
//    self.totalRequestTime = [self.requestFinishTime timeIntervalSinceDate:self.requestStartTime];
    NSLog(@"%f", self.totalRequestTime);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self apiResponse];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}

- (void)apiResponse{
    
    NSMutableDictionary *decodedData = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    NSLog(@"%@",decodedData);
    
    NSString *code = [decodedData valueForKey:@"code"];
    NSString *message = [decodedData valueForKey:@"message"];
    NSString *alertView = [NSString stringWithFormat:@"%@\n The API request took %f milliseconds",message, self.totalRequestTime *1000 ];
    
    UIAlertView *response = [[UIAlertView alloc]initWithTitle:code message:alertView delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    [response show];
}

- (IBAction)login:(UIButton *)sender {
    if ([self.username.text isEqualToString:@"SuperBoise"] && [self.password.text isEqualToString:@"qwerty"]) {
        MainMenuViewController *main = [[MainMenuViewController alloc]init];
        [self.navigationController pushViewController:main animated:YES];
    }
    [self loginRequest];
}

- (IBAction)backAction:(id)sender {
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

@end
