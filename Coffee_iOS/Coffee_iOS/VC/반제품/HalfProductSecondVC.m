//
//  HalfProductSecondVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HalfProductSecondVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface HalfProductSecondVC ()

@end

@implementation HalfProductSecondVC

@synthesize halfSecondScrollView;
@synthesize halfSecondTextView;
@synthesize toptitle;
@synthesize acidityButton;
@synthesize sweetnessButton;
@synthesize bitternessButton;
@synthesize bodyButton;
@synthesize balanceButton;
@synthesize aftertasteButton;
@synthesize poButton;
@synthesize neButton;
@synthesize noteTextView;
@synthesize myTotalScore;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    actionArr = [[NSMutableArray alloc] init];
    
    NSLog(@"SESSIONID   :: %@" , SESSIONID);
    NSLog(@"USER_ID     :: %@" , USER_ID);
    mPosition = 0;
    mOkNotokflag = NO;
    toptitle.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton)];
    [toptitle addGestureRecognizer:tapGesture];

    
    
    [self Step1];       //통신 1 구간

    
}
- (void)Step1{
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&session_idx=%@", SAMPLELIST_URL, USER_ID, SESSIONID];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            [defaults synchronize];
            datas = [dic objectForKey:@"datas"];
            NSLog(@"1. DATAS :: %@" , datas);
            [self init:mPosition];
            [self Step2];       //통신 2 구간
            
            //Title 값 셋팅
            toptitle.text = [NSString stringWithFormat:@"반제품:%@(%@/%@)",
                             [[datas objectAtIndex:mPosition] valueForKey:@"sample_code"],
                             [[datas objectAtIndex:mPosition] valueForKey:@"num"],
                             [dic objectForKey:@"totalnum"]
                             ];

            
            
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
    SAMPLE_IDX = [[datas objectAtIndex:position] valueForKey:@"sample_idx"];
}
- (void)Step2{
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%@", REVIEW_URL2, USER_ID, SAMPLE_IDX];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            [defaults synchronize];
            NSLog(@"2. DATA :: %@" , dic);
            
            [self init2:dic];
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

- (void)init2:(NSDictionary *)dic{
    
    
    tableDic = dic;

    float totalscore = [[dic objectForKey:@"acidity_point"] floatValue] +
    [[dic objectForKey:@"sweetness_point"] floatValue] +
    [[dic objectForKey:@"bitterness_point"] floatValue] +
    [[dic objectForKey:@"body_point"] floatValue] +
    [[dic objectForKey:@"balance_point"] floatValue] +
    [[dic objectForKey:@"aftertaste_point"] floatValue] +
    [[dic objectForKey:@"po_point"] floatValue] +
    [[dic objectForKey:@"ne_point"] floatValue];

    if([dic objectForKey:@"result"] != nil){
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            
            [acidityButton setTitle:[dic objectForKey:@"acidity_point"] forState:UIControlStateNormal];
            [acidityButton setTitle:[dic objectForKey:@"sweetness_point"] forState:UIControlStateNormal];
            [acidityButton setTitle:[dic objectForKey:@"bitterness_point"] forState:UIControlStateNormal];
            [acidityButton setTitle:[dic objectForKey:@"body_point"] forState:UIControlStateNormal];
            [acidityButton setTitle:[dic objectForKey:@"balance_point"] forState:UIControlStateNormal];
            [acidityButton setTitle:[dic objectForKey:@"aftertaste_point"] forState:UIControlStateNormal];
            [acidityButton setTitle:[dic objectForKey:@"po_point"] forState:UIControlStateNormal];
            [acidityButton setTitle:[dic objectForKey:@"ne_point"] forState:UIControlStateNormal];
            
            noteTextView.text = [dic objectForKey:@"note_total"];
            mTotalScore = [NSString stringWithFormat:@"%.1f" , totalscore];

            myTotalScore.text = [NSString stringWithFormat:@"MY TOTAL SCORE : %@" , mTotalScore];
            

            if([@"Y" isEqualToString:[dic objectForKey:@"isok"]]){
//                mPassBtn.setBackgroundResource(R.drawable.detail1_back1);
//                mPassBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_ffffff));
//                mRetestBtn.setBackgroundResource(R.drawable.detail1_back2);
//                mRetestBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_888888));
                mOkNotokflag = YES;
//                mOkflag = false;

            }else if([@"" isEqualToString:[dic objectForKey:@"isok"]]){
//
            }else{
//                mRetestBtn.setBackgroundResource(R.drawable.detail1_back1);
//                mRetestBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_ffffff));
//                mPassBtn.setBackgroundResource(R.drawable.detail1_back2);
//                mPassBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_888888));
                mOkNotokflag = YES;
//                mOkflag = true;
            }
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
            
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
    //안드로이드
    /*
    
    
    */
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [halfSecondScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 760)];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@""])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    NSArray *backArray = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[backArray objectAtIndex:2] animated:YES];
}

