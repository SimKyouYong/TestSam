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
@synthesize mRetestBtn;
@synthesize mPassBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    fix_position = 0;

    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"완료" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar setItems:[NSArray arrayWithObjects:leftSpace, done, nil]];
    [toolbar sizeToFit];
    
    [noteTextView setInputAccessoryView:toolbar];
    
    actionArr = [[NSMutableArray alloc] init];
    
    NSLog(@"SESSIONID   :: %@" , SESSIONID);
    NSLog(@"USER_ID     :: %@" , USER_ID);

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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&session_idx=%@&isreview=Y", SAMPLELIST_URL, USER_ID, SESSIONID];
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
            [self init:MPOSITION];
            [self Step2];       //통신 2 구간
            
            //Title 값 셋팅
            toptitle.text = [NSString stringWithFormat:@"반제품:%@(%@/%@)",
                             [[datas objectAtIndex:MPOSITION] valueForKey:@"sample_code"],
                             [[datas objectAtIndex:MPOSITION] valueForKey:@"num"],
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%@&isreview=Y", REVIEW_URL2, USER_ID, SAMPLE_IDX];
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
            [sweetnessButton setTitle:[dic objectForKey:@"sweetness_point"] forState:UIControlStateNormal];
            [bitternessButton setTitle:[dic objectForKey:@"bitterness_point"] forState:UIControlStateNormal];
            [bodyButton setTitle:[dic objectForKey:@"body_point"] forState:UIControlStateNormal];
            [balanceButton setTitle:[dic objectForKey:@"balance_point"] forState:UIControlStateNormal];
            [aftertasteButton setTitle:[dic objectForKey:@"aftertaste_point"] forState:UIControlStateNormal];
            [poButton setTitle:[dic objectForKey:@"po_point"] forState:UIControlStateNormal];
            [neButton setTitle:[dic objectForKey:@"ne_point"] forState:UIControlStateNormal];
            
            noteTextView.text = [dic objectForKey:@"note_total"];
            mTotalScore = [NSString stringWithFormat:@"%.1f" , totalscore];

            myTotalScore.text = [NSString stringWithFormat:@"MY TOTAL SCORE : %@" , mTotalScore];
            myTotalScore.textColor = [UIColor redColor];
            NSString *avrString = [NSString stringWithFormat:@"MY TOTAL SCORE : %@", mTotalScore];
            NSMutableAttributedString *avrSearch = [[NSMutableAttributedString alloc] initWithString:avrString];
            NSRange sRange = [avrString rangeOfString:@"MY TOTAL SCORE : "];
            [avrSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
            [myTotalScore setAttributedText:avrSearch];
            
            if([@"Y" isEqualToString:[dic objectForKey:@"isok"]]){
                mOkNotokflag = YES;
                mOkflag = NO;
                mPassBtn.backgroundColor = [UIColor colorWithRed:135/255.0
                                                           green:13/255.0
                                                            blue:32/255.0
                                                           alpha:1.0];
                [mPassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                mRetestBtn.backgroundColor = [UIColor colorWithRed:228/255.0
                                                             green:228/255.0
                                                              blue:228/255.0
                                                             alpha:1.0];
                [mRetestBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }else if([@"" isEqualToString:[dic objectForKey:@"isok"]]){

            }else{
                mOkNotokflag = YES;
                mOkflag = YES;
                mRetestBtn.backgroundColor = [UIColor colorWithRed:135/255.0
                                                             green:13/255.0
                                                              blue:32/255.0
                                                             alpha:1.0];
                [mRetestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                mPassBtn.backgroundColor = [UIColor colorWithRed:228/255.0
                                                           green:228/255.0
                                                            blue:228/255.0
                                                           alpha:1.0];
                [mPassBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

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

- (void)save:(NSString *)isok{
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
    mOkNotokflag = YES;
//    mPassBtn.setBackgroundResource(R.drawable.detail1_back1);
//    mPassBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_ffffff));
//    mRetestBtn.setBackgroundResource(R.drawable.detail1_back2);
//    mRetestBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_888888));
//    mOkNotokflag = true;
//    mOkflag = false;

    mPassBtn.backgroundColor = [UIColor colorWithRed:135/255.0
                                                         green:13/255.0
                                                          blue:32/255.0
                                                         alpha:1.0];
    [mPassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    mRetestBtn.backgroundColor = [UIColor colorWithRed:228/255.0
                                               green:228/255.0
                                                blue:228/255.0
                                               alpha:1.0];
    
    [mRetestBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];


}

- (IBAction)retestButton:(id)sender{
    mOkNotokflag = YES;
    
    mRetestBtn.backgroundColor = [UIColor colorWithRed:135/255.0
                                               green:13/255.0
                                                blue:32/255.0
                                               alpha:1.0];
    [mRetestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    mPassBtn.backgroundColor = [UIColor colorWithRed:228/255.0
                                                 green:228/255.0
                                                  blue:228/255.0
                                                 alpha:1.0];
    
    [mPassBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

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
    NSLog(@"mPosition  : %ld" ,  MPOSITION);
    [self Step1];       //통신 1 구간
}

- (IBAction)acidityButton:(id)sender {
    /*
    actionSheetNum = 1;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex4_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex4_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex4_step"] floatValue];
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"점수를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
    [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    while (startNum != endNum) {
        startNum = startNum + stepNum;
        [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
        [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
     */
}

- (IBAction)sweetnessButton:(id)sender {
    /*
    actionSheetNum = 2;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex9_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex9_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex9_step"] floatValue];
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"점수를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
    [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    while (startNum != endNum) {
        startNum = startNum + stepNum;
        [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
        [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
     */
}

- (IBAction)bitternessButton:(id)sender {
    /*
    actionSheetNum = 3;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex11_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex11_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex11_step"] floatValue];
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"점수를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
    [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    while (startNum != endNum) {
        startNum = startNum + stepNum;
        [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
        [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
     */
}

- (IBAction)bodyButton:(id)sender {
    /*
    actionSheetNum = 4;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex5_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex5_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex5_step"] floatValue];
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"점수를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
    [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    while (startNum != endNum) {
        startNum = startNum + stepNum;
        [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
        [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
     */
}

- (IBAction)balanceButton:(id)sender {
    /*
    actionSheetNum = 5;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex6_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex6_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex6_step"] floatValue];
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"점수를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
    [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    while (startNum != endNum) {
        startNum = startNum + stepNum;
        [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
        [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
     */
}

- (IBAction)aftertasteButton:(id)sender {
    /*
    actionSheetNum = 6;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex3_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex3_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex3_step"] floatValue];
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"점수를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
    [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    while (startNum != endNum) {
        startNum = startNum + stepNum;
        [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
        [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
     */
}

- (IBAction)poButton:(id)sender {
    /*
    actionSheetNum = 7;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex16_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex16_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex16_step"] floatValue];
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"점수를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
    [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    while (startNum != endNum) {
        startNum = startNum + stepNum;
        [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
        [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
     */
}

- (IBAction)neButton:(id)sender {
    /*
    actionSheetNum = 8;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex17_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex17_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex17_step"] floatValue];
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"점수를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
    [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    while (startNum != endNum) {
        startNum = startNum + stepNum;
        [menu addButtonWithTitle:[NSString stringWithFormat:@"%.2f", startNum]];
        [actionArr addObject:[NSString stringWithFormat:@"%.2f", startNum]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
     */
}

#pragma mark -
#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 1) {
        if([datas count] == buttonIndex){
            return;
        }
        //기존 포지션과 다르면, 1페이지로 강제 이동 mPosition 들고 이동해야함.
        if (MPOSITION != buttonIndex) {
            NSLog(@"mPosition 값 변경후 1페이지로 이동");
            NSInteger count = [self.navigationController.viewControllers count];
            MPOSITION = buttonIndex;
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-2] animated:YES];
            return;
        }else{
            MPOSITION = buttonIndex;
        }
        
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

#pragma mark -
#pragma mark TextField

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSInteger textY = 0;
    if(textView == noteTextView){
        textY = -210;
    }
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 textY,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    return YES;
}

- (void)done{
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [noteTextView resignFirstResponder];
}

@end
