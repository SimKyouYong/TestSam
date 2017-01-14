//
//  CoffeeFirstVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 22..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CoffeeFirstVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface CoffeeFirstVC ()

@end

@implementation CoffeeFirstVC

@synthesize coffeeFirstTableView;
@synthesize aromaButton;
@synthesize flavorButton;
@synthesize acidityButton;
@synthesize noteTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    actionArr = [[NSMutableArray alloc] init];
    
    NSLog(@"SESSIONID   :: %@" , SESSIONID);
    NSLog(@"USER_ID     :: %@" , USER_ID);
    mPosition = 0;
    /*
    popupView = [[PopupView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    [self.view addSubview:popupView];
    popupView.hidden = YES;
    
    commonTableView = [[CommonTableView alloc] initWithFrame:CGRectMake(10, 100, WIDTH_FRAME - 20, HEIGHT_FRAME - 200)];
    commonTableView.delegate = self;
    commonTableView.backgroundColor = [UIColor whiteColor];
     
    //[self.view addSubview:commonTableView];
    
    //[self.view bringSubviewToFront:popupView];
    //s[self.view bringSubviewToFront:commonTableView];
     */
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
    [aromaButton setTitle:[dic objectForKey:@"aroma_point"] forState:UIControlStateNormal];
    [flavorButton setTitle:[dic objectForKey:@"flavor_point"] forState:UIControlStateNormal];
    [acidityButton setTitle:[dic objectForKey:@"acidity_point"] forState:UIControlStateNormal];
    
    noteTextView.text = [dic objectForKey:@"note1"];
    
    tableDic = dic;
    [self init3:dic];
    [coffeeFirstTableView reloadData];
}

// 테이블 셀 클릭하지않고 바로 저장눌렀을때를 대비함
- (void)init3:(NSDictionary*)dic{
    mTotalFloral = [dic objectForKey:@"floral"];
    mTotalFruity = [dic objectForKey:@"fruity"];
    mTotalAlcoholic = [dic objectForKey:@"alcoholic"];
    mTotalHerb = [dic objectForKey:@"herb"];
    mTotalSpice = [dic objectForKey:@"spice"];
    mTotalSweet = [dic objectForKey:@"sweet"];
    mTotalNut = [dic objectForKey:@"nut"];
    mTotalChocolate = [dic objectForKey:@"chocolate"];
    mTotalGrain = [dic objectForKey:@"grain"];
    mTotalRoast = [dic objectForKey:@"roast"];
    mTotalSavory = [dic objectForKey:@"savory"];
    
    mTotalFermented = [dic objectForKey:@"fermented"];
    mTotalChemical = [dic objectForKey:@"chemical"];
    mTotalGreen = [dic objectForKey:@"green"];
    mTotalMusty = [dic objectForKey:@"musty"];
    mTotalRoastdefect = [dic objectForKey:@"roastdefect"];
    
    mTotalAcidity_Po = [dic objectForKey:@"acidity_po"];
    mTotalAcidity_Ne = [dic objectForKey:@"acidity_ne"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"coffee2"])
    {
        
    }
    if ([[segue identifier] isEqualToString:@"coffeeTabPush"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)secondaryButton:(id)sender {
    [self performSegueWithIdentifier:@"coffee2" sender:sender];
}

- (IBAction)tertiaryButton:(id)sender {
    [self performSegueWithIdentifier:@"coffeeTabPush" sender:sender];
}

- (IBAction)saveButton:(id)sender {
    NSString *urlString = [NSString stringWithFormat:@"%@", CUPPING_SAVE];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"id=%@&sample_idx=%@&opt=1&aroma_point=%@&flavor_point=%@&acidity_point=%@&note1=%@&floral=%@&fruity=%@&alcoholic=%@&herb=%@&spice=%@&sweet=%@&nut=%@&chocolate=%@&grain=%@&roast=%@&savory=%@&fermented=%@&chemical=%@&green=%@&musty=%@&roastdefect=%@&acidity_po=%@&acidity_ne=%@", USER_ID, SAMPLE_IDX, aromaButton.titleLabel.text, flavorButton.titleLabel.text, acidityButton.titleLabel.text, noteTextView.text, mTotalFloral, mTotalFruity, mTotalAlcoholic, mTotalHerb, mTotalSpice, mTotalSweet, mTotalNut, mTotalChocolate, mTotalGrain, mTotalRoast, mTotalSavory, mTotalFermented, mTotalChemical, mTotalGreen, mTotalMusty, mTotalRoastdefect, mTotalAcidity_Po, mTotalAcidity_Ne];
    NSLog(@"원료커핑1 : %@", params);
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
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
                
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
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"저장에 실패 하였습니다." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];
}

- (IBAction)nextButton:(id)sender {
    [self performSegueWithIdentifier:@"coffee2" sender:sender];
}

- (IBAction)aromaButton:(id)sender {
    actionSheetNum = 1;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex1_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex1_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex1_step"] floatValue];
    
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
}

- (IBAction)flavorButton:(id)sender {
    actionSheetNum = 2;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex2_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex2_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex2_step"] floatValue];
    
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
}

- (IBAction)acidityButton:(id)sender {
    actionSheetNum = 3;
    
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
}

