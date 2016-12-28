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

@interface CoffeeFirstVC : UIViewController{
    CommonTableView *commonTableView;
}

@property (weak, nonatomic) IBOutlet JNExpandableTableView *coffeeFirstTableView;

- (IBAction)homeButton:(id)sender;
- (IBAction)secondaryButton:(id)sender;
- (IBAction)tertiaryButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)nextButton:(id)sender;



@end
