//
//  MenualReviewLatteVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "MenualReviewLatteVC.h"
#import "GlobalHeader.h"

@interface MenualReviewLatteVC ()

@end

@implementation MenualReviewLatteVC

@synthesize menualReviewLatteScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [menualReviewLatteScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 580)];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"latte_push"])
    {
        
    }
}

- (IBAction)americanoButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)detailLeftButton:(id)sender {
    [self performSegueWithIdentifier:@"latte_push" sender:sender];
}

- (IBAction)detailRightButton:(id)sender {
    [self performSegueWithIdentifier:@"latte_push" sender:sender];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
