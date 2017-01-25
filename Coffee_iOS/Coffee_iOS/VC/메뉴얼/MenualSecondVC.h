//
//  MenualSecondVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenualSecondVC : UIViewController<UIActionSheetDelegate>{
    NSUserDefaults *defaults;
    NSArray *datas;
    NSArray *datas2;
    
    NSString *mSample_idx;
    
    NSDictionary *tableDic;
    
    BOOL mOkNotokflag;
    
    NSString *mTotalScore;
}

@property (weak, nonatomic) IBOutlet UIScrollView *menualSecondScrollView;

@property (weak, nonatomic) IBOutlet UILabel *toptitle;

- (IBAction)homeButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
- (IBAction)latteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *acidityButton;
@property (weak, nonatomic) IBOutlet UIButton *sweetnessButton;
@property (weak, nonatomic) IBOutlet UIButton *bitternessButton;
@property (weak, nonatomic) IBOutlet UIButton *bodyButton;
@property (weak, nonatomic) IBOutlet UIButton *aftertasteButton;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (weak, nonatomic) IBOutlet UILabel *myTotalScore;


@end
