//
//  ReviewWebviewVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2017. 1. 8..
//  Copyright © 2017년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewWebviewVC : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *sampleWebview;

- (IBAction)backButton:(id)sender;

@property (nonatomic) NSString  *sampleIdx;

@end
