//
//  HalfProductReViewVC.m
//  Coffee_iOS
//
//  Created by 심규용 on 2016. 12. 18..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HalfProductReViewVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface HalfProductReViewVC ()

@end

@implementation HalfProductReViewVC

@synthesize halfScrollView;
@synthesize tableList_;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&opt=half&session_idx=%@", REVIEW_URL, USER_ID, SESSIONID];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        //NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            
            [defaults synchronize];
            datas = [dic objectForKey:@"datas"];
            //
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
    
    [halfScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 740)];
}

- (void)Init{
    
    //    map.put("url", CommonData.SERVER + "/get_result.php" + "?id=" + commonData.getUserID() + "&sample_idx=" + mSample_idx);
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%@", REVIEW_URL2, USER_ID, [[datas objectAtIndex:0] valueForKey:@"sample_idx"]];
    NSLog(@"SKY2 URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        //NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        dic_result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic_result objectForKey:@"result"] isEqualToString:@"success"]){
            
            [defaults synchronize];
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
    //    map.put("url", CommonData.SERVER + "/get_avr_result.php" + "?id=" + commonData.getUserID() + "&sample_idx=" + mSample_idx);
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%@", REVIEW_URL3, USER_ID, [[datas objectAtIndex:0] valueForKey:@"sample_idx"]];
    NSLog(@"SKY3 URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        //NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        dic_result3 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic_result3 objectForKey:@"result"] isEqualToString:@"success"]){
            
            [defaults synchronize];
            datas3 = [dic_result3 objectForKey:@"datas"];
            
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"SAMPLE_DATA :: %@" , dic_result3);
            NSLog(@"/*---------------------------------------*/");
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"SAMPLE_DATA :: %@" , datas3);
            NSLog(@"/*---------------------------------------*/");
            [self Init3];
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic_result3 objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];
}
- (void)Init3{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"halfReviewDetail"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)reviewDetailButton1:(id)sender {
    [self performSegueWithIdentifier:@"halfReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton2:(id)sender {
    [self performSegueWithIdentifier:@"halfReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton3:(id)sender {
    [self performSegueWithIdentifier:@"halfReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton4:(id)sender {
    [self performSegueWithIdentifier:@"halfReviewDetail" sender:sender];
}

- (IBAction)passButton:(id)sender {
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)retestButton:(id)sender {
}

@end
