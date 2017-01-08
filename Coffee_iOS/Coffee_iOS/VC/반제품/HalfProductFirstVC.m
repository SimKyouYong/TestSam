//
//  HalfProductFirstVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HalfProductFirstVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface HalfProductFirstVC ()

@end

@implementation HalfProductFirstVC

@synthesize halfFirstTableView;
@synthesize acidityButton;
@synthesize sweetnessButton;
@synthesize bitternessButton;
@synthesize bodyButton;
@synthesize balanceButton;
@synthesize aftertasteButton;
@synthesize poButton;
@synthesize neButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SESSIONID   :: %@" , SESSIONID);
    NSLog(@"USER_ID     :: %@" , USER_ID);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"product2"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButton:(id)sender {
}

- (IBAction)nextButton:(id)sender {
    [self performSegueWithIdentifier:@"product2" sender:sender];
}

- (IBAction)acidityButton:(id)sender {
    [self actionSheetInit:0];
}

- (IBAction)sweetnessButton:(id)sender {
    [self actionSheetInit:1];
}

- (IBAction)bitternessButton:(id)sender {
    [self actionSheetInit:2];
}

- (IBAction)bodyButton:(id)sender {
    [self actionSheetInit:3];
}

- (IBAction)balanceButton:(id)sender {
    [self actionSheetInit:4];
}

- (IBAction)aftertasteButton:(id)sender {
    [self actionSheetInit:5];
}

- (IBAction)poButton:(id)sender {
    [self actionSheetInit:6];
}

- (IBAction)neButton:(id)sender {
    [self actionSheetInit:7];
}

#pragma mark -
#pragma mark ActionSheet Value Setting

- (void)actionSheetInit:(NSInteger)indexNum{
    actionSheetSettingValue = indexNum;
    
    numberArr = [NSArray arrayWithObjects: @"0.0",@"0.5",@"1.0",@"1.5",@"2.0",@"2.5",@"3.0",@"3.5",@"4.0",@"4.5",@"5.0", nil];

    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"색상을 선택해주세요.";
    menu.delegate = self;

    for(int i = 0; i < [numberArr count]; i++){
        [menu addButtonWithTitle:[numberArr objectAtIndex:i]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(6 == buttonIndex){
        return;
    }
    
    switch (actionSheetSettingValue) {
        case 0:
            [acidityButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 1:
            [sweetnessButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 2:
            [bitternessButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 3:
            [bodyButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 4:
            [balanceButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 5:
            [aftertasteButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 6:
            [poButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 7:
            [neButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        default:
            break;
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
    if ([indexPath isEqual:halfFirstTableView.expandedContentIndexPath])
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
    
    NSIndexPath * adjustedIndexPath = [halfFirstTableView adjustedIndexPathFromTable:indexPath];
    
    if ([halfFirstTableView.expandedContentIndexPath isEqual:indexPath])
    {
        if(indexPath.row == 1){
            static NSString *CellIdentifier = @"firstCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            /*
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
             */
            
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

@end
