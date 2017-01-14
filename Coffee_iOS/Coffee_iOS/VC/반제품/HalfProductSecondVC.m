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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    actionArr = [[NSMutableArray alloc] init];
    
    NSLog(@"SESSIONID   :: %@" , SESSIONID);
    NSLog(@"USER_ID     :: %@" , USER_ID);
    mPosition = 0;
    
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
    
    
    //안드로이드
//    mListTv2.setText("(" + mHalfListItems.get(mPosition).getmNum() + "/" + mTotalPosition + ")");
//    //                                mListTv1.setText(mHalfListItems.get(mPosition).getmSample_title() + ":");
//    mListTv1.setText("반제품:");
//    mListTv3.setText(" " + mHalfListItems.get(mPosition).getmSample_code());
//    mSample_idx = mHalfListItems.get(mPosition).getmSample_idx();
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

    
    //안드로이드
    /*
    float totalscore = Float.parseFloat(acidity_point) + Float.parseFloat(sweetness_point) + Float.parseFloat(bitterness_point) + Float.parseFloat(body_point) + Float.parseFloat(balance_point) +
    Float.parseFloat(aftertaste_point) + Float.parseFloat(po_point) + Float.parseFloat(ne_point);
    
    if (result != null) {
        if (result.trim().equals(commonData.SUCCESS)) {
            mDetailBtn1.setText(acidity_point);
            mDetailBtn2.setText(sweetness_point);
            mDetailBtn3.setText(bitterness_point);
            mDetailBtn4.setText(body_point);
            mDetailBtn5.setText(balance_point);
            mDetailBtn6.setText(aftertaste_point);
            mDetailBtn7.setText(po_point);
            mDetailBtn8.setText(ne_point);
            mDetailEdt.setText(note1);
            mDetail4TotalScore.setText(String.valueOf(totalscore));
            mTotalScore = String.valueOf(totalscore);
            
            
            if (isok.equals("Y")){
                mPassBtn.setBackgroundResource(R.drawable.detail1_back1);
                mPassBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_ffffff));
                mRetestBtn.setBackgroundResource(R.drawable.detail1_back2);
                mRetestBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_888888));
                mOkNotokflag = true;
                mOkflag = false;
            }else if (isok.equals("")){
                
            }else {
                mRetestBtn.setBackgroundResource(R.drawable.detail1_back1);
                mRetestBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_ffffff));
                mPassBtn.setBackgroundResource(R.drawable.detail1_back2);
                mPassBtn.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_888888));
                mOkNotokflag = true;
                mOkflag = true;
            }
            
            
        } else {
            Toast.makeText(HalfDetail2Activity.this, result_message, Toast.LENGTH_SHORT).show();
        }
    } else {
        Toast.makeText(HalfDetail2Activity.this, "다시 시도해 주세요.", Toast.LENGTH_SHORT).show();
    }
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

- (IBAction)saveButton:(id)sender {
}

- (IBAction)prevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
- (void) firstInit{
    NSLog(@"mPosition  : %d" ,  mPosition);
    [self Step1];       //통신 1 구간
}
#pragma mark -
#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([actionArr count] == buttonIndex){
        return;
    }
    
//    if(actionSheetNum == 1){
//        [acidityButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    }else if(actionSheetNum == 2){
//        [sweetnessButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    }else if(actionSheetNum == 3){
//        [bitternessButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    }else if(actionSheetNum == 4){
//        [bodyButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    }else if(actionSheetNum == 5){
//        [balanceButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    }else if(actionSheetNum == 6){
//        [aftertasteButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    }else if(actionSheetNum == 7){
//        [poButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    }else if(actionSheetNum == 8){
//        [neButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    }
//    else{
        if([datas count] == buttonIndex){
            return;
        }
        mPosition = buttonIndex;
        [self firstInit ];
//    }
    
    actionArr = [[NSMutableArray alloc] init];
}

@end
