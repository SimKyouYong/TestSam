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
#import "PopupListViewCoffee.h"
#import "PopupListCoffee.h"

@interface MenualFirstVC () <PopupListViewDelegate>
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexes;
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
    
    popupView = [[PopupView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    [self.view addSubview:popupView];
    popupView.hidden = YES;
    
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
    NSArray *backArray = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[backArray objectAtIndex:2] animated:YES];
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
    if(actionSheetNum == 9){
        if(buttonIndex == 9){
        }else{
            [self TotalFruity2:buttonIndex];
        }
        return;
    }
    if(actionSheetNum == 10){
        if(buttonIndex == 5){
        }else{
            [self TotalChemical2:buttonIndex];
        }
        return;
    }
    
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
            UIButton *TotalFloralButton = (UIButton*)[cell viewWithTag:2];
            
            TotalFruity = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalFruityButton = (UIButton*)[cell viewWithTag:4];
            
            TotalHerb = (UILabel*)[cell viewWithTag:5];
            UIButton *TotalHerbButton = (UIButton*)[cell viewWithTag:6];
            
            TotalSpice = (UILabel*)[cell viewWithTag:7];
            UIButton *TotalSpiceButton = (UIButton*)[cell viewWithTag:8];
            
            TotalSweet = (UILabel*)[cell viewWithTag:9];
            UIButton *TotalSweetButton = (UIButton*)[cell viewWithTag:10];
            
            TotalNut = (UILabel*)[cell viewWithTag:11];
            UIButton *TotalNutButton = (UIButton*)[cell viewWithTag:12];
            
            TotalChocolate = (UILabel*)[cell viewWithTag:13];
            UIButton *TotalChocolateButton = (UIButton*)[cell viewWithTag:14];
            
            TotalGrain = (UILabel*)[cell viewWithTag:15];
            UIButton *TotalGrainButton = (UIButton*)[cell viewWithTag:16];
            
            TotalRoast = (UILabel*)[cell viewWithTag:17];
            UIButton *TotalRoastButton = (UIButton*)[cell viewWithTag:18];
            
            TotalSavory = (UILabel*)[cell viewWithTag:19];
            UIButton *TotalSavoryButton = (UIButton*)[cell viewWithTag:20];
            
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
            
            [TotalFruityButton addTarget:self action:@selector(TotalFruityAction:) forControlEvents:UIControlEventTouchUpInside];
            
            TotalFloralButton.tag = 0;
            [TotalFloralButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalHerbButton.tag = 2;
            [TotalHerbButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalSpiceButton.tag = 3;
            [TotalSpiceButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalSweetButton.tag = 4;
            [TotalSweetButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalNutButton.tag = 5;
            [TotalNutButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalChocolateButton.tag = 6;
            [TotalChocolateButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalGrainButton.tag = 7;
            [TotalGrainButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalRoastButton.tag = 8;
            [TotalRoastButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalSavoryButton.tag = 9;
            [TotalSavoryButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if(indexPath.row == 2){
            static NSString *CellIdentifier = @"secondCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalFermented = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalFermentedButton = (UIButton*)[cell viewWithTag:2];
            
            TotalChemical = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalChemicalButton = (UIButton*)[cell viewWithTag:4];
            
            TotalGreen = (UILabel*)[cell viewWithTag:5];
            UIButton *TotalGreenButton = (UIButton*)[cell viewWithTag:6];
            
            TotalMusty = (UILabel*)[cell viewWithTag:7];
            UIButton *TotalMustyButton = (UIButton*)[cell viewWithTag:8];
            
            TotalRoastdefect = (UILabel*)[cell viewWithTag:9];
            UIButton *TotalRoastdefectButton = (UIButton*)[cell viewWithTag:10];
            
            TotalFermented.text = [tableDic objectForKey:@"fermented"];
            TotalChemical.text = [tableDic objectForKey:@"chemical"];
            TotalGreen.text = [tableDic objectForKey:@"green"];
            TotalMusty.text = [tableDic objectForKey:@"musty"];
            TotalRoastdefect.text = [tableDic objectForKey:@"roastdefect"];
            
            [TotalChemicalButton addTarget:self action:@selector(TotalChemicalAction:) forControlEvents:UIControlEventTouchUpInside];
            
            TotalFermentedButton.tag = 10;
            [TotalFermentedButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalGreenButton.tag = 11;
            [TotalGreenButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalMustyButton.tag = 12;
            [TotalMustyButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalRoastdefectButton.tag = 13;
            [TotalRoastdefectButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if(indexPath.row == 3){
            static NSString *CellIdentifier = @"thirdCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalAcidity_Po = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalAcidity_PoButton = (UIButton*)[cell viewWithTag:2];
            
            TotalAcidity_Ne = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalAcidity_NeButton = (UIButton*)[cell viewWithTag:4];
            
            TotalAcidity_Po.text = [tableDic objectForKey:@"acidity_po"];
            TotalAcidity_Ne.text = [tableDic objectForKey:@"acidity_ne"];
            
            TotalAcidity_PoButton.tag = 14;
            [TotalAcidity_PoButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalAcidity_NeButton.tag = 15;
            [TotalAcidity_NeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if(indexPath.row == 4){
            static NSString *CellIdentifier = @"fourCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalAftertaste_Po = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalAftertaste_PoButton = (UIButton*)[cell viewWithTag:2];
            
            TotalAftertaste_Ne = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalAftertaste_NeButton = (UIButton*)[cell viewWithTag:4];
            
            TotalAftertaste_Po.text = [tableDic objectForKey:@"aftertaste_po"];
            TotalAftertaste_Ne.text = [tableDic objectForKey:@"aftertaste_ne"];
            
            TotalAftertaste_PoButton.tag = 16;
            [TotalAftertaste_PoButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalAftertaste_NeButton.tag = 17;
            [TotalAftertaste_NeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if(indexPath.row == 5){
            static NSString *CellIdentifier = @"fiveCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalBody_Li = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalBody_LiButton = (UIButton*)[cell viewWithTag:2];
            
            TotalBody_Me = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalBody_MeButton = (UIButton*)[cell viewWithTag:4];
            
            TotalBody_He = (UILabel*)[cell viewWithTag:5];
            UIButton *TotalBody_HeButton = (UIButton*)[cell viewWithTag:6];
            
            TotalBody_Li.text = [tableDic objectForKey:@"body_light"];
            TotalBody_Me.text = [tableDic objectForKey:@"body_medium"];
            TotalBody_He.text = [tableDic objectForKey:@"body_heavy"];
            
            TotalBody_LiButton.tag = 18;
            [TotalBody_LiButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalBody_MeButton.tag = 19;
            [TotalBody_MeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalBody_HeButton.tag = 20;
            [TotalBody_HeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if(indexPath.row == 6){
            static NSString *CellIdentifier = @"sixCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalBalance_Po = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalBalance_PoButton = (UIButton*)[cell viewWithTag:2];
            
            TotalBalance_Ne = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalBalance_NeButton = (UIButton*)[cell viewWithTag:4];
            
            TotalBalance_Po.text = [tableDic objectForKey:@"balance_po"];
            TotalBalance_Ne.text = [tableDic objectForKey:@"balance_ne"];
            
            TotalBalance_PoButton.tag = 21;
            [TotalBalance_PoButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalBalance_NeButton.tag = 22;
            [TotalBalance_NeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if(indexPath.row == 7){
            static NSString *CellIdentifier = @"sevenCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalMouthfeel_Po = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalMouthfeel_PoButton = (UIButton*)[cell viewWithTag:2];
            
            TotalMouthfeel_Ne = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalMouthfeel_NeButton = (UIButton*)[cell viewWithTag:4];
            
            TotalMouthfeel_Po.text = [tableDic objectForKey:@"mouthfeel_po"];
            TotalMouthfeel_Ne.text = [tableDic objectForKey:@"mouthfeel_ne"];
            
            TotalMouthfeel_PoButton.tag = 23;
            [TotalMouthfeel_PoButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalMouthfeel_NeButton.tag = 24;
            [TotalMouthfeel_NeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
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

#pragma mark -
#pragma mark Cell Button Method

- (void)ToTalCommonAction:(UIButton*)sender{
    NSString *dataStr;
    NSString *valueStr;
    NSInteger nIndex = sender.tag;
    
    switch (nIndex){
        case 0:
            dataStr = @"Floral";
            valueStr = mTotalFloral;
            break;
        case 2:
            dataStr = @"Herb/Vegetative";
            valueStr = mTotalHerb;
            break;
        case 3:
            dataStr = @"Spice";
            valueStr = mTotalSpice;
            break;
        case 4:
            dataStr = @"Sweet";
            valueStr = mTotalSweet;
            break;
        case 5:
            dataStr = @"Nut";
            valueStr = mTotalNut;
            break;
        case 6:
            dataStr = @"Chocolate";
            valueStr = mTotalChocolate;
            break;
        case 7:
            dataStr = @"Grain/Cereal";
            valueStr = mTotalGrain;
            break;
        case 8:
            dataStr = @"Roast";
            valueStr = mTotalRoast;
            break;
        case 9:
            dataStr = @"Savory";
            valueStr = mTotalSavory;
            break;
        case 10:
            dataStr = @"fermented";
            valueStr = mTotalFermented;
            break;
        case 11:
            dataStr = @"Green/grassy";
            valueStr = mTotalGreen;
            break;
        case 12:
            dataStr = @"musty";
            valueStr = mTotalMusty;
            break;
        case 13:
            dataStr = @"Roast Defect";
            valueStr = mTotalRoast;
            break;
        case 14:
            dataStr = @"Acidity_Po";
            valueStr = mTotalAcidity_Po;
            break;
        case 15:
            dataStr = @"Acidity_Ne";
            valueStr = mTotalAcidity_Ne;
            break;
        case 16:
            dataStr = @"Aftertaste_Po";
            valueStr = mTotalAftertaste_Po;
            break;
        case 17:
            dataStr = @"Aftertaste_Ne";
            valueStr = mTotalAftertaste_Ne;
            break;
        case 18:
            dataStr = @"Body_Light";
            valueStr = mTotalBody_Li;
            break;
        case 19:
            dataStr = @"Body_Medium";
            valueStr = mTotalBody_Me;
            break;
        case 20:
            dataStr = @"Body_Heavy";
            valueStr = mTotalBody_He;
            break;
        case 21:
            dataStr = @"Balance_Po";
            valueStr = mTotalBalance_Po;
            break;
        case 22:
            dataStr = @"Balance_Ne";
            valueStr = mTotalBalance_Ne;
            break;
        case 23:
            dataStr = @"Mouthfeel_Po";
            valueStr = mTotalMouthfeel_Po;
            break;
        case 24:
            dataStr = @"Mouthfeel_Ne";
            valueStr = mTotalMouthfeel_Ne;
            break;
    }
    
    [self popupLoad:dataStr];
}

- (void)TotalFruityAction:(UIButton*)sender{
    actionSheetNum = 9;
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"중분류를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:@"Fruity"];
    [menu addButtonWithTitle:@"citrus"];
    [menu addButtonWithTitle:@"apple"];
    [menu addButtonWithTitle:@"melon"];
    [menu addButtonWithTitle:@"tropical fruit"];
    [menu addButtonWithTitle:@"stone fruit"];
    [menu addButtonWithTitle:@"berry"];
    [menu addButtonWithTitle:@"grape/wine"];
    [menu addButtonWithTitle:@"dried fruit"];
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

- (void)TotalFruity2:(NSInteger)indexNum{
    NSString *dataStr;
    
    switch (indexNum){
        case 0:
            dataStr = @"Fruity";
            break;
        case 1:
            dataStr = @"citrus";
            break;
        case 2:
            dataStr = @"apple";
            break;
        case 3:
            dataStr = @"melon";
            break;
        case 4:
            dataStr = @"tropical fruit";
            break;
        case 5:
            dataStr = @"stone fruit";
            break;
        case 6:
            dataStr = @"berry";
            break;
        case 7:
            dataStr = @"grape/wine";
            break;
        case 8:
            dataStr = @"dried fruit";
            break;
    }
    
    [self popupLoad:dataStr];
}

- (void)TotalChemicalAction:(UIButton*)sender{
    actionSheetNum = 10;
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"중분류를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:@"chemical"];
    [menu addButtonWithTitle:@"phenolic"];
    [menu addButtonWithTitle:@"ashy"];
    [menu addButtonWithTitle:@"rubbery"];
    [menu addButtonWithTitle:@"rest metal(녹슨쇠)"];
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

- (void)TotalChemical2:(NSInteger)indexNum{
    NSString *dataStr;
    
    switch (indexNum){
        case 0:
            dataStr = @"chemical";
            break;
        case 1:
            dataStr = @"phenolic";
            break;
        case 2:
            dataStr = @"ashy";
            break;
        case 3:
            dataStr = @"rubbery";
            break;
        case 4:
            dataStr = @"rest metal(녹슨쇠)";
            break;
    }
    
    [self popupLoad:dataStr];
}

#pragma mark -
#pragma mark PopupListViewDelegate

- (void)popupLoad:(NSString*)nameValue{
    popupView.hidden = NO;
    self.selectedIndexes = [[NSMutableIndexSet alloc] init];
    listArr = [[NSMutableArray alloc] init];
    listArr = [PopupListCoffee list:nameValue];
    
    float paddingTopBottom = 20.0f;
    float paddingLeftRight = 20.0f;
    
    CGPoint point = CGPointMake(paddingLeftRight, (self.navigationController.navigationBar.frame.size.height + paddingTopBottom) + paddingTopBottom);
    CGSize size = CGSizeMake((self.view.frame.size.width - (paddingLeftRight * 2)), self.view.frame.size.height - ((self.navigationController.navigationBar.frame.size.height + paddingTopBottom) + (paddingTopBottom * 2)));
    
    PopupListViewCoffee *listView = [[PopupListViewCoffee alloc] initWithTitle:@"평가해주세요." list:listArr selectedIndexes:self.selectedIndexes point:point size:size multipleSelection:YES disableBackgroundInteraction:YES dataName:nameValue];
    listView.delegate = self;
    
    [listView showInView:self.navigationController.view animated:YES];
}

- (void)popupListView:(PopupListViewCoffee *)popUpListView didSelectIndex:(NSInteger)index
{
    NSLog(@"popUpListView - didSelectIndex: %ld", index);
}

- (void)popupListViewDidHide:(PopupListViewCoffee *)popUpListView selectedIndexes:(NSIndexSet *)selectedIndexes dataNameStr:(NSString *)dataNameStr
{
    NSMutableArray *totalArr = [[NSMutableArray alloc] init];
    NSLog(@"popupListViewDidHide - selectedIndexes: %@", selectedIndexes.description);
    
    popupView.hidden = YES;
    self.selectedIndexes = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
    
    [selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [totalArr addObject:[NSString stringWithFormat:@"%ld", idx]];
    }];
    
    NSMutableString *gidNumStr = [NSMutableString string];
    for(int i = 0; i < [totalArr count]; i++){
        NSString *gidNum = [listArr objectAtIndex:[[totalArr objectAtIndex:i] integerValue]];
        
        [gidNumStr length] != 0 ?
        [gidNumStr appendFormat:@",%@", gidNum] : [gidNumStr appendFormat:@"%@", gidNum];
    }
    
    //NSLog(@"gidNum : %@", gidNumStr);
    
    [self submitButton:gidNumStr name:dataNameStr];
}

- (void)submitButton:(NSString *)value name:(NSString *)name{
    if([name isEqualToString:@"Floral"]){
        TotalFloral.text = value;
        mTotalFloral = value;
        
    }else if([name isEqualToString:@"Fruity"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"citrus"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"apple"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"melon"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"tropical fruit"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"stone fruit"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"berry"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"grape/wine"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"dried fruit"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"Herb/Vegetative"]){
        TotalHerb.text = value;
        mTotalHerb = value;
        
    }else if([name isEqualToString:@"Spice"]){
        TotalSpice.text = value;
        mTotalSpice = value;
        
    }else if([name isEqualToString:@"Sweet"]){
        TotalSweet.text = value;
        mTotalSweet = value;
        
    }else if([name isEqualToString:@"Nut"]){
        TotalNut.text = value;
        mTotalNut = value;
        
    }else if([name isEqualToString:@"Chocolate"]){
        TotalChocolate.text = value;
        mTotalChocolate = value;
        
    }else if([name isEqualToString:@"Grain/Cereal"]){
        TotalGrain.text = value;
        mTotalGrain = value;
        
    }else if([name isEqualToString:@"Roast"]){
        TotalRoast.text = value;
        mTotalRoast = value;
        
    }else if([name isEqualToString:@"Savory"]){
        TotalSavory.text = value;
        mTotalSavory = value;
        
    }else if([name isEqualToString:@"fermented"]){
        TotalFermented.text = value;
        mTotalFermented = value;
        
    }else if([name isEqualToString:@"chemical"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"phenolic"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"ashy"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"rubbery"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"rest metal(녹슨쇠)"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"Green/grassy"]){
        TotalGreen.text = value;
        mTotalGreen = value;
        
    }else if([name isEqualToString:@"musty"]){
        TotalMusty.text = value;
        mTotalMusty = value;
        
    }else if([name isEqualToString:@"Roast Defect"]){
        TotalRoastdefect.text = value;
        mTotalRoastdefect = value;
        
    }else if([name isEqualToString:@"Acidity_Po"]){
        TotalAcidity_Po.text = value;
        mTotalAcidity_Po = value;
        
    }else if([name isEqualToString:@"Acidity_Ne"]){
        TotalAcidity_Ne.text = value;
        mTotalAcidity_Ne = value;
        
    }else if([name isEqualToString:@"Aftertaste_Po"]){
        TotalAftertaste_Po.text = value;
        mTotalAftertaste_Po = value;
        
    }else if([name isEqualToString:@"Aftertaste_Ne"]){
        TotalAftertaste_Ne.text = value;
        mTotalAftertaste_Ne = value;
        
    }else if([name isEqualToString:@"Body_Light"]){
        TotalBody_Li.text = value;
        mTotalBody_Li = value;
        
    }else if([name isEqualToString:@"Body_Medium"]){
        TotalBody_Me.text = value;
        mTotalBody_Me = value;
        
    }else if([name isEqualToString:@"Body_Heavy"]){
        TotalBody_He.text = value;
        mTotalBody_He = value;
        
    }else if([name isEqualToString:@"Balance_Po"]){
        TotalBalance_Po.text = value;
        mTotalBalance_Po = value;
        
    }else if([name isEqualToString:@"Balance_Ne"]){
        TotalBalance_Ne.text = value;
        mTotalBalance_Ne = value;
        
    }else if([name isEqualToString:@"Mouthfeel_Po"]){
        TotalMouthfeel_Po.text = value;
        mTotalMouthfeel_Po = value;
        
    }else if([name isEqualToString:@"Mouthfeel_Ne"]){
        TotalMouthfeel_Ne.text = value;
        mTotalMouthfeel_Ne = value;
    }
}

@end
