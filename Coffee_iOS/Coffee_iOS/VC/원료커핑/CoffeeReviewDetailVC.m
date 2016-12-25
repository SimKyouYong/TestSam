//
//  CoffeeReviewDetailVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CoffeeReviewDetailVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "DetailCell.h"

@interface CoffeeReviewDetailVC ()

@end

@implementation CoffeeReviewDetailVC

@synthesize sampleIndex;
@synthesize countNum;
@synthesize buttonNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    title_Arr = [[NSMutableArray alloc] init];
    content_Arr = [[NSMutableArray alloc] init];
    
    NSLog(@"%ld", sampleIndex);
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%lu", REVIEW_URL2, USER_ID, (unsigned long)sampleIndex];
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
            
            //원료커피 리뷰 -> 1번째 평가보기
            if (buttonNum == 1) {
                [title_Arr addObject:@"POSITIVE"];
                [title_Arr addObject:@"NEGATIVE"];
                [title_Arr addObject:@"ACIDITY"];
                [title_Arr addObject:@"MEMO"];
                
                [content_Arr addObject:[NSString stringWithFormat:@" Floral : %@\n Fruity : %@\n Alcoholic : %@\n Herb/Vegetative : %@\n Spice : %@\n sweet : %@\n Nut : %@\n Chocolate : %@\n Green/Cereal : %@\n Roast : %@\n savory : %@", [dic objectForKey:@"floral"], [dic objectForKey:@"fruity"], [dic objectForKey:@"alcoholic"], [dic objectForKey:@"herb"], [dic objectForKey:@"spice"], [dic objectForKey:@"sweet"], [dic objectForKey:@"nut"], [dic objectForKey:@"chocolate"], [dic objectForKey:@"grain"], [dic objectForKey:@"roast"], [dic objectForKey:@"savory"]]];
                [content_Arr addObject:[NSString stringWithFormat:@" Fermentd : %@\n Chemical : %@\n Green/Grassy : %@\n Musty : %@\n Roast Defect : %@", [dic objectForKey:@"fermentd"], [dic objectForKey:@"chemical"], [dic objectForKey:@"green"], [dic objectForKey:@"musty"], [dic objectForKey:@"roastdefect"]]];
                [content_Arr addObject:[NSString stringWithFormat:@" Po : %@\n Ne : %@", [dic objectForKey:@"po"], [dic objectForKey:@"ne"]]];
                [content_Arr addObject:@"메모"];
            }
            
            [_coffeeDetailTableView reloadData];
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
    NSArray *myWords = [myString componentsSeparatedByString:@"\n"];
    NSLog(@"size :: %lu" , (unsigned long)[myWords count]);
    return 20*[myWords count];
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
    
    if(buttonNum == 1){
        cell.contentTitle.text = [title_Arr objectAtIndex:indexPath.row];
        cell.contentText.text = [content_Arr objectAtIndex:indexPath.row];
    }else if(buttonNum == 2){
        
    }else if(buttonNum == 3){
        
    }else if(buttonNum == 4){
        
    }
    
    return cell;
}

#pragma mark -
#pragma mark Button Action

- (IBAction)closeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
