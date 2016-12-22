//
//  HomeVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController{
    NSMutableArray *tableList;
    NSInteger tab_position;
}

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (weak, nonatomic) IBOutlet UIButton *tabButton1;
@property (weak, nonatomic) IBOutlet UIButton *tabButton2;
@property (weak, nonatomic) IBOutlet UIButton *tabButton3;

- (IBAction)homeButton:(id)sender;
- (IBAction)tabButton1:(id)sender;
- (IBAction)tabButton2:(id)sender;
- (IBAction)tabButton3:(id)sender;

@end
