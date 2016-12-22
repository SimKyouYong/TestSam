//
//  HalfProductFirstVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "HalfProductFirstVC.h"

@interface HalfProductFirstVC ()

@end

@implementation HalfProductFirstVC

@synthesize halfFirstScrollView;
@synthesize acidityButton;
@synthesize sweetnessButton;
@synthesize bitternessButton;
@synthesize bodyButton;
@synthesize balanceButton;
@synthesize aftertasteButton;
@synthesize poButton;
@synthesize neButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"product2"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButton:(id)sender {
}

- (IBAction)nextButton:(id)sender {
    [self performSegueWithIdentifier:@"product2" sender:sender];
}

- (IBAction)acidityButton:(id)sender {
    [self actionSheetInit:0];
}

- (IBAction)sweetnessButton:(id)sender {
    [self actionSheetInit:1];
}

- (IBAction)bitternessButton:(id)sender {
    [self actionSheetInit:2];
}

- (IBAction)bodyButton:(id)sender {
    [self actionSheetInit:3];
}

- (IBAction)balanceButton:(id)sender {
    [self actionSheetInit:4];
}

- (IBAction)aftertasteButton:(id)sender {
    [self actionSheetInit:5];
}

- (IBAction)poButton:(id)sender {
    [self actionSheetInit:6];
}

- (IBAction)neButton:(id)sender {
    [self actionSheetInit:7];
}

#pragma mark -
#pragma mark ActionSheet Value Setting

- (void)actionSheetInit:(NSInteger)indexNum{
    actionSheetSettingValue = indexNum;
    
    numberArr = [NSArray arrayWithObjects: @"0.0",@"0.5",@"1.0",@"1.5",@"2.0",@"2.5",@"3.0",@"3.5",@"4.0",@"4.5",@"5.0", nil];

    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"색상을 선택해주세요.";
    menu.delegate = self;

    for(int i = 0; i < [numberArr count]; i++){
        [menu addButtonWithTitle:[numberArr objectAtIndex:i]];
    }
    
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(6 == buttonIndex){
        return;
    }
    
    switch (actionSheetSettingValue) {
        case 0:
            [acidityButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 1:
            [sweetnessButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 2:
            [bitternessButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 3:
            [bodyButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 4:
            [balanceButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 5:
            [aftertasteButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 6:
            [poButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        case 7:
            [neButton setTitle:[numberArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

@end
