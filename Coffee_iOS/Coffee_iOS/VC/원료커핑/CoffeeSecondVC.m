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

@interface CoffeeSecondVC ()

@end

@implementation CoffeeSecondVC

@synthesize coffeeSecondTableView;

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
     mListTv2.setText("(" + mSourceListItems.get(mPosition).getmNum() + "/" + mTotalPosition + ")");
     //                                mListTv1.setText(mSourceListItems.get(mPosition).getmSample_title() + ":");
     mListTv1.setText("원료커핑:");
     mListTv3.setText(" " + mSourceListItems.get(mPosition).getmSample_code());
     mSample_idx = mSourceListItems.get(mPosition).getmSample_idx();
     
     commonData.setEx4_start(mSourceListItems.get(mPosition).getmEx4_start());      //안드로이드 프리퍼런스
     commonData.setEx5_start(mSourceListItems.get(mPosition).getmEx5_start());
     commonData.setEx6_start(mSourceListItems.get(mPosition).getmEx6_start());
     commonData.setEx10_start(mSourceListItems.get(mPosition).getmEx10_start());
     commonData.setEx4_end(mSourceListItems.get(mPosition).getmEx4_end());
     commonData.setEx5_end(mSourceListItems.get(mPosition).getmEx5_end());
     commonData.setEx6_end(mSourceListItems.get(mPosition).getmEx6_end());
     commonData.setEx10_end(mSourceListItems.get(mPosition).getmEx10_end());
     commonData.setEx4_step(mSourceListItems.get(mPosition).getmEx4_step());
     commonData.setEx5_step(mSourceListItems.get(mPosition).getmEx5_step());
     commonData.setEx6_step(mSourceListItems.get(mPosition).getmEx6_step());
     commonData.setEx10_step(mSourceListItems.get(mPosition).getmEx10_step());
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
    //안드로이드
//    String result = resultObject.getString(CommonData.RESULT);
//    String result_message = resultObject.getString(CommonData.RESULT_M);
//    String acidity_point = resultObject.getString(CommonData.ACIDITY_POINT);
//    String aftertaste_point = resultObject.getString(CommonData.AFTERTASTE_POINT);
//    String body_point = resultObject.getString(CommonData.BODY_POINT);
//    String balance_point = resultObject.getString(CommonData.BALANCE_POINT);
//    String overall_point = resultObject.getString(CommonData.OVERALL_POINT);
//    String note2 = resultObject.getString(CommonData.NOTE2);
//    
//    mTotalAcidity_Po = resultObject.getString(CommonData.AFTERTASTE_PO);
//    mTotalAcidity_Ne = resultObject.getString(CommonData.AFTERTASTE_NE);
//    mTotalBody_Li    = resultObject.getString(CommonData.BODY_LIGHT);
//    mTotalBody_Me    = resultObject.getString(CommonData.BODY_MEDIUM);
//    mTotalBody_He    = resultObject.getString(CommonData.BODY_HEAVY);
//    mTotalBalance_Po = resultObject.getString(CommonData.BALANCE_PO);
//    mTotalBalance_Ne = resultObject.getString(CommonData.BALANCE_NE);
//    
//    
//    if (result != null) {
//        if (result.trim().equals(commonData.SUCCESS)) {
//            mDetail2Btn1.setText(aftertaste_point);
//            mDetail2Btn2.setText(body_point);
//            mDetail2Btn3.setText(balance_point);
//            mDetail2Btn4.setText(overall_point);
//            mDetail2Edt.setText(note2);
//            
//            mAftertaste1.setText(mTotalAcidity_Po.replace("|" , ", "));
//            mAftertaste2.setText(mTotalAcidity_Ne.replace("|" , ", "));
//            mBody1.setText(mTotalBody_Li.replace("|" , ", "));
//            mBody2.setText(mTotalBody_Me.replace("|" , ", "));
//            mBody3.setText(mTotalBody_He.replace("|" , ", "));
//            mBalance1.setText(mTotalBalance_Po.replace("|" , ", "));
//            mBalance2.setText(mTotalBalance_Ne.replace("|" , ", "));
//            
//        } else {
//            Toast.makeText(SourceDetail2Activity.this, result_message, Toast.LENGTH_SHORT).show();
//        }
//    } else {
//        Toast.makeText(SourceDetail2Activity.this, "다시 시도해 주세요.", Toast.LENGTH_SHORT).show();
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
            
            return cell;
        }else if(indexPath.row == 2){
            static NSString *CellIdentifier = @"secondCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            return cell;
        }else if(indexPath.row == 3){
            static NSString *CellIdentifier = @"thirdCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
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

- (IBAction)saveButton:(id)sender {
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

@end
