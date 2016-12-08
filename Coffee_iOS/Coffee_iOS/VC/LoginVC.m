//
//  LoginVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//test

#import "LoginVC.h"
#import "GlobalHeader.h"
#import "BridgeVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

@synthesize empText;
@synthesize PassText;
@synthesize autoLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    if([[defaults stringForKey:AUTO_LOGIN] isEqualToString:@"YES"]){
        empText.text = [defaults stringForKey:EMP_NUMBER];
        PassText.text = [defaults stringForKey:PASSWORD];
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
     [self performSegueWithIdentifier:@"bridge_push" sender:sender];
    
    /*
    NSString *urlString = [NSString stringWithFormat:@"%@", LOGIN_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"e_id=%@&e_pw=%@", empText.text, PassText.text];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            if([resultValue isEqualToString:@"false"]){
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"로그인에 실패하였습니다.\n아이디와 비밀번호를 다시 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                
            }
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"로그인에 실패하였습니다.\n아이디와 비밀번호를 다시 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];
     */
}

@end
