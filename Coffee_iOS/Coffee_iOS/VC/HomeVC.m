//
//  HomeVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HomeVC.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@""])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)tabButton1:(id)sender {
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_on_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_off_bg_250x94.png"] forState:UIControlStateNormal];
}

- (IBAction)tabButton2:(id)sender {
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_on_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_off_bg_250x94.png"] forState:UIControlStateNormal];
}

- (IBAction)tabButton3:(id)sender {
    [tabButton1 setImage:[UIImage imageNamed:@"tab1_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton2 setImage:[UIImage imageNamed:@"tab2_off_bg_250x94.png"] forState:UIControlStateNormal];
    [tabButton3 setImage:[UIImage imageNamed:@"tab3_on_bg_250x94.png"] forState:UIControlStateNormal];
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
