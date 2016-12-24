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

- (void)viewDidLoad {
    [super viewDidLoad];
    mPosition = 0;

    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    _Title.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton)];
    [_Title addGestureRecognizer:tapGesture];
    
    [self firstInit];
    
}
-(void) firstInit{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&opt=manual&session_idx=%@", REVIEW_URL, USER_ID, SESSIONID];
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
    
    [menualScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 640)];
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
            //[self Set3];
            
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
    
    if ([[[datas objectAtIndex:mPosition] valueForKey:@"base_am_a"] floatValue] >= [[dic_result objectForKey:@"acidity_point"] floatValue] &&
        [[[datas objectAtIndex:mPosition] valueForKey:@"base_am_a"] floatValue] >= [[dic_result objectForKey:@"sweetness_point"] floatValue] &&
        [[[datas objectAtIndex:mPosition] valueForKey:@"base_am_a"] floatValue] >= [[dic_result objectForKey:@"bitterness_point"] floatValue] &&
        [[[datas objectAtIndex:mPosition] valueForKey:@"base_am_a"] floatValue] >= [[dic_result objectForKey:@"body_point"] floatValue] &&
        [[[datas objectAtIndex:mPosition] valueForKey:@"base_am_a"] floatValue] >= [[dic_result objectForKey:@"aftertaste_point"] floatValue]){
        [_MyImg setBackgroundImage:[UIImage imageNamed:@"menual_good"] forState:UIControlStateNormal];

        //[_MyImg setImage:[UIImage imageNamed:@"good_icon_60x60"]];
    }else if ([[[datas objectAtIndex:mPosition] valueForKey:@"base_am_b"] floatValue] < [[dic_result objectForKey:@"acidity_point"] floatValue] ||
        [[[datas objectAtIndex:mPosition] valueForKey:@"base_am_b"] floatValue] < [[dic_result objectForKey:@"sweetness_point"] floatValue] ||
        [[[datas objectAtIndex:mPosition] valueForKey:@"base_am_b"] floatValue] < [[dic_result objectForKey:@"bitterness_point"] floatValue] ||
        [[[datas objectAtIndex:mPosition] valueForKey:@"base_am_b"] floatValue] < [[dic_result objectForKey:@"body_point"] floatValue] ||
        [[[datas objectAtIndex:mPosition] valueForKey:@"base_am_b"] floatValue] < [[dic_result objectForKey:@"aftertaste_point"] floatValue]){
//        [_MyImg setImage:[UIImage imageNamed:@"x_button_40x40"]];
        [_MyImg setBackgroundImage:[UIImage imageNamed:@"menual_bad"] forState:UIControlStateNormal];
        
    }else {
//        [_MyImg setImage:[UIImage imageNamed:@"normal_icon_60x60"]];
        [_MyImg setBackgroundImage:[UIImage imageNamed:@"menual_normal"] forState:UIControlStateNormal];

    }
    
    
    float etcscore = [[dic_result objectForKey:@"acidity_point"] floatValue] + [[dic_result objectForKey:@"sweetness_point"] floatValue] + [[dic_result objectForKey:@"bitterness_point"] floatValue]
    + [[dic_result objectForKey:@"body_point"] floatValue] + [[dic_result objectForKey:@"aftertaste_point"] floatValue];
    
    totalSCOREText.text = [NSString stringWithFormat:@"%f" , etcscore];

    
    
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
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)reviewDetailButton1:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton2:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton3:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)reviewDetailButton4:(id)sender {
    [self performSegueWithIdentifier:@"menualReviewDetail" sender:sender];
}

- (IBAction)xButton:(id)sender {
}

- (IBAction)oButton:(id)sender {
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
