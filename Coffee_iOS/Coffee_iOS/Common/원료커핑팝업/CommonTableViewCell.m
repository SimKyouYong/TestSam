//
//  CommonTableViewCell.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 29..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "GlobalHeader.h"

@implementation CommonTableViewCell

@synthesize titleText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        titleText = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, WIDTH_FRAME - 120, 40)];
        [titleText setBackgroundColor:[UIColor clearColor]];
        titleText.textColor = [UIColor blackColor];
        titleText.textAlignment = NSTextAlignmentLeft;
        titleText.numberOfLines = 0;
        titleText.font = [UIFont fontWithName:@"Helvetica" size:20.0];
        [self addSubview:titleText];
    }
    return self;
}

@end
