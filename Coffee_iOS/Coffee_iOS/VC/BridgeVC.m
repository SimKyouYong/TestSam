//
//  BridgeVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "BridgeVC.h"

@interface BridgeVC ()

@end

@implementation BridgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"home_push"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)startCuppingButton:(id)sender {
    [self performSegueWithIdentifier:@"home_push" sender:sender];
}

- (IBAction)reviewSamplesButton:(id)sender {
}
@end
