//
//  CoffeeFourVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeeFourVC : UIViewController
{
    NSUserDefaults *defaults;
    NSArray *datas;
    NSArray *datas2;
    
    int mPosition;
    NSString *mSample_idx;
}

@property (weak, nonatomic) IBOutlet UIScrollView *coffeeFourScrollView;

@property (weak, nonatomic) IBOutlet UIButton *aromaButton;
@property (weak, nonatomic) IBOutlet UIButton *flavorButton;
@property (weak, nonatomic) IBOutlet UIButton *acidityButton;

@property (weak, nonatomic) IBOutlet UIButton *aftertasteButton;
@property (weak, nonatomic) IBOutlet UIButton *bodyButton;
@property (weak, nonatomic) IBOutlet UIButton *balanceButton;
@property (weak, nonatomic) IBOutlet UIButton *overallButton;

@property (weak, nonatomic) IBOutlet UIButton *cup1;
@property (weak, nonatomic) IBOutlet UIButton *cup2;
@property (weak, nonatomic) IBOutlet UIButton *cup3;
@property (weak, nonatomic) IBOutlet UIButton *cup4;
@property (weak, nonatomic) IBOutlet UIButton *cup5;
@property (weak, nonatomic) IBOutlet UIButton *cup6;
@property (weak, nonatomic) IBOutlet UIButton *cup7;
@property (weak, nonatomic) IBOutlet UIButton *cup8;
@property (weak, nonatomic) IBOutlet UIButton *cup9;
@property (weak, nonatomic) IBOutlet UIButton *cup10;
@property (weak, nonatomic) IBOutlet UIButton *cup11;
@property (weak, nonatomic) IBOutlet UIButton *cup12;
@property (weak, nonatomic) IBOutlet UIButton *cup13;
@property (weak, nonatomic) IBOutlet UIButton *cup14;
@property (weak, nonatomic) IBOutlet UIButton *cup15;

- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
- (IBAction)okButton:(id)sender;
- (IBAction)notOkButton:(id)sender;

@end
