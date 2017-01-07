//
//  ReviewSamplesVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2017. 1. 1..
//  Copyright © 2017년 JC1_Joseph. All rights reserved.
//

#import "ReviewSamplesVC.h"
#import "ReviewSamplesCell.h"

@interface ReviewSamplesVC ()

@end

@implementation ReviewSamplesVC

@synthesize reviewSamplesTableView;
@synthesize tab1Button;
@synthesize tab2Button;
@synthesize tab3Button;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableList = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//[tableList count];
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
    /*
    NSDictionary *dic = [tableList objectAtIndex:indexPath.row];
    
    cell.titleText.text = [dic objectForKey:@"session_idx"];
    cell.comentText.text = [dic objectForKey:@"title"];
    cell.timeText.text = [NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"startdate"], [dic objectForKey:@"starttime"]];
    cell.placeText.text = [dic objectForKey:@"place"];
    
    cell.cuppingButton.tag = indexPath.row;
    cell.reviewButton.tag = indexPath.row;
    
    if ([[dic objectForKey:@"state"] isEqualToString:@"E"]){
        [cell.cuppingButton setImage:[UIImage imageNamed:@"off_cupping_button_226x68"] forState:UIControlStateNormal];
        [cell.reviewButton setImage:[UIImage imageNamed:@"on_review_button_226x68"] forState:UIControlStateNormal];
        
    } else if([[dic objectForKey:@"state"] isEqualToString:@"W"]){
        if ([[dic objectForKey:@"isblind"] isEqualToString:@"N"]) {
        }
        
        [cell.cuppingButton setImage:[UIImage imageNamed:@"on2_cupping_button_226x68"] forState:UIControlStateNormal];
        
    } else {
        [cell.cuppingButton setImage:[UIImage imageNamed:@"on2_cupping_button_226x68"] forState:UIControlStateNormal];
        [cell.reviewButton setImage:[UIImage imageNamed:@"off_review_button_226x68"] forState:UIControlStateNormal];
    }
    
    [cell.cuppingButton addTarget:self action:@selector(cuppingAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reviewButton addTarget:self action:@selector(reviewAction:) forControlEvents:UIControlEventTouchUpInside];
    */
    return cell;
}

#pragma mark -
#pragma mark Button Action

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tab1Button:(id)sender {
}

- (IBAction)tab2Button:(id)sender {
}

- (IBAction)tab3Button:(id)sender {
}

- (void)cuppingAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    
    
}

- (void)reviewAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    
}

@end
