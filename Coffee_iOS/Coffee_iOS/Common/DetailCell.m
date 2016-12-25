//
//  DetailCell.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "DetailCell.h"
#import "GlobalHeader.h"

@implementation DetailCell

@synthesize contentText;
@synthesize contentTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        contentTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH_FRAME - 20, 30)];
        [contentTitle setBackgroundColor:[UIColor clearColor]];
        contentTitle.textColor = [UIColor redColor];
        contentTitle.textAlignment = NSTextAlignmentCenter;
        contentTitle.numberOfLines = 0;
        contentTitle.font = [UIFont fontWithName:@"Helvetica" size:20.0];
        //contentTitle.text = @"title";
        [self addSubview:contentTitle];

        contentText = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, WIDTH_FRAME - 20, 50)];
        [contentText setBackgroundColor:[UIColor clearColor]];
        contentText.textColor = [UIColor blackColor];
        contentText.textAlignment = NSTextAlignmentLeft;
        contentText.numberOfLines = 0;
        contentText.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:contentText];
    }
    return self;
}

@end
