//
//  MenualReViewVC.m
//  Coffee_iOS
//
//  Created by 심규용 on 2016. 12. 18..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "MenualReViewVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
@interface MenualReViewVC ()

@end

@implementation MenualReViewVC

@synthesize menualScrollView;

@synthesize totalAVRText;
@synthesize totalSTDText;
@synthesize totalSCOREText;

@synthesize acidityLeftText;
@synthesize acidityRightText;
@synthesize sweetnessLeftText;
@synthesize sweetnessRightText;
@synthesize bitternessLeftText;
@synthesize bitternessRightText;
@synthesize bodyLeftText;
@synthesize bodyRightText;
@synthesize aftertasteLeftText;
@synthesize aftertasteRightText;

@synthesize americanoButton;
@synthesize latteButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&opt=manual&session_idx=%@", REVIEW_URL, USER_ID, SESSIONID];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            datas = [dic objectForKey:@"datas"];
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"SAMPLE_DATA :: %@" , datas);
            NSLog(@"/*---------------------------------------*/");
            
            [self Init];
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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [menualScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 640)];
}

// 리스트 값 뿌려주기
- (void)Init{
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%@", REVIEW_URL2, USER_ID, [[datas objectAtIndex:0] valueForKey:@"sample_idx"]];
    NSLog(@"SKY2 URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        dic_result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic_result objectForKey:@"result"] isEqualToString:@"success"]){
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"SAMPLE_DATA :: %@" , dic_result);
            NSLog(@"/*---------------------------------------*/");
            [self Init2];
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic_result objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];
}

- (void)Init2{
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%@", REVIEW_URL3, USER_ID, [[datas objectAtIndex:0] valueForKey:@"sample_idx"]];
    NSLog(@"SKY3 URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        dic_result2 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic_result2 objectForKey:@"result"] isEqualToString:@"success"]){
            datas3 = [dic_result2 objectForKey:@"datas"];
            
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"SAMPLE_DATA :: %@" , dic_result2);
            NSLog(@"/*---------------------------------------*/");
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"SAMPLE_DATA :: %@" , datas3);
            NSLog(@"/*---------------------------------------*/");
            
            [self resultText];
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic_result2 objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];
}

// 서버에서 받은 값 뿌려주기
- (void)resultText{
    totalAVRText.text = @"TOTAL ACR : ";
    totalSTDText.text = @"TOTAL STD : ";
    totalSCOREText.text = @"TOTAL SCORE : ";
    
    acidityLeftText.text = [dic_result objectForKey:@"acidity_point"];
    acidityRightText.text = [dic_result objectForKey:@"acidity_po"];
    sweetnessLeftText.text = [dic_result objectForKey:@"sweetness_point"];
    sweetnessRightText.text = [dic_result objectForKey:@"sweet"];
    bitternessLeftText.text = [dic_result objectForKey:@"bitterness_point"];
    bitternessRightText.text = [dic_result objectForKey:@"bitterness_po"];
    bodyLeftText.text = [dic_result objectForKey:@"body_point"];
    bodyRightText.text = [dic_result objectForKey:@"body_medium"];
    aftertasteLeftText.text = [dic_result objectForKey:@"aftertaste_point"];
    aftertasteRightText.text = [dic_result objectForKey:@"aftertaste_po"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"menualReviewDetail"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)reviewDetailButton1:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton2:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton3:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton4:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)xButton:(id)sender {
}

- (IBAction)oButton:(id)sender {
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)americanoButton:(id)sender {
    [americanoButton setImage:[UIImage imageNamed:@"tab7_on_bg_250x94.png"] forState:UIControlStateNormal];
    [latteButton setImage:[UIImage imageNamed:@"tab8_off_bg_250x94.png"] forState:UIControlStateNormal];
}

- (IBAction)latteButton:(id)sender {
    [americanoButton setImage:[UIImage imageNamed:@"tab7_off_bg_250x94.png"] forState:UIControlStateNormal];
    [latteButton setImage:[UIImage imageNamed:@"tab8_on_bg_250x94.png"] forState:UIControlStateNormal];
}

@end
