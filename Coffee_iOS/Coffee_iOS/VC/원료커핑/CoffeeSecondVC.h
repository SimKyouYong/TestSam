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

@property (weak, nonatomic) IBOutlet JNExpandableTableView *coffeeSecondTableView;

- (IBAction)saveButton:(id)sender;
- (IBAction)prevButton:(id)sender;
- (IBAction)nextButton:(id)sender;
- (IBAction)pimaryButton:(id)sender;
- (IBAction)tertiaryButton:(id)sender;

@end
