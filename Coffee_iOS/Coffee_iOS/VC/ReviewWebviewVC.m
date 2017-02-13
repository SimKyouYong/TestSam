//
//  ReviewWebviewVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2017. 1. 8..
//  Copyright © 2017년 JC1_Joseph. All rights reserved.
//

#import "ReviewWebviewVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface ReviewWebviewVC ()

@end

@implementation ReviewWebviewVC

@synthesize sampleWebview;
@synthesize sampleIdx;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%@", SAMPLE_WEB_URL, USER_ID, sampleIdx];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [sampleWebview loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
