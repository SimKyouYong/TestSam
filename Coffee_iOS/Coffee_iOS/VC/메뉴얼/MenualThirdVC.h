//
//  MenualThirdVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenualThirdVC : UIViewController<UIActionSheetDelegate>{
    NSUserDefaults *defaults;
    NSArray *datas;
    NSArray *datas2;
    
    NSInteger actionSheetNum;
    NSMutableArray *actionArr;
    
    NSDictionary *tableDic;
    
    NSInteger fix_position;
}

- (IBAction)homeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *menualThirdScrollView;

@property (weak, nonatomic) IBOutlet UILabel *topTitle;

- (IBAction)americanoButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
- (IBAction)nextButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *coffeenessButton;
- (IBAction)coffeenessButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *balanceButton;
- (IBAction)balanceButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sweetnessButton;
- (IBAction)sweetnessButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bodyButton;
- (IBAction)bodyButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
