//
//  HalfProductSecondVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HalfProductSecondVC : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *halfSecondScrollView;
@property (weak, nonatomic) IBOutlet UITextView *halfSecondTextView;

- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;

@end
