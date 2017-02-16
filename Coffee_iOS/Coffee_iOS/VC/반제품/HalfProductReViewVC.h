//
//  HalfProductReViewVC.h
//  Coffee_iOS
//
//  Created by 심규용 on 2016. 12. 18..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HalfProductReViewVC : UIViewController<UIActionSheetDelegate>
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
    
    NSString *mResult_cnt;
    NSString *mFloral;
    NSString *mFruity;
    NSString *mAlcoholic;
    NSString *mHerb;
    NSString *mSpice;
    NSString *mSweet;
    NSString *mNut;
    NSString *mChocolate;
    NSString *mGrain;
    NSString *mRoast;
    NSString *mSavory;
    
    NSString *mFermented;
    NSString *mChemical;
    NSString *mGreen;
    NSString *mMusty;
    NSString *mRoastdefect;
    BOOL mARVflag;

    // 상세뷰로 넘길 값
    NSInteger sampleIndexValue;
    NSInteger detailCount;
    NSInteger buttonCheck;
    
    NSString *mUserID;
}

//점수판..(홀수 : my , 짝수 : 상대방 )
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn1;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn2;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn3;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn4;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn5;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn6;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn7;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn8;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn9;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn10;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn11;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn12;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn13;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn14;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn15;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn16;
@property (weak, nonatomic) IBOutlet UILabel *Title;

//맨위에 3개 상단 점수
@property (weak, nonatomic) IBOutlet UILabel *mDetail4ArvScore;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4StdScore;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4TotalScore;

@property (weak, nonatomic) IBOutlet UIScrollView *halfScrollView;
@property (weak, nonatomic) NSMutableArray *tableList_;

//버튼 - 평가보기, 총평(홀수 : my , 짝수 : 상대방 )
- (IBAction)reviewDetailButton1:(id)sender;
- (IBAction)reviewDetailButton2:(id)sender;
- (IBAction)reviewDetailButton3:(id)sender;
- (IBAction)reviewDetailButton4:(id)sender;

- (IBAction)passButton:(id)sender;
- (IBAction)retestButton:(id)sender;
- (IBAction)backButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *topMyLabel;
@property (weak, nonatomic) IBOutlet UILabel *topAvrLabel;

@property (weak, nonatomic) IBOutlet UIButton *LB;
@property (weak, nonatomic) IBOutlet UIButton *RB;

@property (nonatomic) NSString  *isReviewValue;

@end
