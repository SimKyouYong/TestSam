//
//  CoffeeSecondVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNExpandableTableView.h"
#import "CommonTableView.h"
#import "PopupView.h"

@interface CoffeeSecondVC : UIViewController<UIActionSheetDelegate, CommonTableViewDelegate>{
    CommonTableView *commonTableView;
    PopupView *popupView;
    
    NSUserDefaults *defaults;
    NSArray *datas;
    NSArray *datas2;
    
    int mPosition;
    NSString *mSample_idx;
    
    NSDictionary *tableDic;
    
    NSInteger actionSheetNum;
    NSMutableArray *actionArr;
    
    // 실제 사용할 데이터
    NSString *mTotalAftertaste_Po;
    NSString *mTotalAftertaste_Ne;
    
    NSString *mTotalBody_Li;
    NSString *mTotalBody_Me;
    NSString *mTotalBody_He;
    
    NSString *mTotalBalance_Po;
    NSString *mTotalBalance_Ne;
    // TableCell Text Value
    UILabel *TotalAftertaste_Po;
    UILabel *TotalAftertaste_Ne;
    
    UILabel *TotalBody_Li;
    UILabel *TotalBody_Me;
    UILabel *TotalBody_He;
    
    UILabel *TotalBalance_Po;
    UILabel *TotalBalance_Ne;
}
@property (weak, nonatomic) IBOutlet JNExpandableTableView *coffeeSecondTableView;
@property (weak, nonatomic) IBOutlet UILabel *toptitle;

- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
- (IBAction)nextButton:(id)sender;
- (IBAction)pimaryButton:(id)sender;
- (IBAction)tertiaryButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *aftertasteButton;
- (IBAction)aftertasteButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bodyButton;
- (IBAction)bodyButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *balanceButton;
- (IBAction)balanceButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *overallButton;
- (IBAction)overallButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
