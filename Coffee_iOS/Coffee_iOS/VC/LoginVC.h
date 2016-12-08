//
//  LoginVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController{
    NSUserDefaults *defaults;
}

@property (weak, nonatomic) IBOutlet UITextField *empText;
@property (weak, nonatomic) IBOutlet UITextField *PassText;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;

- (IBAction)autoLogin:(id)sender;
- (IBAction)loginButton:(id)sender;

@end
