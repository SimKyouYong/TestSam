//
//  MenualReViewVC.h
//  Coffee_iOS
//
//  Created by 심규용 on 2016. 12. 18..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenualReViewVC : UIViewController<UIActionSheetDelegate>
{
    NSUserDefaults *defaults;
    
    NSDictionary *dic_result;
    NSDictionary *dic_result3;
    NSArray *datas;
    NSArray *datas2;
    NSArray *datas3;

    
    //추가
    NSUInteger mPosition;
    NSUInteger mSample_idx;
    
    // 상세뷰로 넘길 값
    NSInteger sampleIndexValue;
    NSInteger detailCount;
    NSInteger buttonCheck;
}

//추가
@property (weak, nonatomic) IBOutlet UILabel *Title;

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

@property (weak, nonatomic) IBOutlet UIImageView *myImg;
@property (weak, nonatomic) IBOutlet UIImageView *youImg;

//버튼 - 평가보기, 총평(홀수 : my , 짝수 : 상대방 )
- (IBAction)reviewDetailButton1:(id)sender;
- (IBAction)reviewDetailButton2:(id)sender;
- (IBAction)reviewDetailButton3:(id)sender;
- (IBAction)reviewDetailButton4:(id)sender;

// X, O 버튼
- (IBAction)leftXOButton:(id)sender;
- (IBAction)rightXOButton:(id)sender;

- (IBAction)backButton:(id)sender;

- (IBAction)latteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *topMyLabel;
@property (weak, nonatomic) IBOutlet UILabel *topAvrLabel;

@end
