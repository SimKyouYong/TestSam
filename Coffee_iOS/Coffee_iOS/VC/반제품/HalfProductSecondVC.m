//
//  HalfProductSecondVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HalfProductSecondVC.h"
#import "GlobalHeader.h"

@interface HalfProductSecondVC ()

@end

@implementation HalfProductSecondVC

@synthesize halfSecondScrollView;
@synthesize halfSecondTextView;

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
    
    [halfSecondScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 760)];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@""])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)saveButton:(id)sender {
}

- (IBAction)prevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
