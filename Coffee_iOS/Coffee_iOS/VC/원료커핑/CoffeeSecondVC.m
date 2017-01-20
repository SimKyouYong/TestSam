//
//  CoffeeSecondVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CoffeeSecondVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "PopupListViewCoffee.h"
#import "PopupListCoffee.h"

@interface CoffeeSecondVC () <PopupListViewDelegate>
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexes;
@end

@implementation CoffeeSecondVC

@synthesize coffeeSecondTableView;
@synthesize aftertasteButton;
@synthesize bodyButton;
@synthesize balanceButton;
@synthesize overallButton;
@synthesize noteTextView;
@synthesize toptitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"완료" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar setItems:[NSArray arrayWithObjects:leftSpace, done, nil]];
    [toolbar sizeToFit];
    
    [noteTextView setInputAccessoryView:toolbar];
    
    popupView = [[PopupView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    [self.view addSubview:popupView];
    popupView.hidden = YES;
    
    actionArr = [[NSMutableArray alloc] init];
    toptitle.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton)];
    [toptitle addGestureRecognizer:tapGesture];

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
            //Title 값 셋팅
            toptitle.text = [NSString stringWithFormat:@"원료커핑:%@(%@/%@)",
                             [[datas objectAtIndex:mPosition] valueForKey:@"sample_code"],
                             [[datas objectAtIndex:mPosition] valueForKey:@"num"],
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
    [aftertasteButton setTitle:[dic objectForKey:@"aftertaste_point"] forState:UIControlStateNormal];
    [bodyButton setTitle:[dic objectForKey:@"body_point"] forState:UIControlStateNormal];
    [balanceButton setTitle:[dic objectForKey:@"balance_point"] forState:UIControlStateNormal];
    [overallButton setTitle:[dic objectForKey:@"overall_point"] forState:UIControlStateNormal];
    
    noteTextView.text = [dic objectForKey:@"note2"];
    
    tableDic = dic;
    [self init3:dic];
    [coffeeSecondTableView reloadData];
}

