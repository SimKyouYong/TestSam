//
//  CoffeReViewVC.m
//  Coffee_iOS
//
//  Created by 심규용 on 2016. 12. 17..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CoffeReViewVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "CoffeeReviewDetailVC.h"

@interface CoffeReViewVC ()

@end

@implementation CoffeReViewVC

@synthesize coffeeReviewScrollView;
@synthesize Title;
@synthesize isReviewValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //초기 셋팅
    mResult_cnt = @"0";
    mPosition = 0;
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    Title.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton)];
    [Title addGestureRecognizer:tapGesture];
    
    _topAvrLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture_top =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton_top)];
    [_topAvrLabel addGestureRecognizer:tapGesture_top];
    
    [self firstInit];
}

- (void)firstInit{
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&opt=source&session_idx=%@%@", SAMPLELIST_URL, USER_ID, SESSIONID, isReviewValue];
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
            if ([datas count] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"값이 존재하지 않습니다." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                return;
                
            }
            //
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"SAMPLE_DATA :: %@" , datas);
            NSLog(@"[dic objectForKey:num] :: %@" , [NSString stringWithFormat:@"%@", [[datas objectAtIndex:mPosition] valueForKey:@"num"]]);
            NSLog(@"/*---------------------------------------*/");
            
            //Title 값 셋팅
            Title.text = [NSString stringWithFormat:@"원료커핑:%@(%@/%@)",
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
    
    [coffeeReviewScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 1585)];
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
    NSString *result =              [dic_result objectForKey:@"result"];
    NSString *result_message =      [dic_result objectForKey:@"result_message"];
    NSString *cup1 =                [dic_result objectForKey:@"cup1"];
    NSString *cup2 =                [dic_result objectForKey:@"cup2"];
    NSString *cup3 =                [dic_result objectForKey:@"cup3"];
    NSString *cup4 =                [dic_result objectForKey:@"cup4"];
    NSString *cup5 =                [dic_result objectForKey:@"cup5"];
    NSString *cup6 =                [dic_result objectForKey:@"cup6"];
    NSString *cup7 =                [dic_result objectForKey:@"cup7"];
    NSString *cup8 =                [dic_result objectForKey:@"cup8"];
    NSString *cup9 =                [dic_result objectForKey:@"cup9"];
    NSString *cup10 =               [dic_result objectForKey:@"cup10"];
    NSString *cup11 =               [dic_result objectForKey:@"cup11"];
    NSString *cup12 =               [dic_result objectForKey:@"cup12"];
    NSString *cup13 =               [dic_result objectForKey:@"cup13"];
    NSString *cup14 =               [dic_result objectForKey:@"cup14"];
    NSString *cup15 =               [dic_result objectForKey:@"cup15"];
    NSString *aroma_point =         [dic_result objectForKey:@"aroma_point"];
    NSString *flavor_point =        [dic_result objectForKey:@"flavor_point"];
    NSString *aftertaste_point =    [dic_result objectForKey:@"aftertaste_point"];
    NSString *acidity_point =       [dic_result objectForKey:@"acidity_point"];
    NSString *body_point =          [dic_result objectForKey:@"body_point"];
    NSString *balance_point =       [dic_result objectForKey:@"balance_point"];
    NSString *overall_point =       [dic_result objectForKey:@"overall_point"];
    NSString *isok =                [dic_result objectForKey:@"isok"];
    
    NSUInteger m3Btn1_1 = 1;
    NSUInteger m3Btn1_2 = 1;
    NSUInteger m3Btn1_3 = 1;
    NSUInteger m3Btn1_4 = 1;
    NSUInteger m3Btn1_5 = 1;
    NSUInteger m3Btn2_1 = 1;
    NSUInteger m3Btn2_2 = 1;
    NSUInteger m3Btn2_3 = 1;
    NSUInteger m3Btn2_4 = 1;
    NSUInteger m3Btn2_5 = 1;
    NSUInteger m3Btn3_1 = 1;
    NSUInteger m3Btn3_2 = 1;
    NSUInteger m3Btn3_3 = 1;
    NSUInteger m3Btn3_4 = 1;
    NSUInteger m3Btn3_5 = 1;
    
    //IOS
    if ([isok isEqualToString:@"Y"]) {
        [_mOkBtn setImage:[UIImage imageNamed:@"ok_on_button_330x80"] forState:UIControlStateNormal];
        //[mOkBtn setTitle:newBtnTitle forState:UIControlStateSelected];
        [_mNOTOKBtn setImage:[UIImage imageNamed:@"notok2_off_button_330x80"] forState:UIControlStateNormal];
        //[mNOTOKBtn setTitle:newBtnTitle forState:UIControlStateSelected];
    }else{
        [_mNOTOKBtn setImage:[UIImage imageNamed:@"notok_on_button_330x80"] forState:UIControlStateNormal];
        //[mOkBtn setTitle:newBtnTitle forState:UIControlStateSelected];
        [_mOkBtn setImage:[UIImage imageNamed:@"ok2_off_button_330x80"] forState:UIControlStateNormal];
        //[mNOTOKBtn setTitle:newBtnTitle forState:UIControlStateSelected];
    }
    
    //IOS
    if (result != nil) {
        if ([result isEqualToString:@"success"]) {
            _mDetail4Btn1.text =            aroma_point;
            _mDetail4Btn3.text =            flavor_point;
            _mDetail4Btn5.text =            aftertaste_point;
            _mDetail4Btn7.text =            acidity_point;
            _mDetail4Btn9.text =            body_point;
            _mDetail4Btn11.text =           balance_point;
            _mDetail4Btn13.text =           overall_point;
            if ([cup1 isEqualToString:@"1"]) {
                [_mDetail4Btn1_1 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn1_1 = 1;
            } else{
                [_mDetail4Btn1_1 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn1_1 = 0;
            }
            
            if ([cup2 isEqualToString:@"1"]) {
                [_mDetail4Btn1_2 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn1_2 = 1;
            } else{
                [_mDetail4Btn1_2 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn1_2 = 0;
            }
            if ([cup3 isEqualToString:@"1"]) {
                [_mDetail4Btn1_3 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn1_3 = 1;
            } else {
                [_mDetail4Btn1_3 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn1_3 = 0;
            }
            if ([cup4 isEqualToString:@"1"]) {
                [_mDetail4Btn1_4 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn1_4 = 1;
            } else {
                [_mDetail4Btn1_4 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn1_4 = 0;
            }
            
            if ([cup5 isEqualToString:@"1"]) {
                [_mDetail4Btn1_5 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn1_5 = 1;
            } else {
                [_mDetail4Btn1_5 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn1_5 = 0;
            }
            
            if ([cup6 isEqualToString:@"1"]) {
                [_mDetail4Btn3_1 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn2_1 = 1;
            } else {
                [_mDetail4Btn3_1 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn2_1 = 0;
            }
            
            if ([cup7 isEqualToString:@"1"]) {
                [_mDetail4Btn3_2 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn2_2 = 1;
            } else {
                [_mDetail4Btn3_2 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn2_2 = 0;
            }
            
            
            if ([cup8 isEqualToString:@"1"]) {
                [_mDetail4Btn3_3 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn2_3 = 1;
            } else {
                [_mDetail4Btn3_3 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn2_3 = 0;
            }
            
            if ([cup9 isEqualToString:@"1"]) {
                [_mDetail4Btn3_4 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn2_4 = 1;
            } else {
                [_mDetail4Btn3_4 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn2_4 = 0;
            }
            
            if ([cup10 isEqualToString:@"1"]) {
                [_mDetail4Btn3_5 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn2_5 = 1;
            } else {
                [_mDetail4Btn3_5 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn2_5 = 0;
            }
            
            if ([cup11 isEqualToString:@"1"]) {
                [_mDetail4Btn5_1 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn3_1 = 1;
            } else {
                [_mDetail4Btn5_1 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn3_1 = 0;
            }
            
            if ([cup12 isEqualToString:@"1"]) {
                [_mDetail4Btn5_2 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn3_2 = 1;
            } else {
                [_mDetail4Btn5_2 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn3_2 = 0;
            }
            
            if ([cup13 isEqualToString:@"1"]) {
                [_mDetail4Btn5_3 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn3_3 = 1;
            } else {
                [_mDetail4Btn5_3 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn3_3 = 0;
            }
            
            if ([cup14 isEqualToString:@"1"]) {
                [_mDetail4Btn5_4 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn3_4 = 1;
            } else {
                [_mDetail4Btn5_4 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn3_4 = 0;
            }
            
            if ([cup15 isEqualToString:@"1"]) {
                [_mDetail4Btn5_5 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                m3Btn3_5 = 1;
            } else {
                [_mDetail4Btn5_5 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                m3Btn3_5 = 0;
            }
            
            
            //총평 계산
            float cup1score = (m3Btn1_1) + (m3Btn1_2) + (m3Btn1_3) + (m3Btn1_4) + (m3Btn1_5);
            float cup2score = (m3Btn2_1) + (m3Btn2_2) + (m3Btn2_3) + (m3Btn2_4) + (m3Btn2_5);
            float cup3score = (m3Btn2_1) + (m3Btn3_2) + (m3Btn3_3) + (m3Btn3_4) + (m3Btn3_5);
            
            float cup1total = cup1score * 2;
            _mDetail4Btn15.text =[NSString stringWithFormat:@"%.1f" , cup1total] ;
            
            float cup2total = cup2score * 2;
            _mDetail4Btn17.text =[NSString stringWithFormat:@"%.1f" , cup2total] ;
            
            float cup3total = cup3score * 2;
            _mDetail4Btn19.text =[NSString stringWithFormat:@"%.1f" , cup3total] ;
            
            
            
            float etcscore = [aroma_point floatValue] +
            [flavor_point floatValue] +
            [aftertaste_point floatValue] +
            [acidity_point floatValue] +
            [body_point floatValue] +
            [balance_point floatValue] +
            [overall_point floatValue];
            
            float totalscore = cup1score * 2 + cup2score * 2 + cup3score * 2 + etcscore;
            
            NSString *scoreString = [NSString stringWithFormat:@"MY TOTAL SCORE : %@", [dic_result objectForKey:@"mytotalscore"]];
            NSMutableAttributedString *scoreSearch = [[NSMutableAttributedString alloc] initWithString:scoreString];
            NSRange sRange = [scoreString rangeOfString:@"MY TOTAL SCORE : "];
            [scoreSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
            
            [_mDetail4TotalScore setAttributedText:scoreSearch];
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:result_message preferredStyle:UIAlertControllerStyleAlert];
            
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
    
    NSString *aroma_point =              [dic_result3 objectForKey:@"aroma_point"];
    NSString *flavor_point =      [dic_result3 objectForKey:@"flavor_point"];
    NSString *aftertaste_point =                [dic_result3 objectForKey:@"aftertaste_point"];
    NSString *acidity_point =                [dic_result3 objectForKey:@"acidity_point"];
    NSString *body_point =                [dic_result3 objectForKey:@"body_point"];
    NSString *balance_point =                [dic_result3 objectForKey:@"balance_point"];
    NSString *overall_point =                [dic_result3 objectForKey:@"overall_point"];
    NSString *uniformity_point =                [dic_result3 objectForKey:@"uniformity_point"];
    NSString *cleancup_point =                [dic_result3 objectForKey:@"cleancup_point"];
    NSString *sweetness_point =                [dic_result3 objectForKey:@"sweetness_point"];
    //NSString *ne_point =                [dic_result3 objectForKey:@"ne_point"];
    //NSString *pe_point =               [dic_result3 objectForKey:@"pe_point"];
    NSString *total_cnt =               [dic_result3 objectForKey:@"total_cnt"];
    
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
    
    if ([total_cnt isEqualToString:mResult_cnt]) {
        mARVflag = YES;
    }else{
        mARVflag = NO;
    }
    
    
    float totalavrscore = [aroma_point floatValue] +  [flavor_point floatValue] + [aftertaste_point floatValue] +
    [acidity_point floatValue] + [body_point floatValue] +
    [balance_point floatValue] + [overall_point floatValue] + [uniformity_point floatValue] + [cleancup_point floatValue] + [sweetness_point floatValue];
    
    if ([datas3 count] > 0) {
        NSLog(@"json : %@", datas3);
        NSLog(@"json2 : %@", dic_result3);
        
    }
    
    _mDetail4Btn2.text =[NSString stringWithFormat:@"%@" , aroma_point] ;
    _mDetail4Btn4.text =[NSString stringWithFormat:@"%@" , flavor_point] ;
    _mDetail4Btn6.text =[NSString stringWithFormat:@"%@" , aftertaste_point] ;
    _mDetail4Btn8.text =[NSString stringWithFormat:@"%@" , acidity_point] ;
    _mDetail4Btn10.text =[NSString stringWithFormat:@"%@" , body_point] ;
    _mDetail4Btn12.text =[NSString stringWithFormat:@"%@" , balance_point] ;
    _mDetail4Btn14.text =[NSString stringWithFormat:@"%@" , overall_point] ;
    _mDetail4Btn16.text =[NSString stringWithFormat:@"%@" , uniformity_point] ;
    _mDetail4Btn18.text =[NSString stringWithFormat:@"%@" , cleancup_point] ;
    _mDetail4Btn20.text =[NSString stringWithFormat:@"%@" , sweetness_point] ;
    
    
    NSString *avrValue = nil;
    if (mARVflag){
        //상대방 맨위 빨강색
        _topAvrLabel.text =[NSString stringWithFormat:@"AVR(%@)명" , [dic_result3 objectForKey:@"result_cnt"]] ;
        avrValue = [NSString stringWithFormat:@"%.2f" , totalavrscore];
    }else {
        _topAvrLabel.text = @"진행중" ;
    }
    
    _mDetail4ArvScore.textColor = [UIColor redColor];
    NSString *avrString = [NSString stringWithFormat:@"TOTAL AVR : %@", [dic_result3 objectForKey:@"totalavr"]];
    NSMutableAttributedString *avrSearch = [[NSMutableAttributedString alloc] initWithString:avrString];
    NSRange sRange = [avrString rangeOfString:@"TOTAL AVR : "];
    [avrSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
    
    NSString *stdString = [NSString stringWithFormat:@"TOTAL STD : %@", [dic_result3 objectForKey:@"totalstd"]];
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
    if ([[segue identifier] isEqualToString:@"coffeeReviewDetail"])
    {
        NSLog(@"buttonCheck :: %ld" ,(long)buttonCheck);
        CoffeeReviewDetailVC *vc = [segue destinationViewController];
        vc.sampleIndex = sampleIndexValue;
        vc.countNum = detailCount;
        vc.buttonNum = buttonCheck;
        if (buttonCheck == 1 || buttonCheck == 3 || buttonCheck == 5 || buttonCheck == 7) {
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

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// my 평가보기
- (IBAction)reviewDetailButton1:(id)sender {
    sampleIndexValue = mSample_idx;
    detailCount = 4;
    buttonCheck = 1;
    [self performSegueWithIdentifier:@"coffeeReviewDetail" sender:sender];
}
// U
- (IBAction)reviewDetailButton2:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 2;
    
    [self performSegueWithIdentifier:@"coffeeReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton3:(id)sender {
    sampleIndexValue = mSample_idx;
    detailCount = 4;
    buttonCheck = 3;
    [self performSegueWithIdentifier:@"coffeeReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton4:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 4;
    
    [self performSegueWithIdentifier:@"coffeeReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton5:(id)sender {
    sampleIndexValue = mSample_idx;
    detailCount = 1;
    buttonCheck = 5;
    [self performSegueWithIdentifier:@"coffeeReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton6:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 6;
    
    [self performSegueWithIdentifier:@"coffeeReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton7:(id)sender {
    sampleIndexValue = mSample_idx;
    detailCount = 1;
    buttonCheck = 7;
    [self performSegueWithIdentifier:@"coffeeReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton8:(id)sender {
    sampleIndexValue = mSample_idx;
    buttonCheck = 8;
    [self performSegueWithIdentifier:@"coffeeReviewDetail" sender:sender];
}

- (IBAction)mOkBtn:(id)sender{
    
}

- (IBAction)mNOTOKBtn:(id)sender{
    
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

#pragma mark -
#pragma ActionSheet Delegate

// 액션시트 리스트
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 1){
        if([datas count] == buttonIndex){
            return;
        }
        mPosition = buttonIndex;
        [self firstInit ];
    }
    
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
            NSLog(@"%@", dic);
            if(statusCode == 200){
                _mDetail4Btn2.text = [dic objectForKey:@"aroma_point"];
                _mDetail4Btn4.text = [dic objectForKey:@"flavor_point"];
                _mDetail4Btn6.text = [dic objectForKey:@"aftertaste_point"];
                _mDetail4Btn8.text = [dic objectForKey:@"acidity_point"];
                _mDetail4Btn10.text = [dic objectForKey:@"body_point"];
                _mDetail4Btn12.text = [dic objectForKey:@"balance_point"];
                _mDetail4Btn14.text = [dic objectForKey:@"overall_point"];
                
                float _mDetail4Btn16_Point = [[dic objectForKey:@"cup1"] floatValue] + [[dic objectForKey:@"cup2"] floatValue] + [[dic objectForKey:@"cup3"] floatValue] + [[dic objectForKey:@"cup4"] floatValue] + [[dic objectForKey:@"cup5"] floatValue];
                float _mDetail4Btn18_Point = [[dic objectForKey:@"cup6"] floatValue] + [[dic objectForKey:@"cup7"] floatValue] + [[dic objectForKey:@"cup8"] floatValue] + [[dic objectForKey:@"cup9"] floatValue] + [[dic objectForKey:@"cup10"] floatValue];
                float _mDetail4Btn20_Point = [[dic objectForKey:@"cup11"] floatValue] + [[dic objectForKey:@"cup12"] floatValue] + [[dic objectForKey:@"cup13"] floatValue] + [[dic objectForKey:@"cup14"] floatValue] + [[dic objectForKey:@"cup15"] floatValue];
                _mDetail4Btn16.text = [NSString stringWithFormat:@"%.1f", _mDetail4Btn16_Point * 2];
                _mDetail4Btn18.text = [NSString stringWithFormat:@"%.1f", _mDetail4Btn18_Point * 2];
                _mDetail4Btn20.text = [NSString stringWithFormat:@"%.1f", _mDetail4Btn20_Point * 2];
                if (buttonIndex == 0) {
                    _topAvrLabel.text =[NSString stringWithFormat:@"AVR(%lu)명" , ([datas3 count]-1)] ;
                }else{
                    _topAvrLabel.text =[NSString stringWithFormat:@"%@" , name] ;
                }
                
                if ([[dic objectForKey:@"cup1"] isEqualToString:@"1"]) {
                    [_mDetail4Btn2_1 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn2_1 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup2"] isEqualToString:@"1"]) {
                    [_mDetail4Btn2_2 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn2_2 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup3"] isEqualToString:@"1"]) {
                    [_mDetail4Btn2_3 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn2_3 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup4"] isEqualToString:@"1"]) {
                    [_mDetail4Btn2_4 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn2_4 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup5"] isEqualToString:@"1"]) {
                    [_mDetail4Btn2_5 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn2_5 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                
                if ([[dic objectForKey:@"cup6"] isEqualToString:@"1"]) {
                    [_mDetail4Btn4_1 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn4_1 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup7"] isEqualToString:@"1"]) {
                    [_mDetail4Btn4_2 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn4_2 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup8"] isEqualToString:@"1"]) {
                    [_mDetail4Btn4_3 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn4_3 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup9"] isEqualToString:@"1"]) {
                    [_mDetail4Btn4_4 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn4_4 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup10"] isEqualToString:@"1"]) {
                    [_mDetail4Btn4_5 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn4_5 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                
                if ([[dic objectForKey:@"cup11"] isEqualToString:@"1"]) {
                    [_mDetail4Btn6_1 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn6_1 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup12"] isEqualToString:@"1"]) {
                    [_mDetail4Btn6_2 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn6_2 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup13"] isEqualToString:@"1"]) {
                    [_mDetail4Btn6_3 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn6_3 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup14"] isEqualToString:@"1"]) {
                    [_mDetail4Btn6_4 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn6_4 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
                }
                if ([[dic objectForKey:@"cup15"] isEqualToString:@"1"]) {
                    [_mDetail4Btn6_5 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"]];
                } else{
                    [_mDetail4Btn6_5 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"]];
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
    }
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

@end
