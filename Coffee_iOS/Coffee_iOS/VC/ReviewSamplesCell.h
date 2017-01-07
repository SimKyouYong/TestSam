//
//  ReviewSamplesCell.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2017. 1. 1..
//  Copyright © 2017년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewSamplesCell : UITableViewCell{
    UILabel *titleText;
    UILabel *comentText;
    UILabel *timeText;
    UILabel *placeText;
    
    UILabel *leftLabel;
    UIButton *cuppingButton;
    UIButton *reviewButton;
}

@property (nonatomic) UILabel *leftLabel;
@property (nonatomic) UILabel *titleText;
@property (nonatomic) UILabel *comentText;
@property (nonatomic) UILabel *timeText;
@property (nonatomic) UILabel *placeText;

@property (nonatomic) UIButton *cuppingButton;
@property (nonatomic) UIButton *reviewButton;

@end
