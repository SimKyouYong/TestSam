//
//  HomeCell.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell{
    UILabel *titleText;
    UILabel *comentText;
    UILabel *timeText;
    UILabel *placeText;
    
    UIButton *sampleButton;
    UIButton *cuppingButton;
    UIButton *reviewButton;
}

@property (nonatomic) UILabel *titleText;
@property (nonatomic) UILabel *comentText;
@property (nonatomic) UILabel *timeText;
@property (nonatomic) UILabel *placeText;

@property (nonatomic) UIButton *sampleButton;
@property (nonatomic) UIButton *cuppingButton;
@property (nonatomic) UIButton *reviewButton;

@end
