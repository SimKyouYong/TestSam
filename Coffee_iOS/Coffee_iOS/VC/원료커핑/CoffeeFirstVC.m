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
//    contentText.text = [[datas objectAtIndex:position] valueForKey:@"sample_title"];
//    
//    leftText.text = [[datas objectAtIndex:position] valueForKey:@"sample_title"];
//    NSString *codeStr =[NSString stringWithFormat:@"%@" ,[[datas objectAtIndex:position] valueForKey:@"sample_code"]];
//    centerText.text = codeStr;
//    rightText.text = [NSString stringWithFormat:@"(%ld/%@)", position+1 ,total];
    
    //안드로이드
    /*
    mListTv2.setText("(" + mSourceListItems.get(mPosition).getmNum() + "/" + mTotalPosition + ")");
                              mListTv1.setText(mSourceListItems.get(mPosition).getmSample_title() + ":");
    mListTv1.setText("원료커핑:");
    mListTv3.setText(" " + mSourceListItems.get(mPosition).getmSample_code());
    mSample_idx = mSourceListItems.get(mPosition).getmSample_idx();
    
    commonData.setEx1_start(mSourceListItems.get(mPosition).getmEx1_start());
    commonData.setEx2_start(mSourceListItems.get(mPosition).getmEx2_start());
    commonData.setEx3_start(mSourceListItems.get(mPosition).getmEx3_start());
    commonData.setEx1_end(mSourceListItems.get(mPosition).getmEx1_end());
    commonData.setEx2_end(mSourceListItems.get(mPosition).getmEx2_end());
    commonData.setEx3_end(mSourceListItems.get(mPosition).getmEx3_end());
    commonData.setEx1_step(mSourceListItems.get(mPosition).getmEx1_step());
    commonData.setEx2_step(mSourceListItems.get(mPosition).getmEx2_step());
    commonData.setEx3_step(mSourceListItems.get(mPosition).getmEx3_step());
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
    [aromaButton setTitle:[dic objectForKey:@"aroma_point"] forState:UIControlStateNormal];
    [flavorButton setTitle:[dic objectForKey:@"flavor_point"] forState:UIControlStateNormal];
    [acidityButton setTitle:[dic objectForKey:@"acidity_point"] forState:UIControlStateNormal];
    
    noteTextView.text = [dic objectForKey:@"note1"];
    
    tableDic = dic;
    [coffeeFirstTableView reloadData];
    
    //안드로이드
//    String result = resultObject.getString(CommonData.RESULT);
//    String result_message = resultObject.getString(CommonData.RESULT_M);
//    String aroma_point = resultObject.getString(CommonData.AROMA_POINT);
//    String flavor_point = resultObject.getString(CommonData.FLAVOR_POINT);
//    String acidity_point = resultObject.getString(CommonData.ACIDITY_POINT);
//    String aftertaste_point = resultObject.getString(CommonData.AFTERTASTE_POINT);
//    String note1 = resultObject.getString(CommonData.NOTE1);
//    mTotalFloral = resultObject.getString(CommonData.FLORAL);
//    mTotalFruity = resultObject.getString(CommonData.FRUITY);
//    mTotalAlcoholic = resultObject.getString(CommonData.ALCOHOLIC);
//    mTotalHerb = resultObject.getString(CommonData.HERB);
//    mTotalSpice = resultObject.getString(CommonData.SPICE);
//    mTotalSweet = resultObject.getString(CommonData.SWEET);
//    mTotalNut = resultObject.getString(CommonData.NUT);
//    mTotalChocolate = resultObject.getString(CommonData.CHOCOLATE);
//    mTotalGrain = resultObject.getString(CommonData.GRAIN);
//    mTotalRoast = resultObject.getString(CommonData.ROAST);
//    mTotalSavory = resultObject.getString(CommonData.SAVORY);
//    
//    mTotalFermented = resultObject.getString(CommonData.FERMENTED);
//    mTotalChemical = resultObject.getString(CommonData.CHEMICAL);
//    mTotalGreen = resultObject.getString(CommonData.GREEN);
//    mTotalMusty = resultObject.getString(CommonData.MUSTY);
//    mTotalRoastdefect = resultObject.getString(CommonData.ROASTDEFECT);
//    
//    mTotalAcidity_Po = resultObject.getString(CommonData.ACIDITY_PO);
//    mTotalAcidity_Ne = resultObject.getString(CommonData.ACIDITY_NE);
//    
//    mPositive1.setText(mTotalFloral.replace("|" , ", "));
//    mPositive2.setText(mTotalFruity.replace("|" , ", "));
//    mPositive3.setText(mTotalAlcoholic.replace("|" , ", "));
//    mPositive4.setText(mTotalHerb.replace("|" , ", "));
//    mPositive5.setText(mTotalSpice.replace("|" , ", "));
//    mPositive6.setText(mTotalSweet.replace("|" , ", "));
//    mPositive7.setText(mTotalNut.replace("|" , ", "));
//    mPositive8.setText(mTotalChocolate.replace("|" , ", "));
//    mPositive9.setText(mTotalGrain.replace("|" , ", "));
//    mPositive10.setText(mTotalRoast.replace("|" , ", "));
//    mPositive11.setText(mTotalSavory.replace("|" , ", "));
//    
//    mNegative1.setText(mTotalFermented.replace("|" , ", "));
//    mNegative2.setText(mTotalChemical.replace("|" , ", "));
//    mNegative3.setText(mTotalGreen.replace("|" , ", "));
//    mNegative4.setText(mTotalMusty.replace("|" , ", "));
//    mNegative5.setText(mTotalRoastdefect.replace("|" , ", "));
//    
//    mAcidity1.setText(mTotalAcidity_Po.replace("|" , ", "));
//    mAcidity2.setText(mTotalAcidity_Ne.replace("|" , ", "));
//    
//    if (result != null) {
//        if (result.trim().equals(commonData.SUCCESS)) {
//            mDetailBtn1.setText(aroma_point);
//            mDetailBtn2.setText(flavor_point);
//            mDetailBtn3.setText(acidity_point);
//            mDetailEdt.setText(note1);
//        } else {
//            Toast.makeText(SourceDetail1Activity.this, result_message, Toast.LENGTH_SHORT).show();
//        }
//    } else {
//        Toast.makeText(SourceDetail1Activity.this, "다시 시도해 주세요.", Toast.LENGTH_SHORT).show();
//    }
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
    NSLog(@"save!!");
}

- (IBAction)nextButton:(id)sender {
    [self performSegueWithIdentifier:@"coffee2" sender:sender];
}

- (IBAction)aromaButton:(id)sender {
}

- (IBAction)flavorButton:(id)sender {
}

- (IBAction)acidityButton:(id)sender {
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
            
            UILabel *mTotalFloral = (UILabel*)[cell viewWithTag:1];
            UILabel *mTotalFruity = (UILabel*)[cell viewWithTag:3];
            UILabel *mTotalAlcoholic = (UILabel*)[cell viewWithTag:5];
            UILabel *mTotalHerb = (UILabel*)[cell viewWithTag:7];
            UILabel *mTotalSpice = (UILabel*)[cell viewWithTag:9];
            UILabel *mTotalSweet = (UILabel*)[cell viewWithTag:11];
            UILabel *mTotalNut = (UILabel*)[cell viewWithTag:13];
            UILabel *mTotalChocolate = (UILabel*)[cell viewWithTag:15];
            UILabel *mTotalGrain = (UILabel*)[cell viewWithTag:17];
            UILabel *mTotalRoast = (UILabel*)[cell viewWithTag:19];
            UILabel *mTotalSavory = (UILabel*)[cell viewWithTag:21];
            
            mTotalFloral.text = [tableDic objectForKey:@"floral"];
            mTotalFruity.text = [tableDic objectForKey:@"fruity"];
            mTotalAlcoholic.text = [tableDic objectForKey:@"alcoholic"];
            mTotalHerb.text = [tableDic objectForKey:@"herb"];
            mTotalSpice.text = [tableDic objectForKey:@"spice"];
            mTotalSweet.text = [tableDic objectForKey:@"sweet"];
            mTotalNut.text = [tableDic objectForKey:@"nut"];
            mTotalChocolate.text = [tableDic objectForKey:@"chocolate"];
            mTotalGrain.text = [tableDic objectForKey:@"grain"];
            mTotalRoast.text = [tableDic objectForKey:@"roast"];
            mTotalSavory.text = [tableDic objectForKey:@"savory"];
            
            return cell;
        }else if(indexPath.row == 2){
            static NSString *CellIdentifier = @"secondCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            UILabel *mTotalFermented = (UILabel*)[cell viewWithTag:1];
            UILabel *mTotalChemical = (UILabel*)[cell viewWithTag:3];
            UILabel *mTotalGreen = (UILabel*)[cell viewWithTag:5];
            UILabel *mTotalMusty = (UILabel*)[cell viewWithTag:7];
            UILabel *mTotalRoastdefect = (UILabel*)[cell viewWithTag:9];
            
            mTotalFermented.text = [tableDic objectForKey:@"fermented"];
            mTotalChemical.text = [tableDic objectForKey:@"chemical"];
            mTotalGreen.text = [tableDic objectForKey:@"green"];
            mTotalMusty.text = [tableDic objectForKey:@"musty"];
            mTotalRoastdefect.text = [tableDic objectForKey:@"roastdefect"];
            
            return cell;
        }else if(indexPath.row == 3){
            static NSString *CellIdentifier = @"thirdCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      
            UILabel *mTotalAcidity_Po = (UILabel*)[cell viewWithTag:1];
            UILabel *mTotalAcidity_Ne = (UILabel*)[cell viewWithTag:3];
            
            mTotalAcidity_Po.text = [tableDic objectForKey:@"acidity_po"];
            mTotalAcidity_Ne.text = [tableDic objectForKey:@"acidity_ne"];
            
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
    NSLog(@"Will Expand: %@",indexPath);
}

- (void)tableView:(JNExpandableTableView *)tableView willCollapse:(NSIndexPath *)indexPath
{
    NSLog(@"Will Collapse: %@",indexPath);
}

#pragma mark -
#pragma mark CommonTableView Delegate

- (void)cancelButton{
    popupView.hidden = YES;
    commonTableView.hidden = YES;
}

- (void)submitButton:(NSString *)value{
    NSLog(@"%@", value);
    popupView.hidden = YES;
    commonTableView.hidden = YES;
}

@end
