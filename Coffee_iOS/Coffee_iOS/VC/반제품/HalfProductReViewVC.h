//
//  HalfProductReViewVC.h
//  Coffee_iOS
//
//  Created by 심규용 on 2016. 12. 18..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HalfProductReViewVC : UIViewController
{
    NSUserDefaults *defaults;

    NSDictionary *dic_result;
    NSDictionary *dic_result3;
    NSArray *datas;
    NSArray *datas2;
    NSArray *datas3;
}
@property (weak, nonatomic) NSMutableArray *tableList_;

- (IBAction)backButton:(id)sender;

@end
