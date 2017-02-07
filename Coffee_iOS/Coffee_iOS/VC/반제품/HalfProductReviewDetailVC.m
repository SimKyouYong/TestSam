//
//  HalfProductReviewDetailVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HalfProductReviewDetailVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "DetailCell.h"

@interface HalfProductReviewDetailVC ()

@end

@implementation HalfProductReviewDetailVC

@synthesize halfDetailTableView;
@synthesize sampleIndex;
@synthesize countNum;
@synthesize buttonNum;
@synthesize ID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    title_Arr = [[NSMutableArray alloc] init];
    content_Arr = [[NSMutableArray alloc] init];
    
    NSLog(@"%ld", sampleIndex);
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%lu", REVIEW_URL2, ID, (unsigned long)sampleIndex];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        //NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            
            [defaults synchronize];
            //
            NSLog(@"/*------------뿌려야할 값들-----------------*/");
            NSLog(@"dic66 :: %@" , dic);
            NSLog(@"/*---------------------------------------*/");
            
            //반제품 리뷰 -> 1번째 평가보기
            if (buttonNum == 1) {
                [title_Arr addObject:@"POSITIVE"];
                [title_Arr addObject:@"NEGATIVE"];
                [title_Arr addObject:@"AFTERTASTE"];
                [title_Arr addObject:@"ACIDITY"];
                [title_Arr addObject:@"BODY"];
                [title_Arr addObject:@"BALANCE"];
                [title_Arr addObject:@"MEMO"];
                
                // Cell1
                NSString *Floral = [[dic objectForKey:@"floral"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *totalValue = @"";
                
                if(Floral.length != 0){
                    totalValue = [NSString stringWithFormat:@" Floral : %@\n", Floral];
                }
                
                NSString *Fruity = [[dic objectForKey:@"fruity"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Fruity.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Fruity : %@\n", totalValue, Fruity];
                }
                
                NSString *Alcoholic = [[dic objectForKey:@"alcoholic"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Alcoholic.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Alcoholic : %@\n", totalValue, Alcoholic];
                }
                
                NSString *Herb = [[dic objectForKey:@"herb"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Herb.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Herb/Vegetative : %@\n", totalValue, Herb];
                }
                
                NSString *Spice = [[dic objectForKey:@"spice"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Spice.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Spice : %@\n", totalValue, Spice];
                }
                
                NSString *Sweet = [[dic objectForKey:@"sweet"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Sweet.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Sweet : %@\n", totalValue, Sweet];
                }
                
                NSString *Nut = [[dic objectForKey:@"nut"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Nut.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Nut : %@\n", totalValue, Nut];
                }
                
                NSString *Chocolate = [[dic objectForKey:@"chocolate"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Chocolate.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Chocolate : %@\n", totalValue, Chocolate];
                }
                
                NSString *Green = [[dic objectForKey:@"grain"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Green.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Green : %@\n", totalValue, Green];
                }
                
                NSString *Roast = [[dic objectForKey:@"roast"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Roast.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Roast : %@\n", totalValue, Roast];
                }
                
                NSString *Savory = [[dic objectForKey:@"savory"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Savory.length != 0){
                    totalValue = [NSString stringWithFormat:@"%@ Savory : %@\n", totalValue, Savory];
                }
              
                // Cell2
                NSString *Fermentd = [[dic objectForKey:@"fermented"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *totalValue2 = @"";
                
                if(Fermentd.length != 0){
                    totalValue2 = [NSString stringWithFormat:@" Fermentd : %@\n", Fermentd];
                }
                
                NSString *Chemical = [[dic objectForKey:@"chemical"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Chemical.length != 0){
                    totalValue2 = [NSString stringWithFormat:@"%@ Chemical : %@\n", totalValue2, Chemical];
                }
                
                NSString *Green2 = [[dic objectForKey:@"green"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Green2.length != 0){
                    totalValue2 = [NSString stringWithFormat:@"%@ Green : %@\n", totalValue2, Green2];
                }
                
                NSString *Musty = [[dic objectForKey:@"musty"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(Musty.length != 0){
                    totalValue2 = [NSString stringWithFormat:@"%@ Musty : %@\n", totalValue2, Musty];
                }
                
                NSString *RoastDefect = [[dic objectForKey:@"roastdefect"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                if(RoastDefect.length != 0){
                    totalValue2 = [NSString stringWithFormat:@"%@ RoastDefect : %@\n", totalValue2, RoastDefect];
                }
                
                // Cell3
                NSString *aftertaste_po = [[dic objectForKey:@"aftertaste_po"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *aftertaste_ne = [[dic objectForKey:@"aftertaste_ne"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *aftertaste_total = @"";
                if(aftertaste_po.length != 0){
                    aftertaste_total = [NSString stringWithFormat:@" Po : %@\n", aftertaste_po];
                }
                if(aftertaste_ne.length != 0){
                    aftertaste_total = [NSString stringWithFormat:@"%@ Ne : %@", aftertaste_total, aftertaste_ne];
                }
                
                // Cell4
                NSString *acidity_po = [[dic objectForKey:@"acidity_po"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *acidity_ne = [[dic objectForKey:@"acidity_ne"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *acidity_total = @"";
                if(acidity_po.length != 0){
                    acidity_total = [NSString stringWithFormat:@" Po : %@\n", acidity_po];
                }
                if(acidity_ne.length != 0){
                    acidity_total = [NSString stringWithFormat:@"%@ Ne : %@", acidity_total, acidity_ne];
                }
                
                // Cell5
                NSString *body_light = [[dic objectForKey:@"body_light"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *body_medium = [[dic objectForKey:@"body_medium"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *body_heavy = [[dic objectForKey:@"body_heavy"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *body_total = @"";
                
                if(body_light.length != 0){
                    body_total = [NSString stringWithFormat:@" Light : %@\n", body_light];
                }
                if(body_medium.length != 0){
                    body_total = [NSString stringWithFormat:@"%@ Medium : %@\n", body_total, body_medium];
                }
                if(body_heavy.length != 0){
                    body_total = [NSString stringWithFormat:@"%@ Heavy : %@", body_total, body_heavy];
                }
                
                // Cell6
                NSString *balance_po = [[dic objectForKey:@"balance_po"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *balance_ne = [[dic objectForKey:@"balance_ne"]stringByReplacingOccurrencesOfString:@"|" withString:@","];
                NSString *balance_total = @"";
                if(balance_po.length != 0){
                    balance_total = [NSString stringWithFormat:@" Po : %@\n", balance_po];
                }
                if(balance_ne.length != 0){
                    balance_total = [NSString stringWithFormat:@"%@ Ne : %@", balance_total, balance_ne];
                }
                
                [content_Arr addObject:totalValue];
                [content_Arr addObject:totalValue2];
                [content_Arr addObject:aftertaste_total];
                [content_Arr addObject:acidity_total];
                [content_Arr addObject:body_total];
                [content_Arr addObject:balance_total];
                [content_Arr addObject:[dic objectForKey:@"note4"]];
                
            }else if(buttonNum == 3 || buttonNum == 4){
                [title_Arr addObject:@"MEMO"];
                [content_Arr addObject:[dic objectForKey:@"note4"]];
            }
            
            [halfDetailTableView reloadData];
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
#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([content_Arr count] == 0) {
        return 0;
    }
    NSLog(@"[content_Arr count] :; %lu" , (unsigned long)[content_Arr count]);
    return [content_Arr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *myString = [content_Arr objectAtIndex:indexPath.row];
    CGSize labelSize = [myString sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    return labelSize.height + 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    
    if (cell == nil){
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailCell"];
    }
    
    if(buttonNum == 1 || buttonNum == 2){
        cell.contentTitle.text = [title_Arr objectAtIndex:indexPath.row];
        cell.contentText.text = [content_Arr objectAtIndex:indexPath.row];
        NSString *myString = [content_Arr objectAtIndex:indexPath.row];
        CGSize labelSize = [myString sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
        cell.contentText.frame = CGRectMake(10, 30, WIDTH_FRAME - 20, labelSize.height);
        cell.vi.frame = CGRectMake(0, labelSize.height+30, WIDTH_FRAME - 20, 20);
        
    }else if(buttonNum == 3 || buttonNum == 4){
        cell.contentTitle.text = [title_Arr objectAtIndex:indexPath.row];
        cell.contentText.text = [content_Arr objectAtIndex:indexPath.row];
        NSString *myString = [content_Arr objectAtIndex:indexPath.row];
        CGSize labelSize = [myString sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
        cell.contentText.frame = CGRectMake(10, 30, WIDTH_FRAME - 20, labelSize.height);
        cell.vi.frame = CGRectMake(0, labelSize.height+30, WIDTH_FRAME - 20, 20);
    }
    
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor grayColor];
    }
    
    return cell;
}

#pragma mark -
#pragma mark Button Action

- (IBAction)closeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
