//
//  CoffeeFirstVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 22..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNExpandableTableView.h"
#import "CommonTableView.h"
#import "PopupView.h"

@interface CoffeeFirstVC : UIViewController<CommonTableViewDelegate, UIActionSheetDelegate>{
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
}

@property (weak, nonatomic) IBOutlet JNExpandableTableView *coffeeFirstTableView;

- (IBAction)homeButton:(id)sender;
- (IBAction)secondaryButton:(id)sender;
- (IBAction)tertiaryButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)nextButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *aromaButton;
- (IBAction)aromaButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *flavorButton;
- (IBAction)flavorButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *acidityButton;
- (IBAction)acidityButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
