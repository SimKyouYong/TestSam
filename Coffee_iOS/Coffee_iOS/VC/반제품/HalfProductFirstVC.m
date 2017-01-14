//
//  HalfProductFirstVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HalfProductFirstVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface HalfProductFirstVC ()

@end

@implementation HalfProductFirstVC

@synthesize halfFirstTableView;
@synthesize acidityButton;
@synthesize sweetnessButton;
@synthesize bitternessButton;
@synthesize bodyButton;
@synthesize balanceButton;
@synthesize aftertasteButton;
@synthesize poButton;
@synthesize neButton;
@synthesize noteTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SESSIONID   :: %@" , SESSIONID);
    NSLog(@"USER_ID     :: %@" , USER_ID);
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
    [acidityButton setTitle:[dic objectForKey:@"acidity_point"] forState:UIControlStateNormal];
    [sweetnessButton setTitle:[dic objectForKey:@"sweetness_point"] forState:UIControlStateNormal];
    [bitternessButton setTitle:[dic objectForKey:@"bitterness_point"] forState:UIControlStateNormal];
    [bodyButton setTitle:[dic objectForKey:@"body_point"] forState:UIControlStateNormal];
    [balanceButton setTitle:[dic objectForKey:@"balance_point"] forState:UIControlStateNormal];
    [aftertasteButton setTitle:[dic objectForKey:@"aftertaste_point"] forState:UIControlStateNormal];
    
    [poButton setTitle:[dic objectForKey:@"po_point"] forState:UIControlStateNormal];
    [neButton setTitle:[dic objectForKey:@"ne_point"] forState:UIControlStateNormal];
    
    noteTextView.text = [dic objectForKey:@"note4"];
    
    tableDic = dic;
    [self init3:dic];
    [halfFirstTableView reloadData];
}

