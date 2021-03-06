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
@synthesize toptitle;
@synthesize coffeeFourTextView;
@synthesize mNOTOKBtn;
@synthesize mOkBtn;
@synthesize myTotalScoreText;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"완료" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar setItems:[NSArray arrayWithObjects:leftSpace, done, nil]];
    [toolbar sizeToFit];
    
    [coffeeFourTextView setInputAccessoryView:toolbar];
    
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
            [self init:MPOSITION];
            [self Step2];       //통신 2 구간
            //Title 값 셋팅
            toptitle.text = [NSString stringWithFormat:@"원료커핑:%@(%@/%@)",
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
    myTotalScoreText.textColor = [UIColor redColor];
    NSString *avrString = [NSString stringWithFormat:@"MY TOTAL SCORE : %@", [dic objectForKey:@"mytotalscore"]];
    NSMutableAttributedString *avrSearch = [[NSMutableAttributedString alloc] initWithString:avrString];
    NSRange sRange = [avrString rangeOfString:@"MY TOTAL SCORE : "];
    [avrSearch addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:sRange];
    [myTotalScoreText setAttributedText:avrSearch];
    
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

- (IBAction)homeButton:(id)sender {
    NSArray *backArray = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[backArray objectAtIndex:2] animated:YES];
}

- (IBAction)saveButton:(id)sender {
    
    NSLog(@"text : %@", coffeeFourTextView.text);
    NSString *ok;
    if (!mOkNotokflag){
        ok = @"Y";
    }else {
        ok = @"N";
    }
    
    if (!mOkNotokflag){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"OK/NOT OK 선택해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([@"" isEqualToString:[NSString stringWithFormat:@"%@", coffeeFourTextView.text]]) {
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

- (void) save:(NSString *)isok{
    NSString *urlString = [NSString stringWithFormat:@"%@", HALF_SAVE];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"id=%@&sample_idx=%@&note_total=%@&isok=%@", USER_ID, SAMPLE_IDX, [NSString stringWithFormat:@"%@", coffeeFourTextView.text] , isok];
    NSLog(@"원료커핑4 : %@", params);
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

- (IBAction)prevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)okButton:(id)sender {
    mOkNotokflag = YES;
    [mOkBtn setImage:[UIImage imageNamed:@"ok_on_button_330x80"] forState:UIControlStateNormal];
    [mNOTOKBtn setImage:[UIImage imageNamed:@"notok_off_button_330x80"] forState:UIControlStateNormal];
}

- (IBAction)notOkButton:(id)sender {
    mOkNotokflag = YES;
    [mOkBtn setImage:[UIImage imageNamed:@"ok_off_button_330x80.png"] forState:UIControlStateNormal];
    [mNOTOKBtn setImage:[UIImage imageNamed:@"notok_on_button_330x80"] forState:UIControlStateNormal];
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
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-4] animated:YES];
            return;
        }else{
                MPOSITION = buttonIndex;
        }
        
        [self firstInit ];
    }else{
        
    }
}

- (void) firstInit{
    NSLog(@"mPosition  : %ld" ,  MPOSITION);
    [self Step1];       //통신 1 구간
}

#pragma mark -
#pragma mark TextField

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSInteger textY = 0;
    if(textView == coffeeFourTextView){
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
    
    [coffeeFourTextView resignFirstResponder];
}

@end