// 테이블 셀 클릭하지않고 바로 저장눌렀을때를 대비함
- (void)init3:(NSDictionary*)dic{
    mTotalAftertaste_Po = [dic objectForKey:@"aftertaste_po"];
    mTotalAftertaste_Ne = [dic objectForKey:@"aftertaste_ne"];
    
    mTotalBody_Li = [dic objectForKey:@"body_light"];
    mTotalBody_Me = [dic objectForKey:@"body_medium"];
    mTotalBody_He = [dic objectForKey:@"body_heavy"];
    
    mTotalBalance_Po = [dic objectForKey:@"balance_po"];
    mTotalBalance_Ne = [dic objectForKey:@"balance_ne"];
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
    if ([[segue identifier] isEqualToString:@"coffee3"])
    {
        
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
    if ([indexPath isEqual:coffeeSecondTableView.expandedContentIndexPath])
    {
        if(indexPath.row == 1){
            return 110;
        }else if(indexPath.row == 2){
            return 160;
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
    
    NSIndexPath * adjustedIndexPath = [coffeeSecondTableView adjustedIndexPathFromTable:indexPath];
    
    if ([coffeeSecondTableView.expandedContentIndexPath isEqual:indexPath])
    {
        if(indexPath.row == 1){
            static NSString *CellIdentifier = @"firstCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalAftertaste_Po = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalAftertaste_PoButton = (UIButton*)[cell viewWithTag:2];
            
            TotalAftertaste_Ne = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalAftertaste_NeButton = (UIButton*)[cell viewWithTag:4];
            
            TotalAftertaste_Po.text = [tableDic objectForKey:@"aftertaste_po"];
            TotalAftertaste_Ne.text = [tableDic objectForKey:@"aftertaste_ne"];
            
            TotalAftertaste_PoButton.tag = 0;
            [TotalAftertaste_PoButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalAftertaste_NeButton.tag = 1;
            [TotalAftertaste_NeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if(indexPath.row == 2){
            static NSString *CellIdentifier = @"secondCell";
            
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
            
            TotalBody_LiButton.tag = 2;
            [TotalBody_LiButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalBody_MeButton.tag = 3;
            [TotalBody_MeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalBody_HeButton.tag = 4;
            [TotalBody_HeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else if(indexPath.row == 3){
            static NSString *CellIdentifier = @"thirdCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            TotalBalance_Po = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalBalance_PoButton = (UIButton*)[cell viewWithTag:2];
            
            TotalBalance_Ne = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalBalance_NeButton = (UIButton*)[cell viewWithTag:4];
            
            TotalBalance_Po.text = [tableDic objectForKey:@"balance_po"];
            TotalBalance_Ne.text = [tableDic objectForKey:@"balance_ne"];
            
            TotalBalance_PoButton.tag = 5;
            [TotalBalance_PoButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalBalance_NeButton.tag = 6;
            [TotalBalance_NeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
        
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if((long)adjustedIndexPath.row == 0){
            cell.textLabel.text = @"AFTERTASTE";
        }else if((long)adjustedIndexPath.row == 1){
            cell.textLabel.text = @"BODY";
        }else if((long)adjustedIndexPath.row == 2){
            cell.textLabel.text = @"BALANCE";
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
    NSString *params = [NSString stringWithFormat:@"id=%@&sample_idx=%@&opt=2&aftertaste_point=%@&body_point=%@&balance_point=%@&overall_point=%@&note2=%@&aftertaste_po=%@&aftertaste_ne=%@&body_light=%@&body_medium=%@&body_heavy=%@&balance_po=%@&balance_ne=%@", USER_ID, SAMPLE_IDX, aftertasteButton.titleLabel.text, bodyButton.titleLabel.text, balanceButton.titleLabel.text, overallButton.titleLabel.text, noteTextView.text, mTotalAftertaste_Po, mTotalAftertaste_Ne, mTotalBody_Li, mTotalBody_Me, mTotalBody_He, mTotalBalance_Po, mTotalBalance_Ne];
    NSLog(@"원료커핑2 : %@", params);
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

- (IBAction)prevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    [self performSegueWithIdentifier:@"coffee3" sender:sender];
}

- (IBAction)pimaryButton:(id)sender {
}

- (IBAction)tertiaryButton:(id)sender {
    [self performSegueWithIdentifier:@"coffee3" sender:sender];
}

- (IBAction)aftertasteButton:(id)sender {
    actionSheetNum = 1;
    
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

- (IBAction)bodyButton:(id)sender {
    actionSheetNum = 2;
    
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

- (IBAction)balanceButton:(id)sender {
    actionSheetNum = 3;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex6_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex6_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex6_step"] floatValue];
    
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

- (IBAction)overallButton:(id)sender {
    actionSheetNum = 4;
    
    NSDictionary *dic = [datas objectAtIndex:0];
    
    float startNum = [[dic objectForKey:@"ex10_start"] floatValue];
    float endNum = [[dic objectForKey:@"ex10_end"] floatValue];
    float stepNum = [[dic objectForKey:@"ex10_step"] floatValue];
    
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
#pragma ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        if([datas count] == buttonIndex){
            return;
        }
        mPosition = buttonIndex;
        [self firstInit ];
    }else{
        if([actionArr count] == buttonIndex){
            return;
        }
        
        if(actionSheetNum == 1){
            [aftertasteButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 2){
            [bodyButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 3){
            [balanceButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 4){
            [overallButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }
        
        actionArr = [[NSMutableArray alloc] init];
    }
}

#pragma mark -
#pragma mark Cell Button Method

- (void)ToTalCommonAction:(UIButton*)sender{
    NSString *dataStr;
    NSString *valueStr;
    NSInteger nIndex = sender.tag;
    
    switch (nIndex){
        case 0:
            dataStr = @"Aftertaste_Po";
            valueStr = mTotalAftertaste_Po;
            break;
        case 1:
            dataStr = @"Aftertaste_Ne";
            valueStr = mTotalAftertaste_Ne;
        case 2:
            dataStr = @"Body_Light";
            valueStr = mTotalBody_Li;
            break;
        case 3:
            dataStr = @"Body_Medium";
            valueStr = mTotalBody_Me;
            break;
        case 4:
            dataStr = @"Body_Heavy";
            valueStr = mTotalBody_He;
            break;
        case 5:
            dataStr = @"Balance_Po";
            valueStr = mTotalBalance_Po;
            break;
        case 6:
            dataStr = @"Balance_Ne";
            valueStr = mTotalBalance_Ne;
            break;
    }
    
    [self popupLoad:dataStr value:valueStr];
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

- (void) firstInit{
    NSLog(@"mPosition  : %ld" ,  mPosition);
    [self Step1];       //통신 1 구간
}

#pragma mark -
#pragma mark PopupListViewDelegate

- (void)popupLoad:(NSString*)nameValue value:(NSString*)value{
    popupView.hidden = NO;
    self.selectedIndexes = [[NSMutableIndexSet alloc] init];
    listArr = [[NSMutableArray alloc] init];
    listArr = [PopupListCoffee list:nameValue];
    NSMutableArray *choseListArr = [[NSMutableArray alloc] init];
    
    // 팝업띄울때 선택되어지는 값들
    NSArray *valueArray = [value componentsSeparatedByString:@","];
    for(int i = 0; i < [valueArray count]; i++){
        for(int j = 0; j < [listArr count]; j++){
            if([[valueArray objectAtIndex:i] isEqualToString:[listArr objectAtIndex:j]]){
                [choseListArr addObject:[NSString stringWithFormat:@"%ld", (long)j]];
            }
        }
    }
    for(int k = 0; k < [choseListArr count]; k++){
        [self.selectedIndexes addIndex:[[choseListArr objectAtIndex:k] integerValue]];
    }
    
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
    if([name isEqualToString:@"Aftertaste_Po"]){
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
    }
}

#pragma mark -
#pragma mark TextField

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSInteger textY = 0;
    if(textView == noteTextView){
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
    
    [noteTextView resignFirstResponder];
}

@end
