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
#import "MenualReviewDetailVC.h"

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
@synthesize myImg;
@synthesize youImg;
@synthesize topMyLabel;
@synthesize topAvrLabel;

@synthesize isReviewValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mPosition = 0;
    youImg.hidden = YES;
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    _Title.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton)];
    [_Title addGestureRecognizer:tapGesture];
    
    
    topAvrLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture_top =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton_top)];
    [topAvrLabel addGestureRecognizer:tapGesture_top];
    
    [self firstInit];
}

- (void) firstInit{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&opt=manual&session_idx=%@%@", SAMPLELIST_URL, USER_ID, SESSIONID, isReviewValue];
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
            datas = [dic objectForKey:@"datas"];
            if ([datas count] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"값이 존재하지 않습니다." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                return;
                
            }
            //Title 값 셋팅
            _Title.text = [NSString stringWithFormat:@"메뉴얼:%@(%@/%@)",
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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [menualScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 900)];
}

- (void)Init:(NSInteger)position{
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%ld%@", REVIEW_URL2, USER_ID, (long)position, isReviewValue];
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
            [self resultText];
        
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
    NSDictionary *dic = [datas3 objectAtIndex:0];
    mUserID = [dic objectForKey:@"result_memberid"];
    
    // 기존 화면들어왔을때 평균값 뿌려주기
    acidityRightText.text = ([dic_result3 objectForKey:@"acidity_point"]);
    sweetnessRightText.text = ([dic_result3 objectForKey:@"sweetness_point"]);
    bitternessRightText.text = ([dic_result3 objectForKey:@"bitterness_point"]);
    bodyRightText.text = ([dic_result3 objectForKey:@"body_point"]);
    aftertasteRightText.text = ([dic_result3 objectForKey:@"aftertaste_point"]);
    
    BOOL mARVflag;

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

    totalAVRText.textColor = [UIColor redColor];
    NSString *avrString = [NSString stringWithFormat:@"TOTAL AVR : %@", [dic_result3 objectForKey:@"totalavr"]];
    NSMutableAttributedString *avrSearch = [[NSMutableAttributedString alloc] initWithString:avrString];
    NSRange sRange = [avrString rangeOfString:@"TOTAL AVR : "];
    [avrSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
    
    NSString *stdString = [NSString stringWithFormat:@"TOTAL STD : %@", [dic_result3 objectForKey:@"totalstd"]];
    NSMutableAttributedString *stdSearch = [[NSMutableAttributedString alloc] initWithString:stdString];
    NSRange s1Range = [stdString rangeOfString:@"TOTAL STD : "];
    [stdSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:s1Range];
    
    [totalAVRText setAttributedText:avrSearch];
    [totalSTDText setAttributedText:stdSearch];
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
    
    
    if ([[dic_result objectForKey:@"isok"] isEqualToString:@"Y"]){
        [myImg setImage:[UIImage imageNamed:@"menual_good"]];
    }else if ([[dic_result objectForKey:@"isok"] isEqualToString:@"N"]){
        [myImg setImage:[UIImage imageNamed:@"menual_normal"]];
    }else if ([[dic_result objectForKey:@"isok"] isEqualToString:@"X"]){
        [myImg setImage:[UIImage imageNamed:@"menual_bad"]];
    }else {
        myImg.hidden = YES;
    }
    
    float etcscore = [[dic_result objectForKey:@"acidity_point"] floatValue] + [[dic_result objectForKey:@"sweetness_point"] floatValue] + [[dic_result objectForKey:@"bitterness_point"] floatValue]
    + [[dic_result objectForKey:@"body_point"] floatValue] + [[dic_result objectForKey:@"aftertaste_point"] floatValue];
    
    NSString *scoreString = [NSString stringWithFormat:@"MY TOTAL SCORE : %@", [dic_result objectForKey:@"mytotalscore"]];
    NSMutableAttributedString *scoreSearch = [[NSMutableAttributedString alloc] initWithString:scoreString];
    NSRange sRange = [scoreString rangeOfString:@"MY TOTAL SCORE : "];
    [scoreSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
    
    [totalSCOREText setAttributedText:scoreSearch];
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
        MenualReviewDetailVC *vc = [segue destinationViewController];
        vc.sampleIndex = sampleIndexValue;
        vc.countNum = detailCount;
        vc.buttonNum = buttonCheck;
        
        if (buttonCheck == 1 || buttonCheck == 3) {
            //my
            vc.ID = USER_ID;
        }else{
            //U
            vc.ID = mUserID;//선택된 아이디값 넘겨줘야함!
        }
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)reviewDetailButton1:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 1;
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton2:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 2;

    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton3:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 3;
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton4:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 4;

    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)leftXOButton:(id)sender {
}

- (IBAction)rightXOButton:(id)sender {
}

- (IBAction)backButton:(id)sender {
    NSArray *backArray = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[backArray objectAtIndex:2] animated:YES];
}

- (IBAction)latteButton:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewLatte_push" sender:sender];
}

- (void)selectButton{
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"샘플을 선택해주세요.";
    menu.delegate = self;
    for(int i = 0; i < [datas count]; i++){
        NSDictionary *codeDic = [datas objectAtIndex:i];
        [menu addButtonWithTitle:[codeDic objectForKey:@"sample_title"]];
    }
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}
- (void)selectButton_top{
    if([datas3 count] == 0){
        return;
    }
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"샘플점수 비교하실분을 선택해주세요.";
    menu.delegate = self;
    menu.tag = 2;
    for(int i = 0; i < [datas3 count]; i++){
        NSDictionary *codeDic = [datas3 objectAtIndex:i];
        [menu addButtonWithTitle:[codeDic objectForKey:@"result_membername"]];
    }
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}


#pragma mark -
#pragma ActionSheet Delegate

// 문서종류 리스트
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 2){
        if([datas3 count] == buttonIndex){
            return;
        }
        
        NSDictionary *dic = [datas3 objectAtIndex:buttonIndex];
        NSString *name = [dic objectForKey:@"result_membername"];
        mUserID = [dic objectForKey:@"result_memberid"];
        
        NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%lu&target_id=%@", REVIEW_URL4, USER_ID, (unsigned long)mSample_idx, [dic objectForKey:@"result_memberid"]];
        NSLog(@"SKY4 URL : %@" , urlString);
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [urlRequest setHTTPMethod:@"GET"];
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            //NSLog(@"Response:%@ %@\n", response, error);
            
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if(statusCode == 200){
                acidityRightText.text = ([dic_result3 objectForKey:@"acidity_point"]);
                sweetnessRightText.text = ([dic_result3 objectForKey:@"sweetness_point"]);
                bitternessRightText.text = ([dic_result3 objectForKey:@"bitterness_point"]);
                bodyRightText.text = ([dic_result3 objectForKey:@"body_point"]);
                aftertasteRightText.text = ([dic_result3 objectForKey:@"aftertaste_point"]);
                if (buttonIndex == 0) {
                    topAvrLabel.text =[NSString stringWithFormat:@"AVR(%lu)명" , ([datas3 count]-1)] ;
                }else{
                    topAvrLabel.text =[NSString stringWithFormat:@"%@" , name] ;
                }
                
            }else{
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic_result3 objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
        [dataTask resume];
        
    }else{
        if([datas count] == buttonIndex){
            return;
        }
        mPosition = buttonIndex;
        [self firstInit ];
    }
}

@end
