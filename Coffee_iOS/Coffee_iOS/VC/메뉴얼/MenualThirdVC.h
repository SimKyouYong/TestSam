//
//  MenualThirdVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenualThirdVC : UIViewController{
    NSDictionary *tableDic;
}

@property (weak, nonatomic) IBOutlet UIScrollView *menualThirdScrollView;

- (IBAction)americanoButton:(id)sender;
- (IBAction)saveButton:(id)sender;

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