// 테이블 셀 클릭하지않고 바로 저장눌렀을때를 대비함
- (void)init3:(NSDictionary*)dic{
    mTotalFloral = [dic objectForKey:@"floral"];
    mTotalFruity = [dic objectForKey:@"fruity"];
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
    
    mTotalAftertaste_Po = [dic objectForKey:@"aftertaste_po"];
    mTotalAftertaste_Ne = [dic objectForKey:@"aftertaste_ne"];
    
    mTotalBody_Li = [dic objectForKey:@"body_light"];
    mTotalBody_Me = [dic objectForKey:@"body_medium"];
    mTotalBody_He = [dic objectForKey:@"body_heavy"];

    mTotalBalance_Po = [dic objectForKey:@"balance_po"];
    mTotalBalance_Ne = [dic objectForKey:@"balance_ne"];
    
    mTotalMouthfeel_Po = [dic objectForKey:@"mouthfeel_po"];
    mTotalMouthfeel_Ne = [dic objectForKey:@"mouthfeel_ne"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"product2"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButton:(id)sender {
    NSString *urlString = [NSString stringWithFormat:@"%@", CUPPING_SAVE];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"id=%@&sample_idx=%@&opt=4&note4=%@&acidity_point=%@&sweetness_point=%@&bitterness_point=%@&body_point=%@&balance_point=%@&aftertaste_point=%@&po_point=%@&ne_point=%@&floral=%@&fruity=%@&herb=%@&spice=%@&sweet=%@&nut=%@&chocolate=%@&grain=%@&roast=%@&savory=%@&fermented=%@&chemical=%@&green=%@&musty=%@&roastdefect=%@&acidity_po=%@&acidity_ne=%@&aftertaste_po=%@&aftertaste_ne=%@&body_light=%@&body_medium=%@&body_heavy=%@&balance_po=%@&balance_ne=%@&mouthfeel_po=%@&mouthfeel_ne=%@", USER_ID, SAMPLE_IDX, noteTextView.text, acidityButton.titleLabel.text, sweetnessButton.titleLabel.text, bitternessButton.titleLabel.text, bodyButton.titleLabel.text, balanceButton.titleLabel.text, aftertasteButton.titleLabel.text, poButton.titleLabel.text, neButton.titleLabel.text, mTotalFloral, mTotalFruity, mTotalHerb, mTotalSpice, mTotalSweet, mTotalNut, mTotalChocolate, mTotalGrain, mTotalRoast, mTotalSavory, mTotalFermented, mTotalChemical, mTotalGreen, mTotalMusty, mTotalRoastdefect, mTotalAcidity_Po, mTotalAcidity_Ne, mTotalAftertaste_Po, mTotalAftertaste_Ne, mTotalBody_Li, mTotalBody_Me, mTotalBody_He, mTotalBalance_Po, mTotalBalance_Ne, mTotalMouthfeel_Po, mTotalMouthfeel_Ne];
    NSLog(@"반제품1 : %@", params);
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            NSLog(@"resultValue : %@"  , resultValue);
            if([[dic objectForKey:@"result"] isEqualToString:@"fail"]){
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                
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
    [self performSegueWithIdentifier:@"product2" sender:sender];
}

- (IBAction)acidityButton:(id)sender {
    [self actionSheetInit:0];
}

- (IBAction)sweetnessButton:(id)sender {
    [self actionSheetInit:1];
}

- (IBAction)bitternessButton:(id)sender {
    [self actionSheetInit:2];
}

- (IBAction)bodyButton:(id)sender {
    [self actionSheetInit:3];
}

- (IBAction)balanceButton:(id)sender {
    [self actionSheetInit:4];
}

- (IBAction)aftertasteButton:(id)sender {
    [self actionSheetInit:5];
}

- (IBAction)poButton:(id)sender {
    [self actionSheetInit:6];
}

- (IBAction)neButton:(id)sender {
    [self actionSheetInit:7];
}

#pragma mark -
#pragma mark ActionSheet Value Setting

- (void)actionSheetInit:(NSInteger)indexNum{
    actionSheetSettingValue = indexNum;
    
    numberArr = [NSArray arrayWithObjects: @"0.0",@"0.5",@"1.0",@"1.5",@"2.0",@"2.5",@"3.0",@"3.5",@"4.0",@"4.5",@"5.0", nil];

    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"색상을 선택해주세요.";
    menu.delegate = self;

    for(int i = 0; i < [numberArr count]; i++){
        [menu addButtonWithTitle:[numberArr objectAtIndex:i]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(6 == buttonIndex){
        return;
    }
    
    switch (actionSheetSettingValue) {
        case 0:
            [acidityButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 1:
            [sweetnessButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 2:
            [bitternessButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 3:
            [bodyButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 4:
            [balanceButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 5:
            [aftertasteButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 6:
            [poButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 7:
            [neButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:halfFirstTableView.expandedContentIndexPath])
    {
        if(indexPath.row == 1){
            return 510;
        }else if(indexPath.row == 2){
            return 260;
        }else if(indexPath.row == 3){
            return 110;
        }else if(indexPath.row == 4){
            return 110;
        }else if(indexPath.row == 5){
            return 160;
        }else if(indexPath.row == 6){
            return 110;
        }else if(indexPath.row == 7){
            return 110;
        }
        return 0.0f;
    }else{
        return 40.0f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return JNExpandableTableViewNumberOfRowsInSection((JNExpandableTableView *)tableView,section,7);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath * adjustedIndexPath = [halfFirstTableView adjustedIndexPathFromTable:indexPath];
    
    if ([halfFirstTableView.expandedContentIndexPath isEqual:indexPath])
    {
        if(indexPath.row == 1){
            static NSString *CellIdentifier = @"firstCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalFloral = (UILabel*)[cell viewWithTag:1];
            TotalFruity = (UILabel*)[cell viewWithTag:3];
            TotalHerb = (UILabel*)[cell viewWithTag:5];
            TotalSpice = (UILabel*)[cell viewWithTag:7];
            TotalSweet = (UILabel*)[cell viewWithTag:9];
            TotalNut = (UILabel*)[cell viewWithTag:11];
            TotalChocolate = (UILabel*)[cell viewWithTag:13];
            TotalGrain = (UILabel*)[cell viewWithTag:15];
            TotalRoast = (UILabel*)[cell viewWithTag:17];
            TotalSavory = (UILabel*)[cell viewWithTag:29];
            
            TotalFloral.text = [tableDic objectForKey:@"floral"];
            TotalFruity.text = [tableDic objectForKey:@"fruity"];
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
        }else if(indexPath.row == 4){
            static NSString *CellIdentifier = @"fourCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalAftertaste_Po = (UILabel*)[cell viewWithTag:1];
            TotalAftertaste_Ne = (UILabel*)[cell viewWithTag:3];
            
            TotalAftertaste_Po.text = [tableDic objectForKey:@"aftertaste_po"];
            TotalAftertaste_Ne.text = [tableDic objectForKey:@"aftertaste_ne"];
            
            return cell;
        }else if(indexPath.row == 5){
            static NSString *CellIdentifier = @"fiveCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalBody_Li = (UILabel*)[cell viewWithTag:1];
            TotalBody_Me = (UILabel*)[cell viewWithTag:3];
            TotalBody_He = (UILabel*)[cell viewWithTag:5];
            
            TotalBody_Li.text = [tableDic objectForKey:@"body_light"];
            TotalBody_Me.text = [tableDic objectForKey:@"body_medium"];
            TotalBody_He.text = [tableDic objectForKey:@"body_heavy"];
         
            return cell;
        }else if(indexPath.row == 6){
            static NSString *CellIdentifier = @"sixCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalBalance_Po = (UILabel*)[cell viewWithTag:1];
            TotalBalance_Ne = (UILabel*)[cell viewWithTag:3];
            
            TotalBalance_Po.text = [tableDic objectForKey:@"balance_po"];
            TotalBalance_Ne.text = [tableDic objectForKey:@"balance_ne"];
        
            return cell;
        }else if(indexPath.row == 7){
            static NSString *CellIdentifier = @"sevenCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalMouthfeel_Po = (UILabel*)[cell viewWithTag:1];
            TotalMouthfeel_Ne = (UILabel*)[cell viewWithTag:3];
            
            TotalMouthfeel_Po.text = [tableDic objectForKey:@"mouthfeel_po"];
            TotalMouthfeel_Ne.text = [tableDic objectForKey:@"mouthfeel_ne"];
           
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
        }else if((long)adjustedIndexPath.row == 3){
            cell.textLabel.text = @"AFTERTASTE";
        }else if((long)adjustedIndexPath.row == 4){
            cell.textLabel.text = @"BODY";
        }else if((long)adjustedIndexPath.row == 5){
            cell.textLabel.text = @"BALANCE";
        }else if((long)adjustedIndexPath.row == 6){
            cell.textLabel.text = @"MOUTHFEEL";
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
    NSLog(@"Will Expand: %@",indexPath);
}

- (void)tableView:(JNExpandableTableView *)tableView willCollapse:(NSIndexPath *)indexPath
{
    NSLog(@"Will Collapse: %@",indexPath);
}

@end
