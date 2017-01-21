//
//  CoffeeThirdVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeeThirdVC : UIViewController<UIActionSheetDelegate>
{
    NSUserDefaults *defaults;
    NSArray *datas;
    NSArray *datas2;
    
    NSString *mSample_idx;
}
@property (weak, nonatomic) IBOutlet UIScrollView *coffeeThirdScrollView;

- (IBAction)homeButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
- (IBAction)nextButton:(id)sender;
- (IBAction)pimaryButton:(id)sender;
- (IBAction)secondaryButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *toptitle;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (weak, nonatomic) IBOutlet UIButton *cup1;
- (IBAction)cup1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup2;
- (IBAction)cup2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup3;
- (IBAction)cup3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup4;
- (IBAction)cup4:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup5;
- (IBAction)cup5:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup6;
- (IBAction)cup6:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup7;
- (IBAction)cup7:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup8;
- (IBAction)cup8:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup9;
- (IBAction)cup9:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup10;
- (IBAction)cup10:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup11;
- (IBAction)cup11:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup12;
- (IBAction)cup12:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup13;
- (IBAction)cup13:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup14;
- (IBAction)cup14:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cup15;
- (IBAction)cup15:(id)sender;

@end
