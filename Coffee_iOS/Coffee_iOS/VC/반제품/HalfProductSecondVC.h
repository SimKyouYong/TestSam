//
//  HalfProductSecondVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HalfProductSecondVC : UIViewController
{
    NSUserDefaults *defaults;
    NSArray *datas;
    NSArray *datas2;
    
    int mPosition;
    NSString *mSample_idx;
    
    NSDictionary *tableDic;
    
    NSInteger actionSheetNum;
    NSMutableArray *actionArr;

}
@property (weak, nonatomic) IBOutlet UIScrollView *halfSecondScrollView;
@property (weak, nonatomic) IBOutlet UITextView *halfSecondTextView;

- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *toptitle;


@property (weak, nonatomic) IBOutlet UIButton *acidityButton;
- (IBAction)acidityButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sweetnessButton;
- (IBAction)sweetnessButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *bitternessButton;
- (IBAction)bitternessButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *bodyButton;
- (IBAction)bodyButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *balanceButton;
- (IBAction)balanceButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *aftertasteButton;
- (IBAction)aftertasteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *poButton;
- (IBAction)poButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *neButton;
- (IBAction)neButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;


@end
