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
#import "HalfProductReviewDetailVC.h"

@interface HalfProductReViewVC ()

@end

@implementation HalfProductReViewVC

@synthesize halfScrollView;
@synthesize tableList_;
@synthesize topMyLabel;
@synthesize topAvrLabel;
@synthesize Title;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mPosition = 0;

    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    Title.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton)];
    [Title addGestureRecognizer:tapGesture];

    [self firstInit ];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [halfScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 740)];
}

- (void) firstInit{

    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&session_idx=%@", REVIEW_URL, USER_ID, SESSIONID];
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
            NSLog(@"SAMPLE_DATA :: %@" , dic);
            NSLog(@"[dic objectForKey:num] :: %@" , [NSString stringWithFormat:@"%@", [[datas objectAtIndex:mPosition] valueForKey:@"num"]]);
            NSLog(@"/*---------------------------------------*/");
            
            //Title 값 셋팅
            Title.text = [NSString stringWithFormat:@"반제품:%@(%@/%@)",
                          [[datas objectAtIndex:mPosition] valueForKey:@"sample_code"],
                          [[datas objectAtIndex:mPosition] valueForKey:@"num"],
                          [dic objectForKey:@"totalnum"]
                          ];
            mSample_idx = [[[datas objectAtIndex:mPosition] valueForKey:@"sample_idx"] intValue];
            
            
            [self Init:mSample_idx];
            
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

- (void)Init:(NSInteger)position{
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%ld", REVIEW_URL2, USER_ID, (long)position];
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
            NSLog(@"sample_idx h :: %@" , dic_result);
            NSLog(@"/*---------------------------------------*/");
            [self Set2];
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

- (void)Set2{
    //IOS
    if ([dic_result objectForKey:@"result"] != nil) {
        if ([[dic_result objectForKey:@"result"] isEqualToString:@"success"]) {
            float etcscore = [[dic_result objectForKey:@"acidity_point"] floatValue] +
            [[dic_result objectForKey:@"sweetness_point"] floatValue] +
            [[dic_result objectForKey:@"bitterness_point"] floatValue] +
            [[dic_result objectForKey:@"body_point"] floatValue] +
            [[dic_result objectForKey:@"balance_point"] floatValue] +
            [[dic_result objectForKey:@"aftertaste_point"] floatValue]+
            [[dic_result objectForKey:@"po_point"] floatValue]+
            [[dic_result objectForKey:@"ne_point"] floatValue] ;

            _mDetail4Btn1.text = ([dic_result objectForKey:@"acidity_point"]);
            _mDetail4Btn3.text = ([dic_result objectForKey:@"sweetness_point"]);
            _mDetail4Btn5.text = ([dic_result objectForKey:@"bitterness_point"]);
            _mDetail4Btn7.text = ([dic_result objectForKey:@"body_point"]);
            _mDetail4Btn9.text = ([dic_result objectForKey:@"aftertaste_point"]);
            _mDetail4Btn11.text = ([dic_result objectForKey:@"balance_point"]);
            _mDetail4Btn13.text = ([dic_result objectForKey:@"po_point"]);
            _mDetail4Btn15.text = ([dic_result objectForKey:@"ne_point"]);
            
            NSString *scoreString = [NSString stringWithFormat:@"MY TOTAL SCORE : %.2f", etcscore];
            NSMutableAttributedString *scoreSearch = [[NSMutableAttributedString alloc] initWithString:scoreString];
            NSRange sRange = [scoreString rangeOfString:@"MY TOTAL SCORE : "];
            [scoreSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
            
            [_mDetail4TotalScore setAttributedText:scoreSearch];
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic_result objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)Init2{
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%lu", REVIEW_URL3, USER_ID, (unsigned long)mSample_idx];
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
            NSLog(@"dic_result3 :: %@" , dic_result3);
            NSLog(@"/*---------------------------------------*/");
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"datas3 :: %@" , datas3);
            NSLog(@"/*---------------------------------------*/");
            [self Set3];
            
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

//상대방 셋팅
- (void)Set3{
    // 기존 화면들어왔을때 평균값 뿌려주기
    _mDetail4Btn2.text = ([dic_result3 objectForKey:@"acidity_point"]);
    _mDetail4Btn4.text = ([dic_result3 objectForKey:@"sweetness_point"]);
    _mDetail4Btn6.text = ([dic_result3 objectForKey:@"bitterness_point"]);
    _mDetail4Btn8.text = ([dic_result3 objectForKey:@"body_point"]);
    _mDetail4Btn10.text = ([dic_result3 objectForKey:@"balance_point"]);
    _mDetail4Btn12.text = ([dic_result3 objectForKey:@"aftertaste_point"]);
    _mDetail4Btn14.text = ([dic_result3 objectForKey:@"po_point"]);
    _mDetail4Btn16.text = ([dic_result3 objectForKey:@"ne_point"]);
    
        if ([[dic_result3 objectForKey:@"total_cnt"] isEqualToString:[dic_result3 objectForKey:@"result_cnt"]]){
        mARVflag = YES;
    }else {
        mARVflag = NO;
    }
  
    if ([@"Y" isEqualToString:[dic_result3 objectForKey:@"isok"]]) {
        //mOkBtn.setText("PASS");
    } else {
        //mOkBtn.setText("RETEST");
    }
    
    if (mARVflag){
        topAvrLabel.text = [NSString stringWithFormat:@"AVR(%@명)" ,[dic_result3 objectForKey:@"result_cnt"] ];
    }else {
        topAvrLabel.text = @"진행중";
    }
    
    float totalavrscore = [[dic_result3 objectForKey:@"po_point"]  floatValue] +
    [[dic_result3 objectForKey:@"ne_point"]  floatValue] +
    [[dic_result3 objectForKey:@"bitterness_point"]  floatValue] +
    [[dic_result3 objectForKey:@"aftertaste_point"]  floatValue] +
    [[dic_result3 objectForKey:@"acidity_point"]  floatValue] +
    [[dic_result3 objectForKey:@"body_point"]  floatValue] +
    [[dic_result3 objectForKey:@"balance_point"]  floatValue] +
    [[dic_result3 objectForKey:@"sweetness_point"]  floatValue] ;
    
    NSString *avrString = [NSString stringWithFormat:@"TOTAL AVR : %.2f", totalavrscore];
    NSMutableAttributedString *avrSearch = [[NSMutableAttributedString alloc] initWithString:avrString];
    NSRange sRange = [avrString rangeOfString:@"TOTAL AVR : "];
    [avrSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
    
    NSString *stdString = [NSString stringWithFormat:@"TOTAL STD : %@", @""];
    NSMutableAttributedString *stdSearch = [[NSMutableAttributedString alloc] initWithString:stdString];
    NSRange s1Range = [stdString rangeOfString:@"TOTAL STD : "];
    [stdSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:s1Range];
    
    [_mDetail4ArvScore setAttributedText:avrSearch];
    [_mDetail4StdScore setAttributedText:stdSearch];
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
        HalfProductReviewDetailVC *vc = [segue destinationViewController];
        vc.sampleIndex = sampleIndexValue;
        vc.countNum = detailCount;
        vc.buttonNum = buttonCheck;
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)reviewDetailButton1:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 1;
    [self performSegueWithIdentifier:@"halfReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton2:(id)sender {
    [self performSegueWithIdentifier:@"halfReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton3:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 3;
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

- (void)selectButton{
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
    mPosition = buttonIndex;
    [self firstInit ];
    
}
@end
