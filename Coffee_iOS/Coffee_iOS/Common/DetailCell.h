//
//  DetailCell.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell{
    UILabel *contentTitle;
    UILabel *contentText;
}

@property (nonatomic) UILabel *contentTitle;
@property (nonatomic) UILabel *contentText;

@end
