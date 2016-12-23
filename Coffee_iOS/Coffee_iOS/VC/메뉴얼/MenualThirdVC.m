//
//  MenualThirdVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "MenualThirdVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface MenualThirdVC ()

@end

@implementation MenualThirdVC

@synthesize menualThirdScrollView;

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
    
    [menualThirdScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 440)];
}

#pragma mark -
#pragma mark Button Action

- (IBAction)americanoButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButton:(id)sender {
}

@end