- (IBAction)saveButton:(id)sender {
    /*
    
    if (!mOkNotokflag){
        Toast.makeText(HalfDetail2Activity.this, "PASS/RETEST 선택해 주세요.", Toast.LENGTH_SHORT).show();
    }else if (mDetailEdt.getText().toString().equals("")) {
        Toast.makeText(HalfDetail2Activity.this, "총평을 작성해 주세요.", Toast.LENGTH_SHORT).show();
    }else {
        //
    }
     */
    NSLog(@"text : %@", noteTextView.text);
    NSString *ok;
    if (!mOkNotokflag){
        ok = @"Y";
    }else {
        ok = @"N";
    }

    if (!mOkNotokflag){
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"PASS/RETEST 선택해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([@"" isEqualToString:[NSString stringWithFormat:@"%@", noteTextView.text]]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"총평을 작성해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        //저장
        [self save:ok];
    }
}
-(void) save:(NSString *)isok{
//    map.put("url", CommonData.SERVER + "coffee_result_final.php" + "?id=" + commonData.getUserID() + "&sample_idx=" + mSample_idx + "&note_total=" + mDetailEdt.getText().toString() + "&isok=" + ok);
//    map.put("url", CommonData.SERVER + "coffee_result_final.php");
//    map.put("id", commonData.getUserID());
//    map.put("sample_idx", mSample_idx);
//    map.put("note_total", mDetailEdt.getText().toString());
//    map.put("isok", ok);
    NSString *urlString = [NSString stringWithFormat:@"%@", HALF_SAVE];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"id=%@&sample_idx=%@&note_total=%@&isok=%@", USER_ID, SAMPLE_IDX, [NSString stringWithFormat:@"%@", noteTextView.text] , isok];
    NSLog(@"반제품2 : %@", params);
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            NSLog(@"resultValue : %@"  , resultValue);
            if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"저장되었습니다." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
                
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
    }];
    [dataTask resume];
}
- (IBAction)passButton:(id)sender{
//    mPassBtn.setBackgroundResource(R.drawable.detail1_back1);
//    mPassBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_ffffff));
//    mRetestBtn.setBackgroundResource(R.drawable.detail1_back2);
//    mRetestBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_888888));
    mOkNotokflag = YES;
//    mOkflag = false;
}

- (IBAction)retestButton:(id)sender{
//    mRetestBtn.setBackgroundResource(R.drawable.detail1_back1);
//    mRetestBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_ffffff));
//    mPassBtn.setBackgroundResource(R.drawable.detail1_back2);
//    mPassBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_888888));
    mOkNotokflag = YES;
//    mOkflag = true;
}

- (IBAction)prevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectButton{
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"샘플을 선택해주세요.";
    menu.delegate = self;
    menu.tag = 1;
    for(int i = 0; i < [datas count]; i++){
        NSDictionary *codeDic = [datas objectAtIndex:i];
        [menu addButtonWithTitle:[codeDic objectForKey:@"sample_code"]];
    }
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}
- (void) firstInit{
    NSLog(@"mPosition  : %d" ,  mPosition);
    [self Step1];       //통신 1 구간
}
#pragma mark -
#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 1) {
        if([datas count] == buttonIndex){
            return;
        }
        mPosition = buttonIndex;
        [self firstInit ];
    }else{
        if([actionArr count] == buttonIndex){
            return;
        }
        
        if(actionSheetNum == 1){
            [acidityButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 2){
            [sweetnessButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 3){
            [bitternessButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 4){
            [bodyButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 5){
            [balanceButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 6){
            [aftertasteButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 7){
            [poButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 8){
            [neButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else{
            
        }
        
        actionArr = [[NSMutableArray alloc] init];
    }
}

@end
