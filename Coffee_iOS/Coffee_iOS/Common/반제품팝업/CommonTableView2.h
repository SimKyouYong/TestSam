//
//  CommonTableView2.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 29..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommonTableViewDelegate2 <NSObject>
@required
- (void)cancelButton;
- (void)submitButton:(NSString*)value name:(NSString*)name;
@end

@interface CommonTableView2 : UIView<UITableViewDelegate, UITableViewDataSource>{
    UITableView *commonTableView;
    
    NSMutableArray *listArr;
    NSMutableArray *checkRow;
    NSMutableArray *gidArray;
    
    NSString *dataNameStr;
    NSString *valueNameStr;
}

@property (assign, nonatomic) id<CommonTableViewDelegate2> delegate;

// dataName - 하드코딩된 값 불러오기 위한 값
// valueName - 서버에서 가져온 값(팝업창에서 선택하기 위해서)
- (id)initWithFrame:(CGRect)frame dataName:(NSString*)dataName valueName:(NSString*)valueName;

@end
