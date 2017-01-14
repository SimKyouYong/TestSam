//
//  MenualFirstVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNExpandableTableView.h"

@interface MenualFirstVC : UIViewController{
    NSDictionary *tableDic;
    
    // 실제 사용할 데이터
    NSString *mTotalFloral;
    NSString *mTotalFruity;
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
    
    NSString *mTotalAftertaste_Po;
    NSString *mTotalAftertaste_Ne;
    
    NSString *mTotalBody_Li;
    NSString *mTotalBody_Me;
    NSString *mTotalBody_He;
    
    NSString *mTotalBalance_Po;
    NSString *mTotalBalance_Ne;
    
    NSString *mTotalMouthfeel_Po;
    NSString *mTotalMouthfeel_Ne;
    
    // TableCell Text Value
    UILabel *TotalFloral;
    UILabel *TotalFruity;
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
    
    UILabel *TotalAftertaste_Po;
    UILabel *TotalAftertaste_Ne;
    
    UILabel *TotalBody_Li;
    UILabel *TotalBody_Me;
    UILabel *TotalBody_He;
    
    UILabel *TotalBalance_Po;
    UILabel *TotalBalance_Ne;
    
    UILabel *TotalMouthfeel_Po;
    UILabel *TotalMouthfeel_Ne;
}

@property (weak, nonatomic) IBOutlet JNExpandableTableView *menualFirstTableView;

- (IBAction)homeButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)nextButton:(id)sender;
- (IBAction)latteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *acidityButton;
- (IBAction)acidityButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sweetnessButton;
- (IBAction)sweetnessButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bitternessButton;
- (IBAction)bitternessButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bodyButton;
- (IBAction)bodyButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aftertasteButton;
- (IBAction)aftertasteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
