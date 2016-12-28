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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    commonTableView = [[CommonTableView alloc] initWithFrame:CGRectMake(10, 100, WIDTH_FRAME - 20, HEIGHT_FRAME - 200)];
    commonTableView.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:commonTableView];
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
}

- (IBAction)nextButton:(id)sender {
    [self performSegueWithIdentifier:@"coffee2" sender:sender];
}

#pragma mark - UITableViewDataSource

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
#pragma mark JNExpandableTableView DataSource
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

@end
