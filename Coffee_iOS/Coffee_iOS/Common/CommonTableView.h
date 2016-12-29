//
//  CommonTableView.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 29..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommonTableViewDelegate <NSObject>
@required
- (void)cancelButton;
- (void)submitButton:(NSString*)value;
@end

@interface CommonTableView : UIView<UITableViewDelegate, UITableViewDataSource>{
    UITableView *commonTableView;
    
    NSMutableArray *checkRow;
    NSMutableArray *gidArray;
}

@property (assign, nonatomic) id<CommonTableViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

@end
