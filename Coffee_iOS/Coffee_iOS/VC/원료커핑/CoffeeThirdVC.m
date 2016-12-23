//
//  CoffeeThirdVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CoffeeThirdVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface CoffeeThirdVC ()

@end

@implementation CoffeeThirdVC

@synthesize coffeeThirdScrollView;

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
    
    [coffeeThirdScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 400)];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"coffee4"])
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

- (IBAction)nextButton:(id)sender {
    [self performSegueWithIdentifier:@"coffee4" sender:sender];
}

- (IBAction)pimaryButton:(id)sender {
}

- (IBAction)secondaryButton:(id)sender {
}



@end
