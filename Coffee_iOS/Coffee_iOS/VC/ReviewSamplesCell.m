//
//  ReviewSamplesCell.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2017. 1. 1..
//  Copyright © 2017년 JC1_Joseph. All rights reserved.
//

#import "ReviewSamplesCell.h"
#import "GlobalHeader.h"

@implementation ReviewSamplesCell

@synthesize titleText;
@synthesize comentText;
@synthesize timeText;
@synthesize placeText;

@synthesize leftLabel;
@synthesize reviewButton;
@synthesize reportButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, WIDTH_FRAME - 20, 116)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        titleText = [[UILabel alloc] initWithFrame:CGRectMake(20, 16, 200, 18)];
        [titleText setBackgroundColor:[UIColor clearColor]];
        titleText.textColor = [UIColor blackColor];
        titleText.textAlignment = NSTextAlignmentLeft;
        titleText.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        [self addSubview:titleText];
        
        comentText = [[UILabel alloc] initWithFrame:CGRectMake(20, 36, 200, 18)];
        [comentText setBackgroundColor:[UIColor clearColor]];
        comentText.textColor = [UIColor blackColor];
        comentText.textAlignment = NSTextAlignmentLeft;
        comentText.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        [self addSubview:comentText];
        
        timeText = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 18, 100, 12)];
        [timeText setBackgroundColor:[UIColor clearColor]];
        timeText.textColor = [UIColor grayColor];
        timeText.textAlignment = NSTextAlignmentRight;
        timeText.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:timeText];
        
        placeText = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 34, 100, 12)];
        [placeText setBackgroundColor:[UIColor clearColor]];
        placeText.textColor = [UIColor grayColor];
        placeText.textAlignment = NSTextAlignmentRight;
        placeText.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:placeText];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, WIDTH_FRAME - 40, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:lineView];
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, (WIDTH_FRAME - 20)/3, 34)];
        [leftLabel setBackgroundColor:[UIColor clearColor]];
        leftLabel.textColor = [UIColor grayColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.text = @"TESTER : 1";
        leftLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [self addSubview:leftLabel];
        
        reviewButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_FRAME - 20)/3 + 10, 75, (WIDTH_FRAME - 20)/3, 34)];
        [reviewButton setImage:[UIImage imageNamed:@"review_button_226x68.png"] forState:UIControlStateNormal];
        [self addSubview:reviewButton];
        
        reportButton = [[UIButton alloc] initWithFrame:CGRectMake(((WIDTH_FRAME - 20)/3)*2 + 10, 75, (WIDTH_FRAME - 20)/3, 34)];
        [reportButton setImage:[UIImage imageNamed:@"report_button_226x68.png"] forState:UIControlStateNormal];
        [self addSubview:reportButton];
    }
    return self;
}

@end
