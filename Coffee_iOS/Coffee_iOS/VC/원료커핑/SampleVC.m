//
//  CoffeeFirstVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "SampleVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"


//1. 화면 유아이 잡기
//2. 피커뷰 확인 버튼만 넣어주세영.

@interface SampleVC ()

@end

@implementation SampleVC
@synthesize contentText;
@synthesize leftText;
@synthesize centerText;
@synthesize rightText;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    contentText.editable = NO;

    total = 0;
    
    //통신 시작
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&session_idx=%@", SAMPLELIST_URL, USER_ID, SESSIONID];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            total = [dic objectForKey:@"totalnum"];
            [defaults synchronize];
            datas = [dic objectForKey:@"datas"];
            NSLog(@"SAMPLE_DATA :: %@" , datas);
            [self init:0];
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

- (void)init:(NSInteger)position{
    contentText.text = [[datas objectAtIndex:position] valueForKey:@"sample_title"];

    leftText.text = [[datas objectAtIndex:position] valueForKey:@"sample_title"];
    NSString *codeStr =[NSString stringWithFormat:@"%@" ,[[datas objectAtIndex:position] valueForKey:@"sample_code"]];
    centerText.text = codeStr;
    rightText.text = [NSString stringWithFormat:@"(%ld/%@)", position+1 ,total];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"coffee2"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectButton:(id)sender {
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"샘플을 선택해주세요.";
    menu.delegate = self;
    for(int i = 0; i < [datas count]; i++){
        NSDictionary *codeDic = [datas objectAtIndex:i];
        [menu addButtonWithTitle:[codeDic objectForKey:@"sample_code"]];
    }
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

#pragma mark -
#pragma ActionSheet Delegate

// 문서종류 리스트
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([datas count] == buttonIndex){
        return;
    }
    
    [self init:buttonIndex];
}

@end
