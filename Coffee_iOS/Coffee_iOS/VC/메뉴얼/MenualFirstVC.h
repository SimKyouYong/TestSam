//
//  MenualFirstVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNExpandableTableView.h"

@interface MenualFirstVC : UIViewController

@property (weak, nonatomic) IBOutlet JNExpandableTableView *menualFirstTableView;

- (IBAction)homeButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)nextButton:(id)sender;
- (IBAction)latteButton:(id)sender;

@end
