//
//  CoffeeFirstVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleVC : UIViewController<UIActionSheetDelegate>
{
    NSUserDefaults *defaults;
    
    NSInteger box_position;
    NSString *total;
    NSArray *datas;
}

@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UILabel *centerText;
@property (weak, nonatomic) IBOutlet UILabel *leftText;
@property (weak, nonatomic) IBOutlet UILabel *rightText;

- (IBAction)homeButton:(id)sender;
- (IBAction)selectButton:(id)sender;

@end
