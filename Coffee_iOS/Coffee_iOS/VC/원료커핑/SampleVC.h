//
//  CoffeeFirstVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleVC : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSUserDefaults *defaults;
    
    int box_position;
    int picker_position;
    NSString *total;
    NSArray *datas;
    UIButton *btn_1;
    UIButton *btn_2;
    UIButton *btn_3;
    UITextView *txt;

}
@property (nonatomic) IBOutlet UITextView *txt;      //본문
@property (nonatomic) IBOutlet UIButton *btn_1;      //Button_1~3 Same(copy)
@property (nonatomic) IBOutlet UIButton *btn_2;      //Button_~3 Same(copy)
@property (nonatomic) IBOutlet UIButton *btn_3;      //Button_~3 Same(copy)
@property (nonatomic) IBOutlet UIPickerView *box;    //Select box

- (IBAction)homeButton:(id)sender;
- (IBAction)slectChoiceButton:(id)sender;


@end
