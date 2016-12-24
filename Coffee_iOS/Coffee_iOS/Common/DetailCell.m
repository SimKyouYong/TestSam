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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        contentText = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH_FRAME - 20, 100)];
        [contentText setBackgroundColor:[UIColor clearColor]];
        contentText.textColor = [UIColor blackColor];
        contentText.textAlignment = NSTextAlignmentLeft;
        contentText.numberOfLines = 0;
        contentText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:contentText];
    }
    return self;
}

@end
