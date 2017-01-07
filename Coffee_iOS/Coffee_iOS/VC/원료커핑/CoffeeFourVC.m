//
//  CoffeeFourVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CoffeeFourVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface CoffeeFourVC ()

@end

@implementation CoffeeFourVC

@synthesize coffeeFourScrollView;
@synthesize cup1;
@synthesize cup2;
@synthesize cup3;
@synthesize cup4;
@synthesize cup5;
@synthesize cup6;
@synthesize cup7;
@synthesize cup8;
@synthesize cup9;
@synthesize cup10;
@synthesize cup11;
@synthesize cup12;
@synthesize cup13;
@synthesize cup14;
@synthesize cup15;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mPosition = 0;
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
    //    contentText.text = [[datas objectAtIndex:position] valueForKey:@"sample_title"];
    //
    //    leftText.text = [[datas objectAtIndex:position] valueForKey:@"sample_title"];
    //    NSString *codeStr =[NSString stringWithFormat:@"%@" ,[[datas objectAtIndex:position] valueForKey:@"sample_code"]];
    //    centerText.text = codeStr;
    //    rightText.text = [NSString stringWithFormat:@"(%ld/%@)", position+1 ,total];
    
    //안드로이드
    /*
     
     */
    
    SAMPLE_IDX = [[datas objectAtIndex:position] valueForKey:@"sample_idx"];
    
}

- (void)Step2{
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    //    E/Thread: url  ---->>  http://work.nexall.net/web/app//get_result.php?id=test001&sample_idx=167
    
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
    [_aromaButton setTitle:[dic objectForKey:@"aroma_point"] forState:UIControlStateNormal];
    [_flavorButton setTitle:[dic objectForKey:@"flavor_point"] forState:UIControlStateNormal];
    [_acidityButton setTitle:[dic objectForKey:@"acidity_point"] forState:UIControlStateNormal];
    
    [_aftertasteButton setTitle:[dic objectForKey:@"aftertaste_point"] forState:UIControlStateNormal];
    [_bodyButton setTitle:[dic objectForKey:@"body_point"] forState:UIControlStateNormal];
    [_balanceButton setTitle:[dic objectForKey:@"balance_point"] forState:UIControlStateNormal];
    [_overallButton setTitle:[dic objectForKey:@"overall_point"] forState:UIControlStateNormal];
    
    if([[dic objectForKey:@"cup1"] isEqualToString:@"1"]){
        [cup1 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup1 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup2"] isEqualToString:@"1"]){
        [cup2 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup2 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup3"] isEqualToString:@"1"]){
        [cup3 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup3 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup4"] isEqualToString:@"1"]){
        [cup4 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup4 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup5"] isEqualToString:@"1"]){
        [cup5 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup5 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup6"] isEqualToString:@"1"]){
        [cup6 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup6 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup7"] isEqualToString:@"1"]){
        [cup7 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup7 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup8"] isEqualToString:@"1"]){
        [cup8 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup8 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup9"] isEqualToString:@"1"]){
        [cup9 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup9 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup10"] isEqualToString:@"1"]){
        [cup10 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup10 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup11"] isEqualToString:@"1"]){
        [cup11 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup11 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup12"] isEqualToString:@"1"]){
        [cup12 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup12 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup13"] isEqualToString:@"1"]){
        [cup13 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup13 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup14"] isEqualToString:@"1"]){
        [cup14 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup14 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }
    if([[dic objectForKey:@"cup15"] isEqualToString:@"1"]){
        [cup15 setImage:[UIImage imageNamed:@"on_cup_icon_66x70"] forState:UIControlStateNormal];
    }else{
        [cup15 setImage:[UIImage imageNamed:@"off_cup_icon_66x70"] forState:UIControlStateNormal];
    }    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [coffeeFourScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 850)];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark -
#pragma mark Button Action

- (IBAction)saveButton:(id)sender {
    //Post 방식 으로 해야함.
    //안드로이드
//    map.put("url", CommonData.SERVER + "coffee_result.php");
//    map.put("id", commonData.getUserID());
//    map.put("", mSample_idx);
//    map.put("", "1");
//    map.put("", mDetailBtn1.getText().toString());
//    map.put("", mDetailBtn2.getText().toString());
//    map.put("", mDetailBtn3.getText().toString());
//    map.put("", mDetailEdt.getText().toString());
//    map.put("", mTotalFloral);
//    map.put("", mTotalFruity);
//    map.put("", mTotalAlcoholic);
//    map.put("", mTotalHerb);
//    map.put("", mTotalSpice);
//    map.put("", mTotalSweet);
//    map.put("", mTotalNut);
//    map.put("", mTotalChocolate);
//    map.put("", mTotalGrain);
//    map.put("", mTotalRoast);
//    map.put("", mTotalSavory);
//    map.put("", mTotalFermented);
//    map.put("", mTotalChemical);
//    map.put("", mTotalGreen);
//    map.put("", mTotalMusty);
//    map.put("", mTotalRoastdefect);
//    map.put("", mTotalAcidity_Po);
//    map.put("", mTotalAcidity_Ne);
    NSString *urlString = [NSString stringWithFormat:@"%@%@", REVIEW_URL2, LOGIN_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"id=%@&sample_idx=%@&opt=%@&aroma_point=%@&flavor_point=%@&acidity_point=%@&note1=%@&floral=%@&fruity=%@&alcoholic=%@&herb=%@&spice=%@&sweet=%@&nut=%@&chocolate=%@&grain=%@&roast=%@&savory=%@&fermented=%@&chemical=%@&green=%@&musty=%@&roastdefect=%@&acidity_po=%@&acidity_ne=%@&@"];          //값 추출해서 매칭 시켜야함.
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            NSLog(@"resultValue : %@"  , resultValue);
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"저장에 실패 하였습니다." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];

    
}

- (IBAction)prevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)okButton:(id)sender {
}

- (IBAction)notOkButton:(id)sender {
}

@end
