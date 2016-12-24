//
//  CoffeeReviewDetailVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeeReviewDetailVC : UIViewController
{
    NSUserDefaults *defaults;
    
    NSDictionary *dic_result;
    NSDictionary *dic_result3;
    
}
- (IBAction)closeButton:(id)sender;

@end
