//
//  CoffeReViewVC.h
//  Coffee_iOS
//
//  Created by 심규용 on 2016. 12. 17..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeReViewVC : UIViewController
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
}

@property (weak, nonatomic) IBOutlet UIScrollView *coffeeReviewScrollView;
//추가

@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;
@property (weak, nonatomic) IBOutlet UIButton *mNOTOKBtn;
@property (weak, nonatomic) IBOutlet UILabel *Title;


@property (weak, nonatomic) IBOutlet UIButton *mDetail4Btn0;        //맨위에 점수판


//맨위에 3개 상단 점수
@property (weak, nonatomic) IBOutlet UILabel *mDetail4ArvScore;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4StdScore;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4TotalScore;


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
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn17;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn18;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn19;
@property (weak, nonatomic) IBOutlet UILabel *mDetail4Btn20;

//커피 이미지 my
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn1_1;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn1_2;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn1_3;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn1_4;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn1_5;
//커피 이미지 상대방
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn2_1;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn2_2;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn2_3;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn2_4;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn2_5;

//커피 이미지 my
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn3_1;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn3_2;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn3_3;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn3_4;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn3_5;

//커피 이미지 상대방
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn4_1;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn4_2;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn4_3;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn4_4;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn4_5;

//커피 이미지 my
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn5_1;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn5_2;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn5_3;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn5_4;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn5_5;

//커피 이미지 상대방
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn6_1;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn6_2;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn6_3;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn6_4;
@property (weak, nonatomic) IBOutlet UIImageView *mDetail4Btn6_5;



- (IBAction)mOkBtn:(id)sender;
- (IBAction)mNOTOKBtn:(id)sender;






- (IBAction)backButton:(id)sender;

@end
