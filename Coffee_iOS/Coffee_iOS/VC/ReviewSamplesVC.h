//
//  ReviewSamplesVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2017. 1. 1..
//  Copyright © 2017년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewSamplesVC : UIViewController{
    NSMutableArray *tableList;
    NSInteger tab_position;
    
    NSString *nextIdx;
}

@property (weak, nonatomic) IBOutlet UITableView *reviewSamplesTableView;

- (IBAction)backButton:(id)sender;
- (IBAction)linkButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tab1Button;
- (IBAction)tab1Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tab2Button;
- (IBAction)tab2Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tab3Button;
- (IBAction)tab3Button:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *linkWebView;
- (IBAction)linkWebViewCloseButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
