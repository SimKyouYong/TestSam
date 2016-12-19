//
//  MenualReViewVC.h
//  Coffee_iOS
//
//  Created by 심규용 on 2016. 12. 18..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenualReViewVC : UIViewController
{
    NSUserDefaults *defaults;
    
    NSDictionary *dic_result;
    NSDictionary *dic_result2;
    
    NSArray *datas;
    NSArray *datas2;
    NSArray *datas3;
}

@property (weak, nonatomic) IBOutlet UIScrollView *menualScrollView;

@property (weak, nonatomic) IBOutlet UILabel *totalAVRText;
@property (weak, nonatomic) IBOutlet UILabel *totalSTDText;
@property (weak, nonatomic) IBOutlet UILabel *totalSCOREText;

@property (weak, nonatomic) IBOutlet UILabel *acidityLeftText;
@property (weak, nonatomic) IBOutlet UILabel *acidityRightText;
@property (weak, nonatomic) IBOutlet UILabel *sweetnessLeftText;
@property (weak, nonatomic) IBOutlet UILabel *sweetnessRightText;
@property (weak, nonatomic) IBOutlet UILabel *bitternessLeftText;
@property (weak, nonatomic) IBOutlet UILabel *bitternessRightText;
@property (weak, nonatomic) IBOutlet UILabel *bodyLeftText;
@property (weak, nonatomic) IBOutlet UILabel *bodyRightText;
@property (weak, nonatomic) IBOutlet UILabel *aftertasteLeftText;
@property (weak, nonatomic) IBOutlet UILabel *aftertasteRightText;

- (IBAction)backButton:(id)sender;

@end