#pragma mark -
#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:coffeeFirstTableView.expandedContentIndexPath])
    {
        if(indexPath.row == 1
           ){
            return 560;
        }else if(indexPath.row == 2){
            return 260;
        }else if(indexPath.row == 3){
            return 110;
        }
        return 0.0f;
    }else{
        return 40.0f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return JNExpandableTableViewNumberOfRowsInSection((JNExpandableTableView *)tableView,section,3);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath * adjustedIndexPath = [coffeeFirstTableView adjustedIndexPathFromTable:indexPath];
    
    if ([coffeeFirstTableView.expandedContentIndexPath isEqual:indexPath])
    {
        if(indexPath.row == 1){
            static NSString *CellIdentifier = @"firstCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalFloral = (UILabel*)[cell viewWithTag:1];
            TotalFruity = (UILabel*)[cell viewWithTag:3];
            TotalAlcoholic = (UILabel*)[cell viewWithTag:5];
            TotalHerb = (UILabel*)[cell viewWithTag:7];
            TotalSpice = (UILabel*)[cell viewWithTag:9];
            TotalSweet = (UILabel*)[cell viewWithTag:11];
            TotalNut = (UILabel*)[cell viewWithTag:13];
            TotalChocolate = (UILabel*)[cell viewWithTag:15];
            TotalGrain = (UILabel*)[cell viewWithTag:17];
            TotalRoast = (UILabel*)[cell viewWithTag:19];
            TotalSavory = (UILabel*)[cell viewWithTag:21];
            
            TotalFloral.text = [tableDic objectForKey:@"floral"];
            TotalFruity.text = [tableDic objectForKey:@"fruity"];
            TotalAlcoholic.text = [tableDic objectForKey:@"alcoholic"];
            TotalHerb.text = [tableDic objectForKey:@"herb"];
            TotalSpice.text = [tableDic objectForKey:@"spice"];
            TotalSweet.text = [tableDic objectForKey:@"sweet"];
            TotalNut.text = [tableDic objectForKey:@"nut"];
            TotalChocolate.text = [tableDic objectForKey:@"chocolate"];
            TotalGrain.text = [tableDic objectForKey:@"grain"];
            TotalRoast.text = [tableDic objectForKey:@"roast"];
            TotalSavory.text = [tableDic objectForKey:@"savory"];
            
            return cell;
        }else if(indexPath.row == 2){
            static NSString *CellIdentifier = @"secondCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalFermented = (UILabel*)[cell viewWithTag:1];
            TotalChemical = (UILabel*)[cell viewWithTag:3];
            TotalGreen = (UILabel*)[cell viewWithTag:5];
            TotalMusty = (UILabel*)[cell viewWithTag:7];
            TotalRoastdefect = (UILabel*)[cell viewWithTag:9];
            
            TotalFermented.text = [tableDic objectForKey:@"fermented"];
            TotalChemical.text = [tableDic objectForKey:@"chemical"];
            TotalGreen.text = [tableDic objectForKey:@"green"];
            TotalMusty.text = [tableDic objectForKey:@"musty"];
            TotalRoastdefect.text = [tableDic objectForKey:@"roastdefect"];
            
            return cell;
        }else if(indexPath.row == 3){
            static NSString *CellIdentifier = @"thirdCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      
            TotalAcidity_Po = (UILabel*)[cell viewWithTag:1];
            TotalAcidity_Ne = (UILabel*)[cell viewWithTag:3];
            
            TotalAcidity_Po.text = [tableDic objectForKey:@"acidity_po"];
            TotalAcidity_Ne.text = [tableDic objectForKey:@"acidity_ne"];
            
            return cell;
        }
        
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if((long)adjustedIndexPath.row == 0){
            cell.textLabel.text = @"POSITIVE";
        }else if((long)adjustedIndexPath.row == 1){
            cell.textLabel.text = @"NEGATIVE";
        }else if((long)adjustedIndexPath.row == 2){
            cell.textLabel.text = @"ACIDITY";
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
    }
    
    return nil;
}

#pragma mark -
#pragma mark JNExpandableTableView Degate

- (BOOL)tableView:(JNExpandableTableView *)tableView canExpand:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(JNExpandableTableView *)tableView willExpand:(NSIndexPath *)indexPath
{
    //NSLog(@"Will Expand: %@",indexPath);
}

- (void)tableView:(JNExpandableTableView *)tableView willCollapse:(NSIndexPath *)indexPath
{
    //NSLog(@"Will Collapse: %@",indexPath);
}

#pragma mark -
#pragma mark CommonTableView Delegate

- (void)cancelButton{
    popupView.hidden = YES;
    commonTableView.hidden = YES;
}

- (void)submitButton:(NSString *)value{
    popupView.hidden = YES;
    commonTableView.hidden = YES;
}

#pragma mark -
#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([actionArr count] == buttonIndex){
        return;
    }
    
    if(actionSheetNum == 1){
        [aromaButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
    }else if(actionSheetNum == 2){
        [flavorButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
    }else if(actionSheetNum == 3){
        [acidityButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
    }
    
    actionArr = [[NSMutableArray alloc] init];
}

@end
