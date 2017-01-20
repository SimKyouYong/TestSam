//
//  MenualReviewLatteVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "MenualReviewLatteVC.h"
#import "MenualReviewDetailVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface MenualReviewLatteVC ()

@end

@implementation MenualReviewLatteVC

@synthesize menualReviewLatteScrollView;
@synthesize topMyLabel;
@synthesize topAvrLabel;
@synthesize Title;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            
            
//            if (Float.parseFloat(mManualListItems.get(mPosition).getmBase_latte_a()) >= Float.parseFloat(coffeeness_point) && Float.parseFloat(mManualListItems.get(mPosition).getmBase_latte_a()) >= Float.parseFloat(balance_point) &&
//                Float.parseFloat(mManualListItems.get(mPosition).getmBase_latte_a()) >= Float.parseFloat(sweetness_point) && Float.parseFloat(mManualListItems.get(mPosition).getmBase_latte_a()) >= Float.parseFloat(body_point)){
//                mMyImg.setBackgroundResource(R.drawable.menual_good);
//                mType = "good";
//            }else if ((Float.parseFloat(mManualListItems.get(mPosition).getmBase_latte_b()) < Float.parseFloat(coffeeness_point) || Float.parseFloat(mManualListItems.get(mPosition).getmBase_latte_b()) < Float.parseFloat(balance_point) ||
//                       Float.parseFloat(mManualListItems.get(mPosition).getmBase_latte_b()) < Float.parseFloat(sweetness_point) || Float.parseFloat(mManualListItems.get(mPosition).getmBase_latte_b()) < Float.parseFloat(body_point))){
//                mMyImg.setBackgroundResource(R.drawable.menual_bad);
//                mType = "bad";
//            }else {
//                mMyImg.setBackgroundResource(R.drawable.menual_normal);
//                mType = "normal";
//            }
                      
            
            _reviewText1.text = ([dic_result objectForKey:@"coffeeness_point"]);
            _reviewText3.text = ([dic_result objectForKey:@"balance_point"]);
            _reviewText5.text = ([dic_result objectForKey:@"sweetness_point"]);
            _reviewText7.text = ([dic_result objectForKey:@"body_point"]);
            
            
            float etcscore = [[dic_result objectForKey:@"coffeeness_point"] floatValue] +
            [[dic_result objectForKey:@"balance_point"] floatValue] +
            [[dic_result objectForKey:@"sweetness_point"] floatValue] +
            [[dic_result objectForKey:@"body_point"] floatValue]
            ;

            
            _mDetail4TotalScore.text = [NSString stringWithFormat:@"MY TOTAL SCORE: %.2f" ,etcscore ];
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
    // 기존 화면들어왔을때 평균값 뿌려주기
    
    _reviewText2.text = ([dic_result3 objectForKey:@"coffeeness_point"]);
    _reviewText4.text = ([dic_result3 objectForKey:@"balance_point"]);
    _reviewText6.text = ([dic_result3 objectForKey:@"sweetness_point"]);
    _reviewText8.text = ([dic_result3 objectForKey:@"body_point"]);
    
    
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
    
    
    //    float totalavrscore = Float.parseFloat(ne_point) + Float.parseFloat(pe_point) + Float.parseFloat(bitterness_point) + Float.parseFloat(aftertaste_point) + Float.parseFloat(acidity_point) +
    //    Float.parseFloat(body_point) + Float.parseFloat(balance_point) + Float.parseFloat(sweetness_point);
    
    
    
    
    
    if (mARVflag){
        //mDetail4Btn0.setBackgroundResource(R.drawable.detail5_back2);
        //mDetail4Btn0.setText("AVR(" + mResult_cnt + "명)");
        topAvrLabel.text = [NSString stringWithFormat:@"AVR(%@명)" ,[dic_result3 objectForKey:@"result_cnt"] ];
    }else {
        //mDetail4Btn0.setBackgroundResource(R.drawable.detail5_back3);
        //mDetail4Btn0.setTextColor(ContextCompat.getColor(getApplication(), R.color.color_000000));
        //mDetail4Btn0.setText("진행중");
        topAvrLabel.text = @"진행중";
        
        
    }
//    float totalavrscore = [[dic_result3 objectForKey:@"po_point"]  floatValue] +
//    [[dic_result3 objectForKey:@"ne_point"]  floatValue] +
//    [[dic_result3 objectForKey:@"bitterness_point"]  floatValue] +
//    [[dic_result3 objectForKey:@"aftertaste_point"]  floatValue] +
//    [[dic_result3 objectForKey:@"acidity_point"]  floatValue] +
//    [[dic_result3 objectForKey:@"body_point"]  floatValue] +
//    [[dic_result3 objectForKey:@"balance_point"]  floatValue] +
//    [[dic_result3 objectForKey:@"sweetness_point"]  floatValue] ;
//    
//    
//    NSString *avrString = [NSString stringWithFormat:@"TOTAL AVR : %f", totalavrscore];
//    NSMutableAttributedString *avrSearch = [[NSMutableAttributedString alloc] initWithString:avrString];
//    NSRange sRange = [avrString rangeOfString:@"TOTAL AVR : "];
//    [avrSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
//    
//    NSString *stdString = [NSString stringWithFormat:@"TOTAL STD : %@", @""];
//    NSMutableAttributedString *stdSearch = [[NSMutableAttributedString alloc] initWithString:stdString];
//    NSRange s1Range = [stdString rangeOfString:@"TOTAL STD : "];
//    [stdSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:s1Range];
//    
//    [_mDetail4ArvScore setAttributedText:avrSearch];
//    [_mDetail4StdScore setAttributedText:stdSearch];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [menualReviewLatteScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 580)];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"latte_push"])
    {
        MenualReviewDetailVC *vc = [segue destinationViewController];
        vc.sampleIndex = sampleIndexValue;
        vc.countNum = detailCount;
        vc.buttonNum = buttonCheck;
    }
}

- (IBAction)americanoButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)detailLeftButton:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 5;
    [self performSegueWithIdentifier:@"latte_push" sender:sender];
}

- (IBAction)detailRightButton:(id)sender {
    [self performSegueWithIdentifier:@"latte_push" sender:sender];
}

- (IBAction)backButton:(id)sender {
    NSArray *backArray = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[backArray objectAtIndex:2] animated:YES];
}

@end
