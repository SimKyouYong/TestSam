//
//  CommonTableView.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 29..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableView : UIView<UITableViewDelegate, UITableViewDataSource>{
    UITableView *commonTableView;
    
    NSMutableArray *checkRow;
    NSMutableArray *gidArray;
}

- (id)initWithFrame:(CGRect)frame;

@end
