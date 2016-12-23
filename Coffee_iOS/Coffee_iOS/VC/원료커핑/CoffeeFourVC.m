//
//  CoffeeFourVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CoffeeFourVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface CoffeeFourVC ()

@end

@implementation CoffeeFourVC

@synthesize coffeeFourScrollView;

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
    
    [coffeeFourScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 850)];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark -
#pragma mark Button Action

- (IBAction)saveButton:(id)sender {
}

- (IBAction)prevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
