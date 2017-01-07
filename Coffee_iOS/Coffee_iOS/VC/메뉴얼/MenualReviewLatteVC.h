//
//  MenualReviewLatteVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenualReviewLatteVC : UIViewController{
    // 상세뷰로 넘길 값
    NSInteger sampleIndexValue;
    NSInteger detailCount;
    NSInteger buttonCheck;
}

@property (weak, nonatomic) IBOutlet UIScrollView *menualReviewLatteScrollView;

- (IBAction)americanoButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *reviewText1;
@property (weak, nonatomic) IBOutlet UILabel *reviewText2;
@property (weak, nonatomic) IBOutlet UILabel *reviewText3;
@property (weak, nonatomic) IBOutlet UILabel *reviewText4;
@property (weak, nonatomic) IBOutlet UILabel *reviewText5;
@property (weak, nonatomic) IBOutlet UILabel *reviewText6;
@property (weak, nonatomic) IBOutlet UILabel *reviewText7;
@property (weak, nonatomic) IBOutlet UILabel *reviewText8;

- (IBAction)detailLeftButton:(id)sender;
- (IBAction)detailRightButton:(id)sender;
- (IBAction)backButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *topMyLabel;
@property (weak, nonatomic) IBOutlet UILabel *topAvrLabel;

@end
