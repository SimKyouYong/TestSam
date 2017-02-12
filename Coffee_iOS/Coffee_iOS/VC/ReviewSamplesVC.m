//
//  ReviewSamplesVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2017. 1. 1..
//  Copyright © 2017년 JC1_Joseph. All rights reserved.
//

#import "ReviewSamplesVC.h"
#import "ReviewSamplesCell.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "ReviewWebviewVC.h"

@interface ReviewSamplesVC ()

@end

@implementation ReviewSamplesVC

@synthesize reviewSamplesTableView;
@synthesize tab1Button;
@synthesize tab2Button;
@synthesize tab3Button;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [tab1Button setImage:[UIImage imageNamed:@"tab1_on_bg_250x94.png"] forState:UIControlStateNormal];
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&opt=%@&page=%@", REVIEW_SAMPLE_URL, USER_ID, optSelect, @"1"];
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
            NSLog(@"data : %@", tableList);
            [reviewSamplesTableView reloadData];
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
    if ([[segue identifier] isEqualToString:@"sample_webview"])
    {
        ReviewWebviewVC *vc = [segue destinationViewController];
        vc.sampleIdx = nextIdx;
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
    ReviewSamplesCell *cell = (ReviewSamplesCell *)[tableView dequeueReusableCellWithIdentifier:@"ReviewSamplesCell"];
    
    if (cell == nil){
        cell = [[ReviewSamplesCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ReviewSamplesCell"];
    }

    NSDictionary *dic = [tableList objectAtIndex:indexPath.row];
    
    cell.titleText.text = [NSString stringWithFormat:@"%@ - %@", [dic objectForKey:@"session_idx"], [dic objectForKey:@"sample_code"]];
    cell.comentText.text = [dic objectForKey:@"title"];
    cell.timeText.text = [NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"startdate"], [dic objectForKey:@"starttime"]];
    cell.placeText.text = [dic objectForKey:@"place"];
    cell.leftLabel.text = [NSString stringWithFormat:@"TESTER : %@", [dic objectForKey:@"tester_cnt"]];
    
    cell.reviewButton.tag = indexPath.row;
    cell.reportButton.tag = indexPath.row;
    
    [cell.reviewButton addTarget:self action:@selector(reviewAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reportButton addTarget:self action:@selector(reportAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark -
#pragma mark Button Action

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)linkButton:(id)sender {
    NSURL* url = [[NSURL alloc] initWithString:@"http://work.nexall.net/csearch.php"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)tab1Button:(id)sender {
    [self listInitLoad:0];
    
    [tab1Button setImage:[UIImage imageNamed:@"tab1_on_bg_250x94.png"] forState:UIControlStateNormal];
    [tab2Button setImage:[UIImage imageNamed:@"tab2_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tab3Button setImage:[UIImage imageNamed:@"tab3_off_bg_250x94.png"] forState:UIControlStateNormal];
}

- (IBAction)tab2Button:(id)sender {
    [self listInitLoad:1];
    
    [tab1Button setImage:[UIImage imageNamed:@"tab1_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tab2Button setImage:[UIImage imageNamed:@"tab2_on_bg_250x94.png"] forState:UIControlStateNormal];
    [tab3Button setImage:[UIImage imageNamed:@"tab3_off_bg_250x94.png"] forState:UIControlStateNormal];
}

- (IBAction)tab3Button:(id)sender {
    [self listInitLoad:2];
    
    [tab1Button setImage:[UIImage imageNamed:@"tab1_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tab2Button setImage:[UIImage imageNamed:@"tab2_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tab3Button setImage:[UIImage imageNamed:@"tab3_on_bg_250x94.png"] forState:UIControlStateNormal];
}

- (void)reviewAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    SESSIONID = [[tableList objectAtIndex:nIndex] valueForKey:@"session_idx"];

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

- (void)reportAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    SESSIONID = [[tableList objectAtIndex:nIndex] valueForKey:@"session_idx"];

    NSDictionary *dic = [tableList objectAtIndex:nIndex];
    nextIdx = [dic objectForKey:@"sample_idx"];
    
    [self performSegueWithIdentifier:@"sample_webview" sender:sender];
}

@end
