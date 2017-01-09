//
//  HomeVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HomeVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "CoffeReViewVC.h"
#import "HalfProductReViewVC.h"
#import "MenualReViewVC.h"
#import "HomeCell.h"

@interface HomeVC ()

@end

@implementation HomeVC

@synthesize homeTableView;
@synthesize tabButton1;
@synthesize tabButton2;
@synthesize tabButton3;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_on_bg_250x94.png"] forState:UIControlStateNormal];
    
    [self listInitLoad:0];
}

- (void)listInitLoad:(NSInteger)num{
    tableList = [[NSMutableArray alloc] init];
    
    //opt : 원료 - source, 반제품 - half, 매뉴얼 - manual
    NSString *optSelect = nil;
    if(num == 0){
        optSelect = @"source";
    }else if(num == 1){
        optSelect = @"half";
    }else if(num == 2){
        optSelect = @"manual";
    }
    tab_position = num;
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&opt=%@&page=%@", HOMELIST_URL, USER_ID, optSelect, @"1"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        //NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            tableList = [dic objectForKey:@"datas"];
            NSLog(@"%@", tableList);
            [homeTableView reloadData];

            
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"halfProduct"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tabButton1:(id)sender {
    [self listInitLoad:0];
    
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_on_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_off_bg_250x94.png"] forState:UIControlStateNormal];
}

- (IBAction)tabButton2:(id)sender {
    [self listInitLoad:1];
    
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_on_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_off_bg_250x94.png"] forState:UIControlStateNormal];
}

- (IBAction)tabButton3:(id)sender {
    [self listInitLoad:2];
    
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_on_bg_250x94.png"] forState:UIControlStateNormal];
}

- (void)sampleAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    SESSIONID = [[tableList objectAtIndex:nIndex] valueForKey:@"session_idx"];

    NSDictionary *dic = [tableList objectAtIndex:nIndex];
    if ([[dic objectForKey:@"state"] isEqualToString:@"E"]){
        [self performSegueWithIdentifier:@"sample_push" sender:sender];
    }else if ([[dic objectForKey:@"state"] isEqualToString:@"W"]){
        if ([[dic objectForKey:@"isblind"] isEqualToString:@"N"]) {
            [self performSegueWithIdentifier:@"sample_push" sender:sender];
        }
    }else{
        if ([[dic objectForKey:@"isblind"] isEqualToString:@"N"]) {
            [self performSegueWithIdentifier:@"sample_push" sender:sender];
        }
    }
}

- (void)cuppingAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    SESSIONID = [[tableList objectAtIndex:nIndex] valueForKey:@"session_idx"];
    //MPOSITION = (int)nIndex;
    
    //커핑은 무조건 화면 진입 여부를 위해 request 요청함. 
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&session_idx=%@", CUPPING_COMMON, USER_ID, SESSIONID];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    }];
    [dataTask resume];
    
    NSDictionary *dic = [tableList objectAtIndex:nIndex];
    if ([[dic objectForKey:@"state"] isEqualToString:@"W"]){
        if (tab_position == 0) {
            // 원료커핑
            [self performSegueWithIdentifier:@"coffee_push" sender:sender];
        }else if(tab_position == 1){
            // 반제품
            [self performSegueWithIdentifier:@"half_push" sender:sender];
        }else{
            // 메뉴얼
            [self performSegueWithIdentifier:@"menual_push" sender:sender];
        }
    }else if ([[dic objectForKey:@"state"] isEqualToString:@"E"]){
        
    }else{
        if (tab_position == 0) {
            // 원료커핑
            [self performSegueWithIdentifier:@"coffee_push" sender:sender];
        }else if(tab_position == 1){
            // 반제품
            [self performSegueWithIdentifier:@"half_push" sender:sender];
        }else{
            // 메뉴얼
            [self performSegueWithIdentifier:@"menual_push" sender:sender];
        }
    }
    
    [self performSegueWithIdentifier:@"menual_push" sender:sender];
}

- (void)reviewAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    SESSIONID = [[tableList objectAtIndex:nIndex] valueForKey:@"session_idx"];
    
    NSDictionary *dic = [tableList objectAtIndex:nIndex];
    if ([[dic objectForKey:@"state"] isEqualToString:@"E"]){
        if (tab_position == 0) {
            // 원료커핑
            [self performSegueWithIdentifier:@"coffeeReview_push" sender:sender];
        }else if(tab_position == 1){
            // 반제품
            [self performSegueWithIdentifier:@"halfReview_push" sender:sender];
        }else{
            // 메뉴얼
            [self performSegueWithIdentifier:@"menualReview_push" sender:sender];
        }
    }
}

#pragma mark -
#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    
    if (cell == nil){
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HomeCell"];
    }
    
    NSDictionary *dic = [tableList objectAtIndex:indexPath.row];
    
    cell.titleText.text = [dic objectForKey:@"session_idx"];
    cell.comentText.text = [dic objectForKey:@"title"];
    cell.timeText.text = [NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"startdate"], [dic objectForKey:@"starttime"]];
    cell.placeText.text = [dic objectForKey:@"place"];
    
    cell.sampleButton.tag = indexPath.row;
    cell.cuppingButton.tag = indexPath.row;
    cell.reviewButton.tag = indexPath.row;
    
    if ([[dic objectForKey:@"state"] isEqualToString:@"E"]){
        [cell.sampleButton setImage:[UIImage imageNamed:@"on_sample_button_226x68"] forState:UIControlStateNormal];
        [cell.cuppingButton setImage:[UIImage imageNamed:@"off_cupping_button_226x68"] forState:UIControlStateNormal];
        [cell.reviewButton setImage:[UIImage imageNamed:@"on_review_button_226x68"] forState:UIControlStateNormal];
        
    } else if([[dic objectForKey:@"state"] isEqualToString:@"W"]){
        if ([[dic objectForKey:@"isblind"] isEqualToString:@"N"]) {
            [cell.sampleButton setImage:[UIImage imageNamed:@"on_sample_button_226x68"] forState:UIControlStateNormal];
        }else {
            [cell.sampleButton setImage:[UIImage imageNamed:@"off_sample_button_226x68"] forState:UIControlStateNormal];
        }
        
        [cell.cuppingButton setImage:[UIImage imageNamed:@"on2_cupping_button_226x68"] forState:UIControlStateNormal];
        
    } else {
        [cell.cuppingButton setImage:[UIImage imageNamed:@"on2_cupping_button_226x68"] forState:UIControlStateNormal];
        [cell.reviewButton setImage:[UIImage imageNamed:@"off_review_button_226x68"] forState:UIControlStateNormal];

        if ([[dic objectForKey:@"isblind"] isEqualToString:@"N"]) {
            [cell.sampleButton setImage:[UIImage imageNamed:@"on_sample_button_226x68"] forState:UIControlStateNormal];
        }else {
            [cell.sampleButton setImage:[UIImage imageNamed:@"off_sample_button_226x68"] forState:UIControlStateNormal];
        }
    }
    
    [cell.sampleButton addTarget:self action:@selector(sampleAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cuppingButton addTarget:self action:@selector(cuppingAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reviewButton addTarget:self action:@selector(reviewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

@end
