//
//  CoffeeFirstVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 22..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNExpandableTableView.h"
#import "PopupView.h"

@interface CoffeeFirstVC : UIViewController<UIActionSheetDelegate, UIGestureRecognizerDelegate>{
    PopupView *popupView;

    NSUserDefaults *defaults;
    NSArray *datas;
    NSArray *datas2;

    NSString *mSample_idx;
    
    NSDictionary *tableDic;
    
    NSInteger actionSheetNum;
    NSMutableArray *actionArr;
    
    NSMutableArray *listArr;
    
    // 실제 사용할 데이터
    NSString *mTotalFloral;
    NSString *mTotalFruity;
    NSString *mTotalAlcoholic;
    NSString *mTotalHerb;
    NSString *mTotalSpice;
    NSString *mTotalSweet;
    NSString *mTotalNut;
    NSString *mTotalChocolate;
    NSString *mTotalGrain;
    NSString *mTotalRoast;
    NSString *mTotalSavory;
    
    NSString *mTotalFermented;
    NSString *mTotalChemical;
    NSString *mTotalGreen;
    NSString *mTotalMusty;
    NSString *mTotalRoastdefect;
    
    NSString *mTotalAcidity_Po;
    NSString *mTotalAcidity_Ne;
    // TableCell Text Value
    UILabel *TotalFloral;
    UILabel *TotalFruity;
    UILabel *TotalAlcoholic;
    UILabel *TotalHerb;
    UILabel *TotalSpice;
    UILabel *TotalSweet;
    UILabel *TotalNut;
    UILabel *TotalChocolate;
    UILabel *TotalGrain;
    UILabel *TotalRoast;
    UILabel *TotalSavory;
    
    UILabel *TotalFermented;
    UILabel *TotalChemical;
    UILabel *TotalGreen;
    UILabel *TotalMusty;
    UILabel *TotalRoastdefect;
    
    UILabel *TotalAcidity_Po;
    UILabel *TotalAcidity_Ne;
    
    int fix_position;
}

@property (weak, nonatomic) IBOutlet JNExpandableTableView *coffeeFirstTableView;

- (IBAction)homeButton:(id)sender;
- (IBAction)secondaryButton:(id)sender;
- (IBAction)tertiaryButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)nextButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *toptitle;

@property (weak, nonatomic) IBOutlet UIButton *aromaButton;
- (IBAction)aromaButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *flavorButton;
- (IBAction)flavorButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *acidityButton;
- (IBAction)acidityButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
