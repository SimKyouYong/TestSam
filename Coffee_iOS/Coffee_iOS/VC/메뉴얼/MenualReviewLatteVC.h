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
    
    NSUserDefaults *defaults;
    
    NSDictionary *dic_result;
    NSDictionary *dic_result3;
    NSArray *datas;
    NSArray *datas2;
    NSArray *datas3;
    //추가
    NSUInteger mPosition;
    NSUInteger mSample_idx;
    
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
@property (weak, nonatomic) IBOutlet UILabel *Title;
//맨위에 3개 상단 점수
@property (weak, nonatomic) IBOutlet UILabel *mDetail4ArvScore;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4StdScore;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4TotalScore;

- (IBAction)detailLeftButton:(id)sender;
- (IBAction)detailRightButton:(id)sender;
- (IBAction)backButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *topMyLabel;
@property (weak, nonatomic) IBOutlet UILabel *topAvrLabel;

@end
