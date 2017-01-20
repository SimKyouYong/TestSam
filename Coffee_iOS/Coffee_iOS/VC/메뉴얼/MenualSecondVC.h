//
//  MenualSecondVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenualSecondVC : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *menualSecondScrollView;

- (IBAction)homeButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
- (IBAction)latteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
