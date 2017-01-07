//
//  CoffeeSecondVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNExpandableTableView.h"

@interface CoffeeSecondVC : UIViewController
{
    NSUserDefaults *defaults;
    NSArray *datas;
    NSArray *datas2;
    
    int mPosition;
    NSString *mSample_idx;
    
    NSDictionary *tableDic;
}
@property (weak, nonatomic) IBOutlet JNExpandableTableView *coffeeSecondTableView;

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
