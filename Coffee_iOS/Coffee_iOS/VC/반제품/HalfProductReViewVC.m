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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mPosition = 0;

    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    _Title.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton)];
    [_Title addGestureRecognizer:tapGesture];
    
    [self firstInit ];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [halfScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 740)];
}
-(void) firstInit{

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
            
            //            mListTv2.setText("(" + mSourceListItems.get(mPosition).getmNum() + "/" + mTotalPosition + ")");
            //            mListTv1.setText("원료커핑:");
            //            mListTv3.setText(" " + mSourceListItems.get(mPosition).getmSample_code());
            //            mSample_idx = mSourceListItems.get(mPosition).getmSample_idx();
            
            //Title 값 셋팅
            _Title.text = [NSString stringWithFormat:@"원료커핑:%@(%@/%@)",
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
    
    //    map.put("url", CommonData.SERVER + "/get_result.php" + "?id=" + commonData.getUserID() + "&sample_idx=" + mSample_idx);
    
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
            _mDetail4Btn1.text = ([dic_result objectForKey:@"acidity_point"]);
            _mDetail4Btn3.text = ([dic_result objectForKey:@"sweetness_point"]);
            _mDetail4Btn5.text = ([dic_result objectForKey:@"bitterness_point"]);
            _mDetail4Btn7.text = ([dic_result objectForKey:@"body_point"]);
            _mDetail4Btn9.text = ([dic_result objectForKey:@"balance_point"]);
            _mDetail4Btn11.text = ([dic_result objectForKey:@"aftertaste_point"]);
            _mDetail4Btn13.text = ([dic_result objectForKey:@"po_point"]);
            _mDetail4Btn15.text = ([dic_result objectForKey:@"ne_point"]);
            
            float etcscore = [[dic_result objectForKey:@"acidity_point"] floatValue] +
            [[dic_result objectForKey:@"sweetness_point"] floatValue] +
            [[dic_result objectForKey:@"bitterness_point"] floatValue] +
            [[dic_result objectForKey:@"body_point"] floatValue] +
            [[dic_result objectForKey:@"balance_point"] floatValue] +
            [[dic_result objectForKey:@"aftertaste_point"] floatValue] +
            [[dic_result objectForKey:@"po_point"] floatValue] +
            [[dic_result objectForKey:@"ne_point"] floatValue];
            
            
            
            _mDetail4TotalScore.text = [NSString stringWithFormat:@"%f" ,etcscore ];
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
    //    map.put("url", CommonData.SERVER + "/get_avr_result.php" + "?id=" + commonData.getUserID() + "&sample_idx=" + mSample_idx);
    
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
    
//    NSString *amora_point =              [dic_result3 objectForKey:@"amora_point"];
//    NSString *flavor_point =      [dic_result3 objectForKey:@"flavor_point"];
//    NSString *aftertaste_point =                [dic_result3 objectForKey:@"aftertaste_point"];
//    NSString *acidity_point =                [dic_result3 objectForKey:@"acidity_point"];
//    NSString *body_point =                [dic_result3 objectForKey:@"body_point"];
//    NSString *balance_point =                [dic_result3 objectForKey:@"balance_point"];
//    NSString *overall_point =                [dic_result3 objectForKey:@"overall_point"];
//    NSString *uniformity_point =                [dic_result3 objectForKey:@"uniformity_point"];
//    NSString *cleancup_point =                [dic_result3 objectForKey:@"cleancup_point"];
//    NSString *sweetness_point =                [dic_result3 objectForKey:@"sweetness_point"];
//    NSString *ne_point =                [dic_result3 objectForKey:@"ne_point"];
//    NSString *pe_point =               [dic_result3 objectForKey:@"pe_point"];
//    NSString *total_cnt =               [dic_result3 objectForKey:@"result_cnt"];
//    
    mResult_cnt = [dic_result3 objectForKey:@"result_cnt"];
    
    mFloral = [dic_result3 objectForKey:@"floral"];
    mFruity = [dic_result3 objectForKey:@"fruity"];
    mAlcoholic = [dic_result3 objectForKey:@"alcoholic"];
    mHerb = [dic_result3 objectForKey:@"herb"];
    mSpice = [dic_result3 objectForKey:@"spice"];
    mSweet = [dic_result3 objectForKey:@"sweet"];
    mNut = [dic_result3 objectForKey:@"nut"];
    mChocolate = [dic_result3 objectForKey:@"chocolate"];
    mGrain = [dic_result3 objectForKey:@"grain"];
    mRoast = [dic_result3 objectForKey:@"roast"];
    mSavory = [dic_result3 objectForKey:@"savory"];
    
    mFermented = [dic_result3 objectForKey:@"fermented"];
    mChemical = [dic_result3 objectForKey:@"chemical"];
    mGreen = [dic_result3 objectForKey:@"green"];
    mMusty = [dic_result3 objectForKey:@"musty"];
    mRoastdefect = [dic_result3 objectForKey:@"roastdefect"];
    
    if ([[dic_result3 objectForKey:@"total_cnt"] isEqualToString:mResult_cnt]){
        mARVflag = NO;
    }else {
        mARVflag = YES;
    }
    
    float totalavrscore = [[dic_result3 objectForKey:@"ne_point"] floatValue] +
    [[dic_result3 objectForKey:@"pe_point"] floatValue] +
    [[dic_result3 objectForKey:@"bitterness_point"] floatValue] +
    [[dic_result3 objectForKey:@"aftertaste_point"] floatValue] +
    [[dic_result3 objectForKey:@"acidity_point"] floatValue] +
    [[dic_result3 objectForKey:@"body_point"] floatValue] +
    [[dic_result3 objectForKey:@"balance_point"] floatValue] +
    [[dic_result3 objectForKey:@"sweetness_point"] floatValue] ;
    
    NSString *avrValue = nil;
    if (mARVflag){
        //android
        //상대방 맨위 빨강색
        //        mDetail4Btn0.setBackgroundResource(R.drawable.detail5_back2);
        //        mDetail4Btn0.setText("AVR(" + mResult_cnt + "명)");
        avrValue = [NSString stringWithFormat:@"%f" , totalavrscore];
    }else {
        //android
        //        mDetail4Btn0.setBackgroundResource(R.drawable.detail5_back3);
        //        mDetail4Btn0.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_000000));
        //        mDetail4Btn0.setText("진행중");
        avrValue = @"";
    }
    
    NSString *avrString = [NSString stringWithFormat:@"TOTAL AVR : %@", avrValue];
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
