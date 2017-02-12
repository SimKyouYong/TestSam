//
//  LoginVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//test

#import "LoginVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "BridgeVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

@synthesize empText;
@synthesize passText;
@synthesize autoLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    if([[defaults stringForKey:AUTO_LOGIN] isEqualToString:@"YES"]){
        empText.text = [defaults stringForKey:EMP_NUMBER];
        passText.text = [defaults stringForKey:PASSWORD];
        [autoLogin setOn:YES];
    }else{
        [autoLogin setOn:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"bridge_push"])
    {

    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)autoLogin:(id)sender {
    if([autoLogin isOn]){
        [defaults setObject:@"YES" forKey:AUTO_LOGIN];
        
    }else{
        [defaults setObject:@"NO" forKey:AUTO_LOGIN];
    }
}
 
- (IBAction)loginButton:(id)sender {
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&pw=%@&regkey=%@&os=ios", LOGIN_URL, empText.text, passText.text, [defaults stringForKey:TOKEN_KEY]];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];

    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        //NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            if([autoLogin isOn]){
                [defaults setObject:empText.text forKey:EMP_NUMBER];
                [defaults setObject:passText.text forKey:PASSWORD];
                
            }else{
                [defaults setObject:@"" forKey:EMP_NUMBER];
                [defaults setObject:@"" forKey:PASSWORD];
            }
            
            [defaults synchronize];
            
            USER_NO = [dic objectForKey:@"userno"];
            USER_ID = [dic objectForKey:@"userid"];
            USER_NICK = [dic objectForKey:@"usernick"];
            
            [self performSegueWithIdentifier:@"bridge_push" sender:sender];
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];
}

#pragma mark -
#pragma mark TextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSInteger textY = 0;
    if(textField == empText){
        textY = -50;
    }else if(textField == passText){
        textY = -50;
    }
    if(WIDTH_FRAME == 414){
        textY = 0;
    }
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 textY,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
