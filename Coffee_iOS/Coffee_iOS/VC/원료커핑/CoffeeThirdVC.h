//
//  CoffeeThirdVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeeThirdVC : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *coffeeThirdScrollView;
- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
- (IBAction)nextButton:(id)sender;
- (IBAction)pimaryButton:(id)sender;
- (IBAction)secondaryButton:(id)sender;

@end
