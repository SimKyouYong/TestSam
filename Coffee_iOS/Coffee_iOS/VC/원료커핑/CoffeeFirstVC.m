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
#import "PopupListViewCoffee.h"
#import "PopupListCoffee.h"

@interface CoffeeFirstVC () <PopupListViewDelegate>
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexes;
@end

@implementation CoffeeFirstVC

@synthesize coffeeFirstTableView;
@synthesize aromaButton;
@synthesize flavorButton;
@synthesize acidityButton;
@synthesize noteTextView;
@synthesize toptitle;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"fix_position : %ld " , fix_position);
    NSLog(@"fix_position : %ld " , (long)MPOSITION);
    if (fix_position != MPOSITION) {
        //다르면 실행
        [self Step1];       //통신 1 구간
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    fix_position = 0;
    cellCheckNum = 0;
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"완료" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar setItems:[NSArray arrayWithObjects:leftSpace, done, nil]];
    [toolbar sizeToFit];
    
    [noteTextView setInputAccessoryView:toolbar];
    
    actionArr = [[NSMutableArray alloc] init];
    
    NSLog(@"SESSIONID   :: %@" , SESSIONID);
    NSLog(@"USER_ID     :: %@" , USER_ID);
    NSLog(@"MPOSITION     :: %ld" , (long)MPOSITION);
    
    toptitle.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectButton)];
    [toptitle addGestureRecognizer:tapGesture];

    popupView = [[PopupView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    [self.view addSubview:popupView];
    popupView.hidden = YES;
    
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
    NSArray *backArray = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[backArray objectAtIndex:2] animated:YES];
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
            UIButton *TotalFloralButton = (UIButton*)[cell viewWithTag:2];
            
            TotalFruity = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalFruityButton = (UIButton*)[cell viewWithTag:4];
            
            TotalAlcoholic = (UILabel*)[cell viewWithTag:5];
            UIButton *TotalAlcoholicButton = (UIButton*)[cell viewWithTag:6];
            
            TotalHerb = (UILabel*)[cell viewWithTag:7];
            UIButton *TotalHerbButton = (UIButton*)[cell viewWithTag:8];
            
            TotalSpice = (UILabel*)[cell viewWithTag:9];
            UIButton *TotalSpiceButton = (UIButton*)[cell viewWithTag:10];
            
            TotalSweet = (UILabel*)[cell viewWithTag:11];
            UIButton *TotalSweetButton = (UIButton*)[cell viewWithTag:12];
            
            TotalNut = (UILabel*)[cell viewWithTag:13];
            UIButton *TotalNutButton = (UIButton*)[cell viewWithTag:14];
            
            TotalChocolate = (UILabel*)[cell viewWithTag:15];
            UIButton *TotalChocolateButton = (UIButton*)[cell viewWithTag:16];
            
            TotalGrain = (UILabel*)[cell viewWithTag:17];
            UIButton *TotalGrainButton = (UIButton*)[cell viewWithTag:18];
            
            TotalRoast = (UILabel*)[cell viewWithTag:19];
            UIButton *TotalRoastButton = (UIButton*)[cell viewWithTag:20];
            
            TotalSavory = (UILabel*)[cell viewWithTag:21];
            UIButton *TotalSavoryButton = (UIButton*)[cell viewWithTag:22];
            
            TotalFloral.text = mTotalFloral;//[tableDic objectForKey:@"floral"];
            TotalFruity.text = mTotalFruity;//[tableDic objectForKey:@"fruity"];
            TotalAlcoholic.text = mTotalAlcoholic;//[tableDic objectForKey:@"alcoholic"];
            TotalHerb.text = mTotalHerb;//[tableDic objectForKey:@"herb"];
            TotalSpice.text = mTotalSpice;//[tableDic objectForKey:@"spice"];
            TotalSweet.text = mTotalSweet;//[tableDic objectForKey:@"sweet"];
            TotalNut.text = mTotalNut;//[tableDic objectForKey:@"nut"];
            TotalChocolate.text = mTotalChocolate;//[tableDic objectForKey:@"chocolate"];
            TotalGrain.text = mTotalGrain;//[tableDic objectForKey:@"grain"];
            TotalRoast.text = mTotalRoast;//[tableDic objectForKey:@"roast"];
            TotalSavory.text = mTotalSavory;//[tableDic objectForKey:@"savory"];
            
            [TotalFruityButton addTarget:self action:@selector(TotalFruityAction:) forControlEvents:UIControlEventTouchUpInside];
            
            TotalFloralButton.tag = TotalFloral.tag;
            [TotalFloralButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalAlcoholicButton.tag = TotalAlcoholic.tag;
            [TotalAlcoholicButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalHerbButton.tag = TotalHerb.tag;
            [TotalHerbButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalSpiceButton.tag = TotalSpice.tag;
            [TotalSpiceButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalSweetButton.tag = TotalSweet.tag;
            [TotalSweetButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalNutButton.tag = TotalNut.tag;
            [TotalNutButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalChocolateButton.tag = TotalChocolate.tag;
            [TotalChocolateButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalGrainButton.tag = TotalGrain.tag;
            [TotalGrainButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalRoastButton.tag = TotalRoast.tag;
            [TotalRoastButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalSavoryButton.tag = TotalSavory.tag;
            [TotalSavoryButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            cellCheckNum = 1;
            
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
            
            TotalFermented.text = mTotalFermented;//[tableDic objectForKey:@"fermented"];
            TotalChemical.text = mTotalChemical;//[tableDic objectForKey:@"chemical"];
            TotalGreen.text = mTotalGreen;//[tableDic objectForKey:@"green"];
            TotalMusty.text = mTotalMusty;//[tableDic objectForKey:@"musty"];
            TotalRoastdefect.text = mTotalRoastdefect;//[tableDic objectForKey:@"roastdefect"];
            
            [TotalChemicalButton addTarget:self action:@selector(TotalChemicalAction:) forControlEvents:UIControlEventTouchUpInside];
            
            TotalFermentedButton.tag = TotalFermented.tag;
            [TotalFermentedButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalGreenButton.tag = TotalGreen.tag;
            [TotalGreenButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalMustyButton.tag = TotalMusty.tag;
            [TotalMustyButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalRoastdefectButton.tag = TotalRoastdefect.tag;
            [TotalRoastdefectButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            cellCheckNum = 2;
            
            return cell;
        }else if(indexPath.row == 3){
            static NSString *CellIdentifier = @"thirdCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      
            TotalAcidity_Po = (UILabel*)[cell viewWithTag:1];
            UIButton *TotalAcidity_PoButton = (UIButton*)[cell viewWithTag:2];
            
            TotalAcidity_Ne = (UILabel*)[cell viewWithTag:3];
            UIButton *TotalAcidity_NeButton = (UIButton*)[cell viewWithTag:4];
            
            TotalAcidity_Po.text = mTotalAcidity_Po;//[tableDic objectForKey:@"acidity_po"];
            TotalAcidity_Ne.text = mTotalAcidity_Ne;//[tableDic objectForKey:@"acidity_ne"];
            
            TotalAcidity_PoButton.tag = TotalAcidity_Po.tag;
            [TotalAcidity_PoButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            TotalAcidity_NeButton.tag = TotalAcidity_Ne.tag;
            [TotalAcidity_NeButton addTarget:self action:@selector(ToTalCommonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            cellCheckNum = 3;
            
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
#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        if([datas count] == buttonIndex){
            return;
        }
        MPOSITION = buttonIndex;
        fix_position = MPOSITION; //저장
        [self firstInit];
    }else{
        if(actionSheetNum == 4){
            if(buttonIndex == 9){
            }else{
                [self TotalFruity2:buttonIndex];
            }
            return;
        }
        if(actionSheetNum == 5){
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
            [aromaButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 2){
            [flavorButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        }else if(actionSheetNum == 3){
            [acidityButton setTitle:[actionArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
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
    
    if(cellCheckNum == 1){
        switch (nIndex){
            case 1:
                dataStr = @"Floral";
                valueStr = mTotalFloral;
                break;
            case 5:
                dataStr = @"Alcoholic";
                valueStr = mTotalAlcoholic;
                break;
            case 7:
                dataStr = @"Herb/Vegetative";
                valueStr = mTotalHerb;
                break;
            case 9:
                dataStr = @"Spice";
                valueStr = mTotalSpice;
                break;
            case 11:
                dataStr = @"Sweet";
                valueStr = mTotalSweet;
                break;
            case 13:
                dataStr = @"Nut";
                valueStr = mTotalNut;
                break;
            case 15:
                dataStr = @"Chocolate";
                valueStr = mTotalChocolate;
                break;
            case 17:
                dataStr = @"Grain/Cereal";
                valueStr = mTotalGrain;
                break;
            case 19:
                dataStr = @"Roast";
                valueStr = mTotalRoast;
                break;
            case 21:
                dataStr = @"Savory";
                valueStr = mTotalSavory;
                break;
        }
    }else if(cellCheckNum == 2){
        switch (nIndex){
            case 1:
                dataStr = @"fermented";
                valueStr = mTotalFermented;
                break;
            case 5:
                dataStr = @"Green/grassy";
                valueStr = mTotalGreen;
                break;
            case 7:
                dataStr = @"musty";
                valueStr = mTotalMusty;
                break;
            case 9:
                dataStr = @"Roast Defect";
                valueStr = mTotalRoast;
                break;
        }
        
    }else if(cellCheckNum == 3){
        switch (nIndex){
            case 1:
                dataStr = @"Acidity_Po";
                valueStr = mTotalAcidity_Po;
                break;
            case 3:
                dataStr = @"Acidity_Ne";
                valueStr = mTotalAcidity_Ne;
                break;
        }
    }
    
    [self popupLoad:dataStr value:valueStr];
}

- (void)TotalFruityAction:(UIButton*)sender{
    actionSheetNum = 4;
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"중분류를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:@"Fruity"];
    [menu addButtonWithTitle:@"citrus/citric acid"];
    [menu addButtonWithTitle:@"apple/malic acid"];
    [menu addButtonWithTitle:@"melon"];
    [menu addButtonWithTitle:@"tropical fruit"];
    [menu addButtonWithTitle:@"stone fruit"];
    [menu addButtonWithTitle:@"berry"];
    [menu addButtonWithTitle:@"grape/tartaric acid"];
    [menu addButtonWithTitle:@"dried fruit"];
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

- (void)TotalFruity2:(NSInteger)indexNum{
    NSString *dataStr;
    NSString *valueStr;
    
    switch (indexNum){
        case 0:
            dataStr = @"Fruity";
            valueStr = mTotalFruity;
            break;
        case 1:
            dataStr = @"citrus/citric acid";
            valueStr = mTotalFruity;
            break;
        case 2:
            dataStr = @"apple/malic acid";
            valueStr = mTotalFruity;
            break;
        case 3:
            dataStr = @"melon";
            valueStr = mTotalFruity;
            break;
        case 4:
            dataStr = @"tropical fruit";
            valueStr = mTotalFruity;
            break;
        case 5:
            dataStr = @"stone fruit";
            valueStr = mTotalFruity;
            break;
        case 6:
            dataStr = @"berry";
            valueStr = mTotalFruity;
            break;
        case 7:
            dataStr = @"grape/tartaric acid";
            valueStr = mTotalFruity;
            break;
        case 8:
            dataStr = @"dried fruit";
            valueStr = mTotalFruity;
            break;
    }
    
    [self popupLoad:dataStr value:valueStr];
}

- (void)TotalChemicalAction:(UIButton*)sender{
    actionSheetNum = 5;
    
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"중분류를 선택해주세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:@"chemical"];
    [menu addButtonWithTitle:@"phenolic"];
    [menu addButtonWithTitle:@"rubbery"];
    [menu addButtonWithTitle:@"bitter"];
    [menu addButtonWithTitle:@"metalic"];
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

- (void)TotalChemical2:(NSInteger)indexNum{
    NSString *dataStr;
    NSString *valueStr;
    
    switch (indexNum){
        case 0:
            dataStr = @"chemical";
            valueStr = mTotalChemical;
            break;
        case 1:
            dataStr = @"phenolic";
            valueStr = mTotalChemical;
            break;
        case 2:
            dataStr = @"rubbery";
            valueStr = mTotalChemical;
            break;
        case 3:
            dataStr = @"bitter";
            valueStr = mTotalChemical;
            break;
        case 4:
            dataStr = @"metalic";
            valueStr = mTotalChemical;
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
    NSLog(@"mPosition  : %ld" ,  MPOSITION);
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

- (void)popupListViewCancel{
    popupView.hidden = YES;
}

- (void)submitButton:(NSString *)value name:(NSString *)name{
    if([name isEqualToString:@"Floral"]){
        TotalFloral.text = value;
        mTotalFloral = value;
        
    }else if([name isEqualToString:@"Fruity"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"citrus/citric acid"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"apple/malic acid"]){
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
        
    }else if([name isEqualToString:@"grape/tartaric acid"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"dried fruit"]){
        TotalFruity.text = value;
        mTotalFruity = value;
        
    }else if([name isEqualToString:@"Alcoholic"]){
        TotalAlcoholic.text = value;
        mTotalAlcoholic = value;
        
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
        
    }else if([name isEqualToString:@"Acidity_Po"]){
        TotalAcidity_Po.text = value;
        mTotalAcidity_Po = value;
        
    }else if([name isEqualToString:@"Acidity_Ne"]){
        TotalAcidity_Ne.text = value;
        mTotalAcidity_Ne = value;
        
    }else if([name isEqualToString:@"fermented"]){
        TotalFermented.text = value;
        mTotalFermented = value;
        
    }else if([name isEqualToString:@"chemical"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"phenolic"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"rubbery"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"bitter"]){
        TotalChemical.text = value;
        mTotalChemical = value;
        
    }else if([name isEqualToString:@"metalic"]){
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
