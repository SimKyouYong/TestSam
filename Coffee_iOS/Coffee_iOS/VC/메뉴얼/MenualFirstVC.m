//
//  MenualFirstVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "MenualFirstVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface MenualFirstVC ()

@end

@implementation MenualFirstVC

@synthesize menualFirstTableView;
@synthesize acidityButton;
@synthesize sweetnessButton;
@synthesize bitternessButton;
@synthesize bodyButton;
@synthesize aftertasteButton;
@synthesize noteTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    actionArr = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"menual2"])
    {
        
    }
    if ([[segue identifier] isEqualToString:@"menualTabPush"])
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
    NSString *params = [NSString stringWithFormat:@"id=%@&sample_idx=%@&opt=5&note5=%@&acidity_point=%@&sweetness_point=%@&bitterness_point=%@&body_point=%@&aftertaste_point=%@&floral=%@&fruity=%@&herb=%@&spice=%@&sweet=%@&nut=%@&chocolate=%@&grain=%@&roast=%@&savory=%@&fermented=%@&chemical=%@&green=%@&musty=%@&roastdefect=%@&acidity_po=%@&acidity_ne=%@&aftertaste_po=%@&aftertaste_ne=%@&body_light=%@&body_medium=%@&body_heavy=%@&balance_po=%@&balance_ne=%@&mouthfeel_po=%@&mouthfeel_ne=%@", USER_ID, SAMPLE_IDX, noteTextView.text, acidityButton.titleLabel.text, sweetnessButton.titleLabel.text, bitternessButton.titleLabel.text, bodyButton.titleLabel.text, aftertasteButton.titleLabel.text, mTotalFloral, mTotalFruity, mTotalHerb, mTotalSpice, mTotalSweet, mTotalNut, mTotalChocolate, mTotalGrain, mTotalRoast, mTotalSavory, mTotalFermented, mTotalChemical, mTotalGreen, mTotalMusty, mTotalRoastdefect, mTotalAcidity_Po, mTotalAcidity_Ne, mTotalAftertaste_Po, mTotalAftertaste_Ne, mTotalBody_Li, mTotalBody_Me, mTotalBody_He, mTotalBalance_Po, mTotalBalance_Ne, mTotalMouthfeel_Po, mTotalMouthfeel_Ne];
    NSLog(@"메뉴얼 아메리카노 : %@", params);
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
    [self performSegueWithIdentifier:@"menual2" sender:sender];
}

- (IBAction)latteButton:(id)sender {
    [self performSegueWithIdentifier:@"menualTabPush" sender:sender];
}

- (IBAction)acidityButton:(id)sender {
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
}

- (IBAction)sweetnessButton:(id)sender {
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
}

- (IBAction)bitternessButton:(id)sender {
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
}

- (IBAction)bodyButton:(id)sender {
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
}

- (IBAction)aftertasteButton:(id)sender {
    actionSheetNum = 5;
    
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
}

#pragma mark -
#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
        [aftertasteButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
    }
    
    actionArr = [[NSMutableArray alloc] init];
}

#pragma mark -
#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:menualFirstTableView.expandedContentIndexPath])
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
    
    NSIndexPath * adjustedIndexPath = [menualFirstTableView adjustedIndexPathFromTable:indexPath];
    
    if ([menualFirstTableView.expandedContentIndexPath isEqual:indexPath])
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
