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
    
    tableList = [[NSMutableArray alloc] init];
    
    [self listInitLoad:0];
}

- (void)listInitLoad:(NSInteger)num{
    //opt : 원료 - source, 반제품 - half, 매뉴얼 - manual
    NSString *optSelect = nil;
    if(num == 0){
        optSelect = @"source";
    }else if(num == 0){
        optSelect = @"half";
    }else if(num == 0){
        optSelect = @"manual";
    }

    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&opt=%@&page=%@&session_idx=%@", HOMELIST_URL, USER_ID, optSelect, @"1", @"1"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        //NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            NSLog(@"%@", dic);
            
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

- (IBAction)tabButton1:(id)sender {
    [self listInitLoad:0];
    
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_on_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_off_bg_250x94.png"] forState:UIControlStateNormal];
    
    //[self performSegueWithIdentifier:@"coffee_push" sender:sender];
}

- (IBAction)tabButton2:(id)sender {
    [self listInitLoad:1];
    
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_on_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_off_bg_250x94.png"] forState:UIControlStateNormal];
    
    //[self performSegueWithIdentifier:@"halfProduct_push" sender:sender];
}

- (IBAction)tabButton3:(id)sender {
    [self listInitLoad:2];
    
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_on_bg_250x94.png"] forState:UIControlStateNormal];
    
    //[self performSegueWithIdentifier:@"menual_push" sender:sender];
}

#pragma mark -
#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableList count] + 1;
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
    static NSString *CellIdentifier = @"homeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    
    return cell;
}

@end
