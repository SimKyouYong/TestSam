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
@synthesize vi;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        contentTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, WIDTH_FRAME - 30, 30)];
        [contentTitle setBackgroundColor:[UIColor clearColor]];
        contentTitle.textColor = [UIColor redColor];
        contentTitle.textAlignment = NSTextAlignmentCenter;
        contentTitle.numberOfLines = 0;
        contentTitle.font = [UIFont fontWithName:@"Helvetica" size:20.0];
        [self addSubview:contentTitle];

        contentText = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, WIDTH_FRAME - 20, 50)];
        [contentText setBackgroundColor:[UIColor clearColor]];
        contentText.textColor = [UIColor blackColor];
        contentText.textAlignment = NSTextAlignmentLeft;
        contentText.numberOfLines = 0;
        contentText.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:contentText];
        
        vi = [[UIView alloc] initWithFrame:CGRectMake(10, 30, WIDTH_FRAME - 20, 20)];
        vi.backgroundColor = [UIColor blackColor];

        [self addSubview:vi];
        
    }
    return self;
}

@end
